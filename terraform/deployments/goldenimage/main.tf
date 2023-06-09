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
  filename = "${path.module}/cloudinit.conf"
}

# Create (and display) an SSH key
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

module "network-interface" {
  source              = "./modules/network-interface"
  vmname              = var.vmname
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = data.azurerm_subnet.vm_subnet.id
}

module "virtual-machine" {
  source                = "./modules/virtual-machine"
  vmname                = var.vmname
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [module.network-interface.nic_id]
  vm_size               = var.vm_size
  os_disk_type          = var.os_disk_type
  admin_username        = data.vault_generic_secret.vmuser_cred.data["username"]
  admin_password        = data.vault_generic_secret.vmuser_cred.data["password"]
  image_id              = data.azurerm_shared_image_version.img.id

  customdata_cloudinit = data.local_file.cloudinit.content
  ssh_public_key       = tls_private_key.ssh_key.public_key_openssh
}

# # Push private key back up to vault
# resource "vault_generic_secret" "example" {
#   path = var.vault_vmuser_secret_path

#   data_json = <<EOT
# {  
#   "ssh_private_key": ${tls_private_key.ssh_key.private_key_pem}
# }
# EOT
# }

resource "vault_generic_secret" "secret" {
  depends_on = [module.virtual-machine]

  path = var.vault_vmuser_secret_path

  data_json = jsonencode({
    username        = data.vault_generic_secret.vmuser_cred.data["username"]
    password        = data.vault_generic_secret.vmuser_cred.data["password"]
    ssh_private_key = tls_private_key.ssh_key.private_key_pem
  })
}