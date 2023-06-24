# Set your variables
export RESOURCE_GROUP_NAME="azure-storage-explorer"
export LOCATION="eastus"
export STORAGE_ACCOUNT_NAME="webtfstatesa"
export CONTAINER_NAME_DEV="tfstate-dev"
export CONTAINER_NAME_STAGING="tfstate-stage"
export CONTAINER_NAME_PROD="tfstate-prod"

# Create resource group ( if it does not exist)
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create storage account ( if it does not exist)
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Get and set storage account key
export ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)

# Create blob containers
az storage container create --name $CONTAINER_NAME_DEV --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY
az storage container create --name $CONTAINER_NAME_STAGING --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY
az storage container create --name $CONTAINER_NAME_PROD --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY