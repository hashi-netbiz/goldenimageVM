output "vault_address" {
  description = "url of vault"
  value       = var.VAULT_ADDR
}

# output "vault_token" {
#   description = "token to access vault"
#   value       = var.VAULT_TOKEN
# }

# output "vault_namespace" {
#   description = "admin namespace to vault"
#   value       = var.VAULT_NAMESPACE
# }

# output "vm_user_login" {
#     description = "vm user login"
#     value = data.vault_generic_secret.vmuser_cred.data
# }

# output "subnet-id" {
#     description = "subnet to receive vm"
#     value = data.azurerm_subnet.vm_subnet.id
# }

output "new_vm_id" {
  description = "id of the new virtual machine"
  value       = module.virtual-machine.vm_id
}