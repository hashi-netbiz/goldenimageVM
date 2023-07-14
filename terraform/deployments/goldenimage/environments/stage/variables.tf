variable "resource_group_name" {
  type        = string
  description = "resource group name of the virtual network"
}

variable "location" {
  type        = string
  description = "location of the virtual network"
}

variable "virtual_network_name" {
  type        = string
  description = "name of the virtual network"
}

variable "subnet_name" {
  type        = string
  description = "name of the subnet"
}

variable "vmname" {
  type        = string
  description = "name of the vm"
}

variable "vm_size" {
  type        = string
  description = "size of the virtual machine"
}

variable "os_disk_type" {
  type        = string
  description = "type of the os disk. example Standard_LRS"
}

variable "vault_vmuser_secret_path" {
  type        = string
  description = "vm user credentials"
}

variable "image_version" {
  type        = string
  description = "Azure image version"
}

variable "image_name" {
  type        = string
  description = "Azure image name"
}

variable "image_gallery" {
  type        = string
  description = "Azure image gallery"
}

variable "VAULT_ADDR" {
  type        = string
  description = "address of vault cluster"
}

variable "ARM_SUBSCRIPTION_ID" {
  type        = string
  description = "azure subscription id"
}

variable "ARM_CLIENT_ID" {
  type        = string
  description = "azure client id"
}

variable "ARM_CLIENT_SECRET" {
  type        = string
  description = "azure client secret"
}

variable "ARM_TENANT_ID" {
  type        = string
  description = "azure teneant id"
}

variable "environment" {
  type        = string
  description = "The continuous integration tfvars environment"
}