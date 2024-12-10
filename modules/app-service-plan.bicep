@description('The name of the App Service Plan')
param appServicePlanName string

@description('The location for the App Service Plan')
param appServicePlanLocation string

@description('The SKU of the App Service Plan')
param appServicePlanSku object = {
  name: 'B1'
  tier: 'Basic'
  capacity: 1
}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: appServicePlanLocation
  sku: appServicePlanSku
  kind: 'linux'
  properties: {
    reserved: true
  }
}

output name string = appServicePlan.name
output id string = appServicePlan.id
