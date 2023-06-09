variable "vmname" {
    type = string
    description = "The name of the virtual machine"
}

variable "resource_group_name" {
    type = string
    description = "The name of resource group"
}

variable "location" {
    type = string
    description = "Azure location "
}

variable "network_interface_ids" {
    type = list(string)
    description = "network interface id"
}

variable "vm_size" {
    type = string
    description = "size of the virtual machine"
}

variable "os_disk_type" {
    type = string
    description = "type of the os disk. example Standard_LRS"
}

variable "admin_username" {
    type = string
    description = "local admin user of the virtual machine"
}

variable "admin_password" {
    type = string
    description = "password of the local admin user"
}

variable "image_id" {
    type = string
    description = "Azure shared image id"    
}

variable "customdata_cloudinit" {
    type = string
    description = "cloud init custom data for vm"    
}

variable "ssh_public_key" {
    type = string
    description = "ssh public key for vm"    
}