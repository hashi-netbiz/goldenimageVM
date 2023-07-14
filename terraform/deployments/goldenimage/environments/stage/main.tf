terraform {
  required_version = "1.4.6"

  backend "azurerm" {
    resource_group_name  = "azure-storage-explorer"
    storage_account_name = "webtfstatesa"
    container_name       = "tfstate-dev"
    #key                  = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.37.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "2.3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~>4.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.0.0"
    }
  }
}

# provider "azurerm" {
#   features {}
# }

provider "azurerm" {
  features {}
  
  subscription_id = var.ARM_SUBSCRIPTION_ID
  client_id       = var.ARM_CLIENT_ID
  client_secret   = var.ARM_CLIENT_SECRET
  tenant_id       = var.ARM_TENANT_ID
}

provider "vault" {
  address = var.VAULT_ADDR
  token   = var.VAULT_TOKEN
}

data "azurerm_shared_image_version" "img" {
  name                = var.image_version
  image_name          = var.image_name
  gallery_name        = var.image_gallery
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "vm_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

data "vault_generic_secret" "vmuser_cred" {
  path = var.vault_vmuser_secret_path
}

# Data template cloud-init bootstrapping file
data "local_file" "cloudinit" {
  filename = "../cloudinit.conf"
}

# Create (and display) an SSH key
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

module "network-interface" {
  source              = "../modules/network-interface"
  vmname              = var.vmname
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.vm_subnet.id
}

module "virtual-machine" {
  depends_on = [ module.network-interface ]

  source                = "../modules/virtual-machine"
  vmname                = var.vmname
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [module.network-interface.nic_id]
  vm_size               = var.vm_size
  os_disk_type          = var.os_disk_type
  admin_username        = data.vault_generic_secret.vmuser_cred.data["username"]
  admin_password        = data.vault_generic_secret.vmuser_cred.data["password"]
  image_id              = data.azurerm_shared_image_version.img.id
  
  # before passing on the custom_data to the vm module, we need to add the context user to the docker group
  customdata_cloudinit = replace(data.local_file.cloudinit.content,"usermod -aG docker VMUSER","usermod -aG docker ${data.vault_generic_secret.vmuser_cred.data["username"]}")
  ssh_public_key       = tls_private_key.ssh_key.public_key_openssh
  environment = var.environment
}

# Push private key back up to vault
resource "vault_generic_secret" "secret" {
  depends_on = [module.virtual-machine]

  path = "secret/sshkeys/${var.environment}/${var.vmname}"

  data_json = jsonencode({
    private_key = tls_private_key.ssh_key.private_key_pem
  })
}