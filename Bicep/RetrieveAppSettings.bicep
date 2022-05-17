

resource functionApp 'Microsoft.Web/sites/config@2021-03-01' existing ={
  name: 'uniquefunctionappcaetano/appsettings'
}

//output out object = list('${functionApp.id}/config/appsettings', '2020-12-01')
output out object = functionApp.properties
