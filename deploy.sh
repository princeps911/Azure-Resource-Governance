#!/bin/bash

# 1. Define variables matching our enterprise naming convention
REGION="eastus"
TAGS="Project=Infrastructure-Governance CostCenter=CC-7701 Owner=App-Dev-Team"

# 2. Create the Development Resource Group with Tags
echo "Provisioning Development Environment..."
az group create \
  --name "rg-coreapp-dev-eastus-001" \
  --location $REGION \
  --tags $TAGS Environment=Development

# 3. Create a lightweight Storage Account inside Development Group
echo "Deploying Development Storage Account..."
az storage account create \
  --name "stcoreappdeveastus001" \
  --resource-group "rg-coreapp-dev-eastus-001" \
  --location $REGION \
  --sku Standard_LRS \
  --kind StorageV2

# 4. Create the Production Resource Group with Tags
echo "Provisioning Production Environment..."
az group create \
  --name "rg-coreapp-prod-eastus-001" \
  --location $REGION \
  --tags $TAGS Environment=Production

# 5. Clean up / Simulate Lifecycle management by deleting the Dev environment
# echo "Simulating teardown: Deleting Development Environment..."
# az group delete --name "rg-coreapp-dev-eastus-001" --yes --no-wait
