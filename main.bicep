@description('Prefix for resource names')
param namePrefix string

@description('Required. Name of your Azure Container Registry.')
@minLength(5)
@maxLength(50)
param name string = '${namePrefix}acr'

@description('Enable admin user that have push / pull permission to the registry.')
param acrAdminUserEnabled bool = true

@description('Optional. Location for all resources.')
param location string = resourceGroup().location

@description('The name of the App Service')
param appServiceName string = '${namePrefix}-app'

@description('The name of the container image')
param containerRegistryImageName string

@description('The version/tag of the container image')
param containerRegistryImageVersion string

module containerRegistry 'modules/container-registry.bicep' = {
  name: 'registry-deployment'
  params: {
    name: name
    location: location
    acrAdminUserEnabled: acrAdminUserEnabled
  }
}

module appServicePlan 'modules/app-service-plan.bicep' = {
  name: 'appServicePlanGuy'
  params: {
    serviceName: '${namePrefix}-plan'
    serviceLocation: location
    skuName: 'B1'
    skuTier: 'Basic'
    skuCapacity: 1
  }
}

module appService 'modules/app-service.bicep' = {
  name: 'appServiceGuy'
  params: {
    name: appServiceName
    location: location
    appServicePlanName: appServicePlan.name
    containerRegistryName: name
    containerRegistryImageName: containerRegistryImageName
    containerRegistryImageVersion: containerRegistryImageVersion
  }
}

output containerRegistryLoginServer string = containerRegistry.outputs.loginServer
output appServiceId string = appService.outputs.id
output appServiceName string = appService.outputs.name
output appServiceDefaultHostName string = appService.outputs.defaultHostName
