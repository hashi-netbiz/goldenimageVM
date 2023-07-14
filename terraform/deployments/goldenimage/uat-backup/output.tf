# output "vault_address" {
#   description = "url of vault"
#   value       = var.VAULT_ADDR
# }

# output "new_vm_id" {
#   description = "id of the new virtual machine"
#   value       = module.virtual-machine.vm_id
# }

# output "base64userdata" {
#   description = "custom data"
#   value       = module.virtual-machine.vm_customdata
# } 

# output "customdata" {
#   value = replace(data.local_file.cloudinit.content,"usermod -aG docker VMUSER","usermod -aG docker ${var.vmname}")
# }

# output "subs_id" {
#   value = var.ARM_SUBSCRIPTION_ID
# }

output "resource_destroyed" {
  value = module.virtual-machine.resource_destroyed
}