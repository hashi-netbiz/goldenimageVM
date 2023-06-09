output "vm_id" {
    description = "id of the new virtual machine"
    value = azurerm_linux_virtual_machine.new_vm.id
}