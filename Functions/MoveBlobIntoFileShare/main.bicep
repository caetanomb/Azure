param location string = resourceGroup().location

var functionName = 'MoveBlobToFileShare'
var functionAppName = 'MoveBlobToFileShare-functionapp'
var functionAppHostingPlanName = 'MoveBlobToFileShare-functionapp-HostingPlan'
// remove dashes for storage account name
var storageAccountName = format('{0}sta', toLower(replace(functionName, '-', '')))


resource hostingPlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: functionAppHostingPlanName
  location: location
  kind: 'linux'
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
  }
}

resource function 'Microsoft.Web/sites@2018-11-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp,linux'
  properties: {    
    serverFarmId: hostingPlan.id
    siteConfig: {
      appSettings: [        
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet'
        }
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};AccountKey=${listKeys(storageaccount.id, '2019-06-01').keys[0].value};EndpointSuffix=core.windows.net'
        }
      ]      
    }
    httpsOnly: true
  }
}

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties:{
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
  }  
}


