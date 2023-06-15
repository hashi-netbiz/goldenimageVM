output "vm_id" {
    description = "id of the new virtual machine"
    value = azurerm_linux_virtual_machine.new_vm.id
}

output "vm_customdata" {
    description = "The cloud init base64 encoded data"
    value = base64encode(var.customdata_cloudinit)
}