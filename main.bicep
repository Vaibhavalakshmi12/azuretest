param location string = resourceGroup().location
param adminUsername string
param adminPassword string

module vnetModule './vnet.bicep' = {
  name: 'deployVNet'
  params: {
    location: location
    vnetName: 'myVnet'
  }
}

module nsgModule './nsg.bicep' = {
  name: 'deployNSG'
  params: {
    location: location
    nsgName: 'myNSG'
  }
}

module vmModule './vm.bicep' = {
  name: 'deployVM'
  params: {
    location: location
    vmName: 'myVM'
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}