@description('The name of the App Service Plan')
param name string

@description('The location for the App Service Plan')
param location string

@description('The SKU of the App Service Plan')
param sku object = {
  name: 'B1'
  tier: 'Basic'
  capacity: 1
}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: name
  location: location
  sku: sku
  kind: 'linux'
  properties: {
    reserved: true
  }
}

output name string = appServicePlan.name
output id string = appServicePlan.id
