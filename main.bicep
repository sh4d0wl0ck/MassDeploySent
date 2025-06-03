param location string = resourceGroup().location
param workspaceName string = 'law-sentinel'

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: workspaceName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
  }
}

resource sentinel 'Microsoft.OperationalInsights/workspaces/providers@2022-01-01-preview' = {
  parent: logAnalytics
  name: 'MicrosoftSecurityInsights'
  kind: 'MicrosoftSecurityInsights'
  properties: {}
}

@batchSize(1)
module solutions 'sentinelSolutions.bicep' = [for solution in [
  'AzureActivity'
  'AzureEventHubs'
  'AzureFirewall'
  'AzureKeyVault'
  'AzureStorage'
  'AzureWebApplicationFirewall'
  'Microsoft365'
  'MicrosoftDefenderforCloudApps'
  'MicrosoftDefenderforOffice365'
  'MicrosoftDefenderThreatIntelligence'
  'MicrosoftDefenderXDR'
  'MicrosoftEntraID'
  'MicrosoftEntraIDProtection'
  'MicrosoftPurviewInformationProtection'
  'AzureNetworkSecurityGroups'
  'SalesforceServiceCloud'
  'WindowsSecurityEvents'
  'Syslog'
  'MicrosoftDefenderforCloud'
  'MicrosoftExchangeSecurityExchangeOnPremises'
  'SophosEndpointProtection'
]: {
  name: 'solution-${solution}'
  params: {
    solutionName: solution
    workspaceName: workspaceName
    location: location
  }
}]

