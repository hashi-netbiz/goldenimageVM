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
  # admin_username = var.admin_username
  # admin_password = var.admin_password
  image_id       = data.azurerm_shared_image_version.img.id
}

