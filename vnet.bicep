param location string
param vnetName string

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['192.168.0.0/16']
    }
    subnets: [
      {
        name: 'appSubnet'
        properties: {
          addressPrefix: '192.168.1.0/24'
        }
      }
    ]
  }
}

output subnetId string = vnet.properties.subnets[0].id