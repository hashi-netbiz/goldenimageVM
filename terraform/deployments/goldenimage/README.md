## Terraform IAC code to create virtual machine in azure using  the custom centos 9 golden image.

#### 1.0)  The process assumes that the creator has access to the azure application identity and the hashicorp vault login credentials. You will have to initialise the environmental variables. In the bash session where the terraform script will be executed, export the following parameters:
 
         # export the azure application credentials 
         export TF_VAR_ARM_CLIENT_ID="INSERT VALUE HERE..."
         export TF_VAR_ARM_CLIENT_SECRET="INSERT VALUE HERE..."
         export TF_VAR_ARM_TENANT_ID="INSERT VALUE HERE..."
         export TF_VAR_ARM_SUBSCRIPTION_ID="INSERT VALUE HERE..."

         # The next 3 parameters are required to access the vault secrets within terraform
         export TF_VAR_VAULT_TOKEN=INSERT VALUE HERE...
         export TF_VAR_VAULT_ADDR='INSERT VALUE HERE...'
         export TF_VAR_VAULT_NAMESPACE=INSERT VALUE HERE...

#### 2.0)  In order to create the VM, the creator must have a user credential secret (username and password) in vault. Make a note of the secret path and the new vm user credential secret (see below). The path may be something like "secret/{USER-DEFINED-SECRET-NAME}". Now modify parameters in the tfvars file to suit your environment. THE PASSWORD MUST BE IN ACCORDANCE WITH ORGANISATION GUIDELINES (eg at least 14 characters long etc)
       
         "data": {
           "password": "{USER PASSWORD}",
           "username": "{VM USERNAME}"
         }
####     NB: Update the user credentials in the main.tf file (root module) where the virtual machine module is being created:
         admin_username        = data.vault_generic_secret.vmuser_cred.data["username"]
         admin_password        = data.vault_generic_secret.vmuser_cred.data["password"]
         
#### 3.0)  Change directory to the relevant environment folder(uat,stage or prod).
####       Modify tfvars file to reflect the environment and execute the following: 
         terraform init
         terraform plan -var-file="{TF_VAR_FILE_NAME}.tfvars"
         terraform apply -var-file="{TF_VAR_FILE_NAME}.tfvars" -auto-approve
         

