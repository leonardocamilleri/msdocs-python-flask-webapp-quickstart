@description('Required. Name of your Azure Container Registry.')
@minLength(5)
@maxLength(50)
param name string

@description('Enable admin user that have push / pull permission to the registry.')
param acrAdminUserEnabled bool = true

@description('Optional. Location for all resources.')
param location string = resourceGroup().location

@description('The name of the App Service')
param appServiceName string

@description('The name of the container image')
param containerRegistryImageName string

@description('The version/tag of the container image')
param containerRegistryImageVersion string

module containerRegistry 'modules/container-registry.bicep' = {
  name: 'registry-deployment'
  params: {
    registryName: name
    registryLocation: location
    registryAdminUserEnabled: acrAdminUserEnabled
  }
}

module appServicePlan 'modules/app-service-plan.bicep' = {
  name: 'appServicePlanGuy'
  params: {
    appServicePlanName: 'appServicePlanGuy'
    appServicePlanLocation: location
    appServicePlanSku: {
      name: 'B1'
      capacity: 1
      tier: 'Basic'
    }
  }
}

module appService 'modules/app-service.bicep' = {
  name: 'appServiceGuy'
  params: {
    appServiceName: appServiceName
    appServiceLocation: location
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
