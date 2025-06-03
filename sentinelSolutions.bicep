param solutionName string
param workspaceName string
param location string

resource contentHubSolution 'Microsoft.SecurityInsights/contentHubs@2022-12-01-preview' = {
  name: '${solutionName}-solution'
  location: location
  properties: {
    contentHubSolutionId: solutionName
    offerType: 'Solution'
    workspaceResourceId: resourceId('Microsoft.OperationalInsights/workspaces', workspaceName)
  }
}

