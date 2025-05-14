@description('Name of the VM to monitor')
param vmName string

@description('Location of the VM')
param location string = resourceGroup().location

@description('Threshold for CPU usage (%)')
param cpuThreshold int = 80

@description('Email address for alert notifications')
param emailAddress string

@description('Action group name')
param actionGroupName string = 'cpuAlertActionGroup'

// Get the VM resource ID
resource targetVM 'Microsoft.Compute/virtualMachines@2023-03-01' existing = {
  name: vmName
}

// Create an Action Group
resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: actionGroupName
  location: 'global'
  properties: {
    enabled: true
    emailReceivers: [
      {
        name: 'AdminNotification'
        emailAddress: emailAddress
        useCommonAlertSchema: true
      }
    ]
  }
}

// CPU Metric Alert Rule
resource cpuAlert 'Microsoft.Insights/metricAlerts@2023-01-01' = {
  name: 'cpu-usage-alert-${vmName}'
  location: 'global'
  properties: {
    description: 'Alert when CPU usage exceeds threshold'
    severity: 3
    enabled: true
    scopes: [
      targetVM.id
    ]
    evaluationFrequency: 'PT1M'
    windowSize: 'PT5M'
    criteria: {
      allOf: [
        {
          name: 'HighCPUUsage'
          metricName: 'Percentage CPU'
          metricNamespace: 'Microsoft.Compute/virtualMachines'
          operator: 'GreaterThan'
          threshold: cpuThreshold
          timeAggregation: 'Average'
        }
      ]
    }
    actions: [
      {
        actionGroupId: actionGroup.id
      }
    ]
    autoMitigate: true
  }
}
