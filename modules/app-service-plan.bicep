@description('The name of the App Service Plan')
param serviceName string

@description('The location for the App Service Plan')
param serviceLocation string

@description('The SKU name for the App Service Plan')
param skuName string = 'B1'

@description('The SKU tier for the App Service Plan')
param skuTier string = 'Basic'

@description('The SKU capacity for the App Service Plan')
param skuCapacity int = 1

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: serviceName
  location: serviceLocation
  sku: {
    name: skuName
    tier: skuTier
    capacity: skuCapacity
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

output name string = appServicePlan.name
output id string = appServicePlan.id
