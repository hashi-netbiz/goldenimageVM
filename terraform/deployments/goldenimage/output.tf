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

output "new_vm_id" {
  description = "id of the new virtual machine"
  value       = module.virtual-machine.vm_id
}

# output "customdata" {
#   value = data.local_file.cloudinit.content
# }

# output "ssh_private_key" {
#   description = "This is the vm private key"
#   value       = tls_private_key.ssh_key.private_key_pem
#   sensitive   = true
# }