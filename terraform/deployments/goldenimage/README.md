## Terraform IAC code to create virtual machine in azure using  the custom centos 9 golden image.

#### 1.0)  The process assumes that the creator has access to the azure subscription and the hashicorp vault. You will have to initialise the environmental variables. In the bash session where the terraform script will be executed, export the following parameters:
 
         # creator's credentials to the azure subscription
         export ARM_CLIENT_ID="INSERT VALUE ..."
         export ARM_CLIENT_SECRET="INSERT VALUE ..."
         export ARM_TENANT_ID="INSERT VALUE ..."
         export ARM_SUBSCRIPTION_ID="INSERT VALUE ..."

         # The next 3 parameters are required to access the vault secret using cli
         export VAULT_TOKEN=INSERT VALUE ...
         export VAULT_ADDR='INSERT VALUE ...'
         export VAULT_NAMESPACE=INSERT VALUE ...

         # The next 3 parameters are required to access the vault secrets within terraform
         export TF_VAR_VAULT_TOKEN=INSERT VALUE ...
         export TF_VAR_VAULT_ADDR='INSERT VALUE ...'
         export TF_VAR_VAULT_NAMESPACE=INSERT VALUE ...

#### 2.0)  In order to create the VM, the creator must have a user credential secret (username and password) in vault. Make a note of the secret path and the new vm user credential secret (see below). The path may be something like "secret/USER-DEFINED-SECRET-NAME". Now modify parameters in the tfvars file to suit your environment. THE PASSWORD MUST BE IN ACCORDANCE WITH ORGANISATION GUIDELINES (eg at least 14 characters long etc)
       
         "data": {
           "SECRET_PASSWORD_KEY": "USER PASSWORD",
           "SECRET_USERNAME_KEY": "VM USERNAME"
         }
####     NB: Update the user credentials in the main.tf file (root module) where the virtual machine module is being created:
         admin_username        = data.vault_generic_secret.vmuser_cred.data["SECRET_USERNAME_KEY"]
         admin_password        = data.vault_generic_secret.vmuser_cred.data["SECRET_PASSWORD_KEY"]
         
#### 3.0)  Execute: 
         terraform init
         terraform plan -var-file="tcw-stage-web-test.tfvars"
         terraform apply -var-file="tcw-stage-web-test.tfvars" -auto-approve
         
##       NB: please ensure that you are using the right environment tfvars file before executing the above
