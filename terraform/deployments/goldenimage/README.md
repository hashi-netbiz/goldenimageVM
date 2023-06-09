This is the staging environment.

Initialise the environmental variables. This would set up the user and vault credentials:



Modify the tfvars to suit your environment

Execute: terraform init
         terraform plan -var-file="tcw-stage-web-test.tfvars"
         terraform apply -var-file="tcw-stage-web-test.tfvars" -auto-approve