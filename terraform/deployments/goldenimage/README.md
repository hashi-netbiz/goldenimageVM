Terraform IAC code to create virtual machine in azure using the custom centos 9 golden image.

    1)  visual studio code development environment is assumed and git installed. 

    2)  Create the VM user credential secret (username and password) in vault. Make a note of the secret path and the new vm user 
         credential secret (see below). The path may be something like "secret/{USER-DEFINED-SECRET-NAME}". Now modify 
         parameters in the tfvars file to suit your environment. THE PASSWORD MUST BE IN ACCORDANCE WITH ORGANISATION
         GUIDELINES (eg at least 14 characters long etc)

          "data": {
              "password": "{USER PASSWORD}",
              "username": "{VM USERNAME}"
            }

    3)  Clone the github repo (.........) to your local enviroment and open it in visual studio code (VSC). Ensure that git bash is your CLI terminal.

    4)  Obtain the Application Identity and the hashicorp vault login credentials from the Administrator. Export the 
         identity and credentials in the git bash session in VSC where terraform will be executed as below:

	    # export the azure application credentials (git bash cli assumed)
     	export ARM_CLIENT_ID="INSERT VALUE HERE..."
     	export ARM_CLIENT_SECRET="INSERT VALUE HERE..."
     	export ARM_TENANT_ID="INSERT VALUE HERE..."
     	export ARM_SUBSCRIPTION_ID="INSERT VALUE HERE..."

      # export the azure application credentials (git bash cli assumed)
     	export TF_VAR_ARM_CLIENT_ID="INSERT VALUE HERE..."
     	export TF_VAR_ARM_CLIENT_SECRET="INSERT VALUE HERE..."
     	export TF_VAR_ARM_TENANT_ID="INSERT VALUE HERE..."
     	export TF_VAR_ARM_SUBSCRIPTION_ID="INSERT VALUE HERE..."

     	# The next 3 parameters are required to access the vault secrets within terraform (git bash cli assumed)
     	export TF_VAR_VAULT_TOKEN=INSERT VALUE HERE...
     	export TF_VAR_VAULT_ADDR='INSERT VALUE HERE...'
    	export TF_VAR_VAULT_NAMESPACE=INSERT VALUE HERE...

    5)  Setup the backend to be used in each deployment environment (uat,stage,prod etc ). This can be done following the steps in   
         ./backend/setup_script.sh. 
         It is assumed that a blog storage will be specified for each environment (tfstate-uat, tfstate-stage .... etc). All of the latter blog 
         storage will be created under a single Storage Account and Resource group (TCW-DevOps)

    6)  Navigate to the web directory and execute the vmexist.sh file to determine if the new VM to be created already exists 
        or not. The command is shown below including the requisite arguments:
	          bash ./vmexist.sh [YOUR-VM-NAME] [YOUR-RESOURCE-GROUP-NAME]

    7)  Navigate to the environments directory and select the sub-directory where you intend creating the VM. Create a NEW tfvars file to your specification. Copy the content of the example.tfvars file and modify accordingly.
	          [YOUR-VM-NAME].tfvars

    8)  Execute the following commands to create the VM from the web directory:
	
            terraform init -backend-config="key=[YOUR-VM-NAME].tfstate" -var-file="../../environments/[prod OR uat OR stage]/[YOUR-VM-NAME].tfvars"
            terraform plan -var-file="../../environments/[prod OR uat OR stage]/[YOUR-VM-NAME].tfvars"
            terraform apply -var-file="../../environments/[prod OR uat OR stage]/[YOUR-VM-NAME].tfvars" 

    9)  Execute the following commands to destroy the VM from the web directory:

	          terraform destroy -var-file="../../environments/[prod OR uat OR stage]/[YOUR-VM-NAME].tfvars" 