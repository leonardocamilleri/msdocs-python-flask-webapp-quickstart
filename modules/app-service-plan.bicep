@description('The name of the App Service Plan')
param servicePlanName string

@description('The location for the App Service Plan')
param servicePlanLocation string

@description('The SKU of the App Service Plan')
param servicePlanSku object = {
  name: 'B1'
  tier: 'Basic'
  capacity: 1
}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: servicePlanName
  location: servicePlanLocation
  sku: servicePlanSku
  kind: 'linux'
  properties: {
    reserved: true
  }
}

output name string = appServicePlan.name
output id string = appServicePlan.id
