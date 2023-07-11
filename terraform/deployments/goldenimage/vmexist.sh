#!/bin/bash

# Define the Azure VM name and resource group passed in as arguments
vmName="$1"
resourceGroup="$2"

# Check if the VM exists
az vm show --name "$vmName" --resource-group "$resourceGroup" &>/dev/null

# Check the return code
if [ $? -eq 0 ]; then
  echo "The Azure VM '$vmName' exists."
else
  echo "The Azure VM '$vmName' does not exist."
fi
