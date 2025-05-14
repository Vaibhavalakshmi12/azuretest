// Storage, Role Assignments, and Outputs.bicep
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: uniqueStorageAccountName
  location: location
  sku: {
    name: storageAccountSKU
  }
  kind: 'StorageV2'
  properties: {}
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid('${resourceGroup().id}-${aadGroupObjectId}-reader')
  scope: resourceGroup()
  properties: {
    roleDefinitionId: '/providers/Microsoft.Authorization/roleDefinitions/acdd72a7-3385-48ef-bd42-f606fba81ae7'
    principalId: aadGroupObjectId
    principalType: 'Group'
  }
}

output virtualNetworkId string = virtualNetwork.id
output subnetId string = virtualNetwork.properties.subnets[0].id
output networkSecurityGroupId string = networkSecurityGroup.id
output windowsVM1Id string = windowsVM1.id
output windowsVM2Id string = windowsVM2.id
output linuxVM1Id string = linuxVM1.id
output storageAccountId string = storageAccount.id
