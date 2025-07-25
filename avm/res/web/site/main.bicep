metadata name = 'Web/Function Apps'
metadata description = 'This module deploys a Web or Function App.'

@description('Required. Name of the site.')
param name string

@description('Optional. Location for all Resources.')
param location string = resourceGroup().location

@description('Required. Type of site to deploy.')
@allowed([
  'functionapp' // function app windows os
  'functionapp,linux' // function app linux os
  'functionapp,workflowapp' // logic app workflow
  'functionapp,workflowapp,linux' // logic app docker container
  'functionapp,linux,container' // function app linux container
  'functionapp,linux,container,azurecontainerapps' // function app linux container azure container apps
  'app,linux' // linux web app
  'app' // windows web app
  'linux,api' // linux api app
  'api' // windows api app
  'app,linux,container' // linux container app
  'app,container,windows' // windows container app
])
param kind string

@description('Required. The resource ID of the app service plan to use for the site.')
param serverFarmResourceId string

@description('Optional. Azure Resource Manager ID of the customers selected Managed Environment on which to host this app.')
param managedEnvironmentId string?

@description('Optional. Configures a site to accept only HTTPS requests. Issues redirect for HTTP requests.')
param httpsOnly bool = true

@description('Optional. If client affinity is enabled.')
param clientAffinityEnabled bool = true

@description('Optional. The resource ID of the app service environment to use for this resource.')
param appServiceEnvironmentResourceId string?

import { managedIdentityAllType } from 'br/public:avm/utl/types/avm-common-types:0.6.0'
@description('Optional. The managed identity definition for this resource.')
param managedIdentities managedIdentityAllType?

@description('Optional. The resource ID of the assigned identity to be used to access a key vault with.')
param keyVaultAccessIdentityResourceId string?

@description('Optional. Checks if Customer provided storage account is required.')
param storageAccountRequired bool = false

@description('Optional. Azure Resource Manager ID of the Virtual network and subnet to be joined by Regional VNET Integration. This must be of the form /subscriptions/{subscriptionName}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{vnetName}/subnets/{subnetName}.')
param virtualNetworkSubnetResourceId string?

@description('Optional. To enable accessing content over virtual network.')
param vnetContentShareEnabled bool = false

@description('Optional. To enable pulling image over Virtual Network.')
param vnetImagePullEnabled bool = false

@description('Optional. Virtual Network Route All enabled. This causes all outbound traffic to have Virtual Network Security Groups and User Defined Routes applied.')
param vnetRouteAllEnabled bool = false

@description('Optional. Stop SCM (KUDU) site when the app is stopped.')
param scmSiteAlsoStopped bool = false

@description('Optional. The site config object. The defaults are set to the following values: alwaysOn: true, minTlsVersion: \'1.2\', ftpsState: \'FtpsOnly\'.')
param siteConfig resourceInput<'Microsoft.Web/sites@2024-04-01'>.properties.siteConfig = {
  alwaysOn: true
  minTlsVersion: '1.2'
  ftpsState: 'FtpsOnly'
}

@description('Optional. The web site config.')
param configs configType[]?

@description('Optional. The Function App configuration object.')
param functionAppConfig resourceInput<'Microsoft.Web/sites@2024-04-01'>.properties.functionAppConfig?

@description('Optional. The extensions configuration.')
param extensions extensionType[]?

import { lockType } from 'br/public:avm/utl/types/avm-common-types:0.6.0'
@description('Optional. The lock settings of the service.')
param lock lockType?

import { privateEndpointSingleServiceType } from 'br/public:avm/utl/types/avm-common-types:0.6.0'
@description('Optional. Configuration details for private endpoints. For security reasons, it is recommended to use private endpoints whenever possible.')
param privateEndpoints privateEndpointSingleServiceType[]?

@description('Optional. Configuration for deployment slots for an app.')
param slots slotType[]?

@description('Optional. Tags of the resource.')
param tags resourceInput<'Microsoft.Web/sites@2024-11-01'>.tags?

@description('Optional. Enable/Disable usage telemetry for module.')
param enableTelemetry bool = true

import { roleAssignmentType } from 'br/public:avm/utl/types/avm-common-types:0.6.0'
@description('Optional. Array of role assignments to create.')
param roleAssignments roleAssignmentType[]?

import { diagnosticSettingFullType } from 'br/public:avm/utl/types/avm-common-types:0.6.0'
@description('Optional. The diagnostic settings of the service.')
param diagnosticSettings diagnosticSettingFullType[]?

@description('Optional. To enable client certificate authentication (TLS mutual authentication).')
param clientCertEnabled bool = false

@description('Optional. Client certificate authentication comma-separated exclusion paths.')
param clientCertExclusionPaths string?

@description('''
Optional. This composes with ClientCertEnabled setting.
- ClientCertEnabled=false means ClientCert is ignored.
- ClientCertEnabled=true and ClientCertMode=Required means ClientCert is required.
- ClientCertEnabled=true and ClientCertMode=Optional means ClientCert is optional or accepted.
''')
@allowed([
  'Optional'
  'OptionalInteractiveUser'
  'Required'
])
param clientCertMode string = 'Optional'

@description('Optional. If specified during app creation, the app is cloned from a source app.')
param cloningInfo resourceInput<'Microsoft.Web/sites@2024-04-01'>.properties.cloningInfo?

@description('Optional. Size of the function container.')
param containerSize int?

@description('Optional. Maximum allowed daily memory-time quota (applicable on dynamic apps only).')
param dailyMemoryTimeQuota int?

@description('Optional. Setting this value to false disables the app (takes the app offline).')
param enabled bool = true

@description('Optional. Hostname SSL states are used to manage the SSL bindings for app\'s hostnames.')
param hostNameSslStates resourceInput<'Microsoft.Web/sites@2024-04-01'>.properties.hostNameSslStates?

@description('Optional. Hyper-V sandbox.')
param hyperV bool = false

@description('Optional. Site redundancy mode.')
@allowed([
  'ActiveActive'
  'Failover'
  'GeoRedundant'
  'Manual'
  'None'
])
param redundancyMode string = 'None'

@description('Optional. The site publishing credential policy names which are associated with the sites.')
param basicPublishingCredentialsPolicies basicPublishingCredentialsPolicyType[]?

@description('Optional. Names of hybrid connection relays to connect app with.')
param hybridConnectionRelays hybridConnectionRelayType[]?

@description('Optional. Whether or not public network access is allowed for this resource. For security reasons it should be disabled. If not specified, it will be disabled by default if private endpoints are set.')
@allowed([
  'Enabled'
  'Disabled'
])
param publicNetworkAccess string?

@description('Optional. End to End Encryption Setting.')
param e2eEncryptionEnabled bool?

@description('Optional. Property to configure various DNS related settings for a site.')
param dnsConfiguration resourceInput<'Microsoft.Web/sites@2024-04-01'>.properties.dnsConfiguration?

@description('Optional. Specifies the scope of uniqueness for the default hostname during resource creation.')
@allowed([
  'NoReuse'
  'ResourceGroupReuse'
  'SubscriptionReuse'
  'TenantReuse'
])
param autoGeneratedDomainNameLabelScope string?

var enableReferencedModulesTelemetry = false

var formattedUserAssignedIdentities = reduce(
  map((managedIdentities.?userAssignedResourceIds ?? []), (id) => { '${id}': {} }),
  {},
  (cur, next) => union(cur, next)
) // Converts the flat array to an object like { '${id1}': {}, '${id2}': {} }

var identity = !empty(managedIdentities)
  ? {
      type: (managedIdentities.?systemAssigned ?? false)
        ? (!empty(managedIdentities.?userAssignedResourceIds ?? {}) ? 'SystemAssigned, UserAssigned' : 'SystemAssigned')
        : (!empty(managedIdentities.?userAssignedResourceIds ?? {}) ? 'UserAssigned' : 'None')
      userAssignedIdentities: !empty(formattedUserAssignedIdentities) ? formattedUserAssignedIdentities : null
    }
  : null

var builtInRoleNames = {
  'App Compliance Automation Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '0f37683f-2463-46b6-9ce7-9b788b988ba2'
  )
  Contributor: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c')
  Owner: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '8e3af657-a8ff-443c-a75c-2fe8c4bcb635')
  Reader: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'acdd72a7-3385-48ef-bd42-f606fba81ae7')
  'Role Based Access Control Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'f58310d9-a9f6-439a-9e8d-f62e7b41a168'
  )
  'User Access Administrator': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '18d7d88d-d35e-4fb5-a5c3-7773c20a72d9'
  )
  'Web Plan Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    '2cc479cb-7b4d-49a8-b449-8c00fd0f0a4b'
  )
  'Website Contributor': subscriptionResourceId(
    'Microsoft.Authorization/roleDefinitions',
    'de139f84-1756-47ae-9be6-808fbbe84772'
  )
}

var formattedRoleAssignments = [
  for (roleAssignment, index) in (roleAssignments ?? []): union(roleAssignment, {
    roleDefinitionId: builtInRoleNames[?roleAssignment.roleDefinitionIdOrName] ?? (contains(
        roleAssignment.roleDefinitionIdOrName,
        '/providers/Microsoft.Authorization/roleDefinitions/'
      )
      ? roleAssignment.roleDefinitionIdOrName
      : subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleAssignment.roleDefinitionIdOrName))
  })
]

#disable-next-line no-deployments-resources
resource avmTelemetry 'Microsoft.Resources/deployments@2024-03-01' = if (enableTelemetry) {
  name: '46d3xbcp.res.web-site.${replace('-..--..-', '.', '-')}.${substring(uniqueString(deployment().name, location), 0, 4)}'
  properties: {
    mode: 'Incremental'
    template: {
      '$schema': 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
      contentVersion: '1.0.0.0'
      resources: []
      outputs: {
        telemetry: {
          type: 'String'
          value: 'For more information, see https://aka.ms/avm/TelemetryInfo'
        }
      }
    }
  }
}

resource app 'Microsoft.Web/sites@2024-04-01' = {
  name: name
  location: location
  kind: kind
  tags: tags
  identity: identity
  properties: {
    managedEnvironmentId: !empty(managedEnvironmentId) ? managedEnvironmentId : null
    serverFarmId: serverFarmResourceId
    clientAffinityEnabled: clientAffinityEnabled
    httpsOnly: httpsOnly
    hostingEnvironmentProfile: !empty(appServiceEnvironmentResourceId)
      ? {
          id: appServiceEnvironmentResourceId
        }
      : null
    storageAccountRequired: storageAccountRequired
    keyVaultReferenceIdentity: keyVaultAccessIdentityResourceId
    virtualNetworkSubnetId: virtualNetworkSubnetResourceId
    siteConfig: siteConfig
    functionAppConfig: functionAppConfig
    clientCertEnabled: clientCertEnabled
    clientCertExclusionPaths: clientCertExclusionPaths
    clientCertMode: clientCertMode
    cloningInfo: cloningInfo
    containerSize: containerSize
    dailyMemoryTimeQuota: dailyMemoryTimeQuota
    enabled: enabled
    hostNameSslStates: hostNameSslStates
    hyperV: hyperV
    redundancyMode: redundancyMode
    publicNetworkAccess: !empty(publicNetworkAccess)
      ? any(publicNetworkAccess)
      : (!empty(privateEndpoints) ? 'Disabled' : 'Enabled')
    vnetContentShareEnabled: vnetContentShareEnabled
    vnetImagePullEnabled: vnetImagePullEnabled
    vnetRouteAllEnabled: vnetRouteAllEnabled
    scmSiteAlsoStopped: scmSiteAlsoStopped
    endToEndEncryptionEnabled: e2eEncryptionEnabled
    dnsConfiguration: dnsConfiguration
    autoGeneratedDomainNameLabelScope: autoGeneratedDomainNameLabelScope
  }
}

module app_config 'config/main.bicep' = [
  for (config, index) in (configs ?? []): {
    name: '${uniqueString(deployment().name, location)}-Site-Config-${index}'
    params: {
      appName: app.name
      name: config.name
      applicationInsightResourceId: config.?applicationInsightResourceId
      storageAccountResourceId: config.?storageAccountResourceId
      storageAccountUseIdentityAuthentication: config.?storageAccountUseIdentityAuthentication
      properties: config.?properties
      currentAppSettings: config.?retainCurrentAppSettings ?? true && config.name == 'appsettings'
        ? list('${app.id}/config/appsettings', '2023-12-01').properties
        : {}
    }
  }
]

module app_extensions 'extension/main.bicep' = [
  for (extension, index) in (extensions ?? []): {
    name: '${uniqueString(deployment().name, location)}-Site-Extension-${index}'
    params: {
      appName: app.name
      properties: extension.properties
    }
  }
]

@batchSize(1)
module app_slots 'slot/main.bicep' = [
  for (slot, index) in (slots ?? []): {
    name: '${uniqueString(deployment().name, location)}-Slot-${slot.name}'
    params: {
      name: slot.name
      appName: app.name
      location: location
      kind: kind
      serverFarmResourceId: serverFarmResourceId
      httpsOnly: slot.?httpsOnly ?? httpsOnly
      appServiceEnvironmentResourceId: appServiceEnvironmentResourceId
      clientAffinityEnabled: slot.?clientAffinityEnabled ?? clientAffinityEnabled
      managedIdentities: slot.?managedIdentities ?? managedIdentities
      keyVaultAccessIdentityResourceId: slot.?keyVaultAccessIdentityResourceId ?? keyVaultAccessIdentityResourceId
      storageAccountRequired: slot.?storageAccountRequired ?? storageAccountRequired
      virtualNetworkSubnetResourceId: slot.?virtualNetworkSubnetResourceId ?? virtualNetworkSubnetResourceId
      siteConfig: slot.?siteConfig ?? siteConfig
      functionAppConfig: slot.?functionAppConfig ?? functionAppConfig
      configs: slot.?configs ?? configs
      extensions: slot.?extensions ?? extensions
      diagnosticSettings: slot.?diagnosticSettings
      roleAssignments: slot.?roleAssignments
      basicPublishingCredentialsPolicies: slot.?basicPublishingCredentialsPolicies ?? basicPublishingCredentialsPolicies
      lock: slot.?lock ?? lock
      privateEndpoints: slot.?privateEndpoints ?? []
      tags: slot.?tags ?? tags
      clientCertEnabled: slot.?clientCertEnabled
      clientCertExclusionPaths: slot.?clientCertExclusionPaths
      clientCertMode: slot.?clientCertMode
      cloningInfo: slot.?cloningInfo
      containerSize: slot.?containerSize
      customDomainVerificationId: slot.?customDomainVerificationId
      dailyMemoryTimeQuota: slot.?dailyMemoryTimeQuota
      enabled: slot.?enabled
      hostNameSslStates: slot.?hostNameSslStates
      hyperV: slot.?hyperV
      publicNetworkAccess: slot.?publicNetworkAccess ?? ((!empty(slot.?privateEndpoints) || !empty(privateEndpoints))
        ? 'Disabled'
        : 'Enabled')
      redundancyMode: slot.?redundancyMode
      vnetContentShareEnabled: slot.?vnetContentShareEnabled
      vnetImagePullEnabled: slot.?vnetImagePullEnabled
      vnetRouteAllEnabled: slot.?vnetRouteAllEnabled
      hybridConnectionRelays: slot.?hybridConnectionRelays
      dnsConfiguration: slot.?dnsConfiguration
      autoGeneratedDomainNameLabelScope: slot.?autoGeneratedDomainNameLabelScope
    }
  }
]

module app_basicPublishingCredentialsPolicies 'basic-publishing-credentials-policy/main.bicep' = [
  for (basicPublishingCredentialsPolicy, index) in (basicPublishingCredentialsPolicies ?? []): {
    name: '${uniqueString(deployment().name, location)}-Site-Publish-Cred-${index}'
    params: {
      webAppName: app.name
      name: basicPublishingCredentialsPolicy.name
      allow: basicPublishingCredentialsPolicy.?allow
      location: location
    }
  }
]

module app_hybridConnectionRelays 'hybrid-connection-namespace/relay/main.bicep' = [
  for (hybridConnectionRelay, index) in (hybridConnectionRelays ?? []): {
    name: '${uniqueString(deployment().name, location)}-HybridConnectionRelay-${index}'
    params: {
      hybridConnectionResourceId: hybridConnectionRelay.hybridConnectionResourceId
      appName: app.name
      sendKeyName: hybridConnectionRelay.?sendKeyName
    }
  }
]

resource app_lock 'Microsoft.Authorization/locks@2020-05-01' = if (!empty(lock ?? {}) && lock.?kind != 'None') {
  name: lock.?name ?? 'lock-${name}'
  properties: {
    level: lock.?kind ?? ''
    notes: lock.?notes ?? (lock.?kind == 'CanNotDelete'
      ? 'Cannot delete resource or child resources.'
      : 'Cannot delete or modify the resource or child resources.')
  }
  scope: app
}

resource app_diagnosticSettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = [
  for (diagnosticSetting, index) in (diagnosticSettings ?? []): {
    name: diagnosticSetting.?name ?? '${name}-diagnosticSettings'
    properties: {
      storageAccountId: diagnosticSetting.?storageAccountResourceId
      workspaceId: diagnosticSetting.?workspaceResourceId
      eventHubAuthorizationRuleId: diagnosticSetting.?eventHubAuthorizationRuleResourceId
      eventHubName: diagnosticSetting.?eventHubName
      metrics: [
        for group in (diagnosticSetting.?metricCategories ?? [{ category: 'AllMetrics' }]): {
          category: group.category
          enabled: group.?enabled ?? true
          timeGrain: null
        }
      ]
      logs: [
        for group in (diagnosticSetting.?logCategoriesAndGroups ?? [{ categoryGroup: 'allLogs' }]): {
          categoryGroup: group.?categoryGroup
          category: group.?category
          enabled: group.?enabled ?? true
        }
      ]
      marketplacePartnerId: diagnosticSetting.?marketplacePartnerResourceId
      logAnalyticsDestinationType: diagnosticSetting.?logAnalyticsDestinationType
    }
    scope: app
  }
]

resource app_roleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' = [
  for (roleAssignment, index) in (formattedRoleAssignments ?? []): {
    name: roleAssignment.?name ?? guid(app.id, roleAssignment.principalId, roleAssignment.roleDefinitionId)
    properties: {
      roleDefinitionId: roleAssignment.roleDefinitionId
      principalId: roleAssignment.principalId
      description: roleAssignment.?description
      principalType: roleAssignment.?principalType
      condition: roleAssignment.?condition
      conditionVersion: !empty(roleAssignment.?condition) ? (roleAssignment.?conditionVersion ?? '2.0') : null // Must only be set if condtion is set
      delegatedManagedIdentityResourceId: roleAssignment.?delegatedManagedIdentityResourceId
    }
    scope: app
  }
]

module app_privateEndpoints 'br/public:avm/res/network/private-endpoint:0.11.0' = [
  for (privateEndpoint, index) in (privateEndpoints ?? []): {
    name: '${uniqueString(deployment().name, location)}-app-PrivateEndpoint-${index}'
    scope: resourceGroup(
      split(privateEndpoint.?resourceGroupResourceId ?? resourceGroup().id, '/')[2],
      split(privateEndpoint.?resourceGroupResourceId ?? resourceGroup().id, '/')[4]
    )
    params: {
      name: privateEndpoint.?name ?? 'pep-${last(split(app.id, '/'))}-${privateEndpoint.?service ?? 'sites'}-${index}'
      privateLinkServiceConnections: privateEndpoint.?isManualConnection != true
        ? [
            {
              name: privateEndpoint.?privateLinkServiceConnectionName ?? '${last(split(app.id, '/'))}-${privateEndpoint.?service ?? 'sites'}-${index}'
              properties: {
                privateLinkServiceId: app.id
                groupIds: [
                  privateEndpoint.?service ?? 'sites'
                ]
              }
            }
          ]
        : null
      manualPrivateLinkServiceConnections: privateEndpoint.?isManualConnection == true
        ? [
            {
              name: privateEndpoint.?privateLinkServiceConnectionName ?? '${last(split(app.id, '/'))}-${privateEndpoint.?service ?? 'sites'}-${index}'
              properties: {
                privateLinkServiceId: app.id
                groupIds: [
                  privateEndpoint.?service ?? 'sites'
                ]
                requestMessage: privateEndpoint.?manualConnectionRequestMessage ?? 'Manual approval required.'
              }
            }
          ]
        : null
      subnetResourceId: privateEndpoint.subnetResourceId
      enableTelemetry: enableReferencedModulesTelemetry
      location: privateEndpoint.?location ?? reference(
        split(privateEndpoint.subnetResourceId, '/subnets/')[0],
        '2020-06-01',
        'Full'
      ).location
      lock: privateEndpoint.?lock ?? lock
      privateDnsZoneGroup: privateEndpoint.?privateDnsZoneGroup
      roleAssignments: privateEndpoint.?roleAssignments
      tags: privateEndpoint.?tags ?? tags
      customDnsConfigs: privateEndpoint.?customDnsConfigs
      ipConfigurations: privateEndpoint.?ipConfigurations
      applicationSecurityGroupResourceIds: privateEndpoint.?applicationSecurityGroupResourceIds
      customNetworkInterfaceName: privateEndpoint.?customNetworkInterfaceName
    }
  }
]

@description('The name of the site.')
output name string = app.name

@description('The resource ID of the site.')
output resourceId string = app.id

@description('The resource group the site was deployed into.')
output resourceGroupName string = resourceGroup().name

@description('The principal ID of the system assigned identity.')
output systemAssignedMIPrincipalId string? = app.?identity.?principalId

@description('The location the resource was deployed into.')
output location string = app.location

@description('Default hostname of the app.')
output defaultHostname string = app.properties.defaultHostName

@description('Unique identifier that verifies the custom domains assigned to the app. Customer will add this ID to a txt record for verification.')
output customDomainVerificationId string = app.properties.customDomainVerificationId

@description('The outbound IP addresses of the app.')
output outboundIpAddresses string = app.properties.outboundIpAddresses

@description('The private endpoints of the site.')
output privateEndpoints privateEndpointOutputType[] = [
  for (item, index) in (privateEndpoints ?? []): {
    name: app_privateEndpoints[index].outputs.name
    resourceId: app_privateEndpoints[index].outputs.resourceId
    groupId: app_privateEndpoints[index].outputs.?groupId!
    customDnsConfigs: app_privateEndpoints[index].outputs.customDnsConfigs
    networkInterfaceResourceIds: app_privateEndpoints[index].outputs.networkInterfaceResourceIds
  }
]

@description('The slots of the site.')
output slots {
  @description('The name of the slot.')
  name: string

  @description('The resource ID of the slot.')
  resourceId: string

  @description('The principal ID of the system assigned identity of the slot.')
  systemAssignedMIPrincipalId: string?

  @description('The private endpoints of the slot.')
  privateEndpoints: privateEndpointOutputType[]
}[] = [
  #disable-next-line outputs-should-not-contain-secrets // false-positive. The key is not returned
  for (slot, index) in (slots ?? []): {
    name: app_slots[index].name
    resourceId: app_slots[index].outputs.resourceId
    systemAssignedMIPrincipalId: app_slots[index].outputs.?systemAssignedMIPrincipalId ?? ''
    privateEndpoints: app_slots[index].outputs.privateEndpoints
  }
]

// ================ //
// Definitions      //
// ================ //
@export()
type privateEndpointOutputType = {
  @description('The name of the private endpoint.')
  name: string

  @description('The resource ID of the private endpoint.')
  resourceId: string

  @description('The group Id for the private endpoint Group.')
  groupId: string?

  @description('The custom DNS configurations of the private endpoint.')
  customDnsConfigs: {
    @description('FQDN that resolves to private endpoint IP address.')
    fqdn: string?

    @description('A list of private IP addresses of the private endpoint.')
    ipAddresses: string[]
  }[]

  @description('The IDs of the network interfaces associated with the private endpoint.')
  networkInterfaceResourceIds: string[]
}

import {
  appSettingsConfigType
  authSettingsConfigType
  authSettingsV2ConfigType
  azureStorageAccountConfigType
  backupConfigType
  connectionStringsConfigType
  logsConfigType
  metadataConfigType
  pushSettingsConfigType
  webConfigType
} from 'slot/main.bicep'

@export()
@description('The type of a site configuration.')
@discriminator('name')
type configType =
  | appSettingsConfigType
  | authSettingsConfigType
  | authSettingsV2ConfigType
  | azureStorageAccountConfigType
  | backupConfigType
  | connectionStringsConfigType
  | logsConfigType
  | metadataConfigType
  | pushSettingsConfigType
  | slotConfigNamesConfigType
  | webConfigType

// Not available flor slots
@export()
@description('The type of a slotConfigNames configuration.')
type slotConfigNamesConfigType = {
  @description('Required. The type of config.')
  name: 'slotConfigNames'

  @description('Required. The config settings.')
  properties: {
    @description('Optional. List of application settings names.')
    appSettingNames: string[]?

    @description('Optional. List of external Azure storage account identifiers.')
    azureStorageConfigNames: string[]?

    @description('Optional. List of connection string names.')
    connectionStringNames: string[]?
  }
}

@export()
@description('The type of a slot.')
type slotType = {
  @description('Required. Name of the slot.')
  name: string

  @description('Optional. Location for all Resources.')
  location: string?

  @description('Optional. The resource ID of the app service plan to use for the slot.')
  serverFarmResourceId: string?

  @description('Optional. Configures a slot to accept only HTTPS requests. Issues redirect for HTTP requests.')
  httpsOnly: bool?

  @description('Optional. If client affinity is enabled.')
  clientAffinityEnabled: bool?

  @description('Optional. The resource ID of the app service environment to use for this resource.')
  appServiceEnvironmentResourceId: string?

  @description('Optional. The managed identity definition for this resource.')
  managedIdentities: managedIdentityAllType?

  @description('Optional. The resource ID of the assigned identity to be used to access a key vault with.')
  keyVaultAccessIdentityResourceId: string?

  @description('Optional. Checks if Customer provided storage account is required.')
  storageAccountRequired: bool?

  @description('Optional. Azure Resource Manager ID of the Virtual network and subnet to be joined by Regional VNET Integration. This must be of the form /subscriptions/{subscriptionName}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{vnetName}/subnets/{subnetName}.')
  virtualNetworkSubnetResourceId: string?

  @description('Optional. The site config object.')
  siteConfig: resourceInput<'Microsoft.Web/sites/slots@2024-04-01'>.properties.siteConfig?

  @description('Optional. The Function App config object.')
  functionAppConfig: resourceInput<'Microsoft.Web/sites/slots@2024-04-01'>.properties.functionAppConfig?

  @description('Optional. The web site config.')
  configs: configType[]?

  @description('Optional. The extensions configuration.')
  extensions: object[]?

  @description('Optional. The lock settings of the service.')
  lock: lockType?

  @description('Optional. Configuration details for private endpoints.')
  privateEndpoints: privateEndpointSingleServiceType[]?

  @description('Optional. Tags of the resource.')
  tags: object?

  @description('Optional. Array of role assignments to create.')
  roleAssignments: roleAssignmentType[]?

  @description('Optional. The diagnostic settings of the service.')
  diagnosticSettings: diagnosticSettingFullType[]?

  @description('Optional. To enable client certificate authentication (TLS mutual authentication).')
  clientCertEnabled: bool?

  @description('Optional. Client certificate authentication comma-separated exclusion paths.')
  clientCertExclusionPaths: string?

  @description('Optional. This composes with ClientCertEnabled setting.</p>- ClientCertEnabled: false means ClientCert is ignored.</p>- ClientCertEnabled: true and ClientCertMode: Required means ClientCert is required.</p>- ClientCertEnabled: true and ClientCertMode: Optional means ClientCert is optional or accepted.')
  clientCertMode: resourceInput<'Microsoft.Web/sites/slots@2024-04-01'>.properties.clientCertMode?

  @description('Optional. If specified during app creation, the app is cloned from a source app.')
  cloningInfo: resourceInput<'Microsoft.Web/sites/slots@2024-04-01'>.properties.cloningInfo?

  @description('Optional. Size of the function container.')
  containerSize: int?

  @description('Optional. Unique identifier that verifies the custom domains assigned to the app. Customer will add this ID to a txt record for verification.')
  customDomainVerificationId: string?

  @description('Optional. Maximum allowed daily memory-time quota (applicable on dynamic apps only).')
  dailyMemoryTimeQuota: int?

  @description('Optional. Setting this value to false disables the app (takes the app offline).')
  enabled: bool?

  @description('Optional. Hostname SSL states are used to manage the SSL bindings for app\'s hostnames.')
  hostNameSslStates: resourceInput<'Microsoft.Web/sites/slots@2024-04-01'>.properties.hostNameSslStates?

  @description('Optional. Hyper-V sandbox.')
  hyperV: bool?

  @description('Optional. Allow or block all public traffic.')
  publicNetworkAccess: resourceInput<'Microsoft.Web/sites/slots@2024-04-01'>.properties.publicNetworkAccess?

  @description('Optional. Site redundancy mode.')
  redundancyMode: resourceInput<'Microsoft.Web/sites/slots@2024-04-01'>.properties.redundancyMode?

  @description('Optional. The site publishing credential policy names which are associated with the site slot.')
  basicPublishingCredentialsPolicies: basicPublishingCredentialsPolicyType[]?

  @description('Optional. To enable accessing content over virtual network.')
  vnetContentShareEnabled: bool?

  @description('Optional. To enable pulling image over Virtual Network.')
  vnetImagePullEnabled: bool?

  @description('Optional. Virtual Network Route All enabled. This causes all outbound traffic to have Virtual Network Security Groups and User Defined Routes applied.')
  vnetRouteAllEnabled: bool?

  @description('Optional. Names of hybrid connection relays to connect app with.')
  hybridConnectionRelays: hybridConnectionRelayType[]?

  @description('Optional. Property to configure various DNS related settings for a site.')
  dnsConfiguration: resourceInput<'Microsoft.Web/sites/slots@2024-04-01'>.properties.dnsConfiguration?

  @description('Optional. Specifies the scope of uniqueness for the default hostname during resource creation.')
  autoGeneratedDomainNameLabelScope: ('NoReuse' | 'ResourceGroupReuse' | 'SubscriptionReuse' | 'TenantReuse')?
}

type extensionType = {
  @description('Optional. Sets the properties.')
  properties: resourceInput<'Microsoft.Web/sites/extensions@2024-04-01'>.properties?
}

@export()
@description('The type of a basic publishing credential policy.')
type basicPublishingCredentialsPolicyType = {
  @description('Required. The name of the resource.')
  name: ('scm' | 'ftp')

  @description('Optional. Set to true to enable or false to disable a publishing method.')
  allow: bool?

  @description('Optional. Location for all Resources.')
  location: string?
}

@export()
@description('The type of a hybrid connection relay.')
type hybridConnectionRelayType = {
  @description('Required. The resource ID of the relay namespace hybrid connection.')
  hybridConnectionResourceId: string

  @description('Optional. Name of the authorization rule send key to use.')
  sendKeyName: string?
}
