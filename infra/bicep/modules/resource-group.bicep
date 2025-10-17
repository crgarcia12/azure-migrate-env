// Default parameters (can be overridden during deployment)
@description('The name of the resource group')
param name string = 'crgar-migr-rg'

@description('The location for the resource group')
param location string = 'swedencentral'

@description('Tags to apply to the resource group')
param tags object = {}

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: name
  location: location
  tags: tags
}

output resourceGroupName string = rg.name
output resourceGroupId string = rg.id
output location string = rg.location
