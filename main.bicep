param namePrefix string
param location string
param name string
param appServiceName string
param containerRegistryImageName string
param containerRegistryImageVersion string
param acrAdminUserEnabled bool = true

module containerRegistry 'modules/container-registry.bicep' = {
  name: 'registry-deployment'
  params: {
    name: name
    location: location
    acrAdminUserEnabled: acrAdminUserEnabled
  }
}

module appServicePlan 'modules/app-service-plan.bicep' = {
  name: 'appServicePlan'
  params: {
    serviceName: '${namePrefix}-plan'
    serviceLocation: location
    skuName: 'B1'
    skuTier: 'Basic'
    skuCapacity: 1
  }
}

module appService 'modules/app-service.bicep' = {
  name: 'appService'
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
