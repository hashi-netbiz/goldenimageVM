resource_group_name  = "TCW-Stage"
location             = "eastus"
virtual_network_name = "TCW-Stage"
subnet_name          = "TCW-Stage-Frontend"
vmname               = "tcw-stage-web-test"
vm_size              = "Standard_D2_v3"
os_disk_type         = "Standard_LRS"
#admin_username       = "IN VAULT"
#admin_password       = "IN VAULT"
image_version            = "1.2.0"
image_gallery            = "golden_image_gallery_stage"
image_name               = "centos9_stream_golden_image_stage"
vault_vmuser_secret_path = "secret/newsecret"
environment              = "stage"
