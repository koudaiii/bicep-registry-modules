# Virtual Network Gateway Connections `[Microsoft.Network/connections]`

This module deploys a Virtual Network Gateway Connection.

## Navigation

- [Resource Types](#Resource-Types)
- [Usage examples](#Usage-examples)
- [Parameters](#Parameters)
- [Outputs](#Outputs)
- [Cross-referenced modules](#Cross-referenced-modules)
- [Notes](#Notes)
- [Data Collection](#Data-Collection)

## Resource Types

| Resource Type | API Version |
| :-- | :-- |
| `Microsoft.Authorization/locks` | [2020-05-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Authorization/2020-05-01/locks) |
| `Microsoft.Network/connections` | [2024-05-01](https://learn.microsoft.com/en-us/azure/templates/Microsoft.Network/2024-05-01/connections) |

## Usage examples

The following section provides usage examples for the module, which were used to validate and deploy the module successfully. For a full reference, please review the module's test folder in its repository.

>**Note**: Each example lists all the required parameters first, followed by the rest - each in alphabetical order.

>**Note**: To reference the module, please use the following syntax `br/public:avm/res/network/connection:<version>`.

- [Using only defaults](#example-1-using-only-defaults)
- [IPSec connection with APIPA configuration](#example-2-ipsec-connection-with-apipa-configuration)
- [Using large parameter set](#example-3-using-large-parameter-set)
- [WAF-aligned](#example-4-waf-aligned)

### Example 1: _Using only defaults_

This instance deploys the module with the minimum set of required parameters.


<details>

<summary>via Bicep module</summary>

```bicep
module connection 'br/public:avm/res/network/connection:<version>' = {
  name: 'connectionDeployment'
  params: {
    // Required parameters
    name: 'ncmin001'
    virtualNetworkGateway1: {
      id: '<id>'
    }
    // Non-required parameters
    connectionType: 'Vnet2Vnet'
    location: '<location>'
    virtualNetworkGateway2ResourceId: '<virtualNetworkGateway2ResourceId>'
    vpnSharedKey: '<vpnSharedKey>'
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "ncmin001"
    },
    "virtualNetworkGateway1": {
      "value": {
        "id": "<id>"
      }
    },
    // Non-required parameters
    "connectionType": {
      "value": "Vnet2Vnet"
    },
    "location": {
      "value": "<location>"
    },
    "virtualNetworkGateway2ResourceId": {
      "value": "<virtualNetworkGateway2ResourceId>"
    },
    "vpnSharedKey": {
      "value": "<vpnSharedKey>"
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/network/connection:<version>'

// Required parameters
param name = 'ncmin001'
virtualNetworkGateway1: {
  id: '<id>'
}
// Non-required parameters
param connectionType = 'Vnet2Vnet'
param location = '<location>'
virtualNetworkGateway2ResourceId: '<virtualNetworkGateway2ResourceId>'
param vpnSharedKey = '<vpnSharedKey>'
```

</details>
<p>

### Example 2: _IPSec connection with APIPA configuration_

This instance deploys the module with IPSec connection type and APIPA (gatewayCustomBgpIpAddresses) configuration.


<details>

<summary>via Bicep module</summary>

```bicep
module connection 'br/public:avm/res/network/connection:<version>' = {
  name: 'connectionDeployment'
  params: {
    // Required parameters
    name: 'ncapipa001'
    virtualNetworkGateway1: {
      id: '<id>'
    }
    // Non-required parameters
    connectionType: 'IPsec'
    customIPSecPolicy: {
      dhGroup: 'DHGroup14'
      ikeEncryption: 'AES256'
      ikeIntegrity: 'SHA256'
      ipsecEncryption: 'AES256'
      ipsecIntegrity: 'SHA256'
      pfsGroup: 'PFS14'
      saDataSizeKilobytes: 102400000
      saLifeTimeSeconds: 3600
    }
    enableBgp: true
    gatewayCustomBgpIpAddresses: [
      {
        customBgpIpAddress: '169.254.21.1'
        ipConfigurationId: '<ipConfigurationId>'
      }
    ]
    localNetworkGateway2ResourceId: '<localNetworkGateway2ResourceId>'
    location: '<location>'
    tags: {
      Environment: 'Test'
      'hidden-title': 'IPSec APIPA Connection Test'
      Role: 'DeploymentValidation'
    }
    useLocalAzureIpAddress: true
    vpnSharedKey: '<vpnSharedKey>'
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "ncapipa001"
    },
    "virtualNetworkGateway1": {
      "value": {
        "id": "<id>"
      }
    },
    // Non-required parameters
    "connectionType": {
      "value": "IPsec"
    },
    "customIPSecPolicy": {
      "value": {
        "dhGroup": "DHGroup14",
        "ikeEncryption": "AES256",
        "ikeIntegrity": "SHA256",
        "ipsecEncryption": "AES256",
        "ipsecIntegrity": "SHA256",
        "pfsGroup": "PFS14",
        "saDataSizeKilobytes": 102400000,
        "saLifeTimeSeconds": 3600
      }
    },
    "enableBgp": {
      "value": true
    },
    "gatewayCustomBgpIpAddresses": {
      "value": [
        {
          "customBgpIpAddress": "169.254.21.1",
          "ipConfigurationId": "<ipConfigurationId>"
        }
      ]
    },
    "localNetworkGateway2ResourceId": {
      "value": "<localNetworkGateway2ResourceId>"
    },
    "location": {
      "value": "<location>"
    },
    "tags": {
      "value": {
        "Environment": "Test",
        "hidden-title": "IPSec APIPA Connection Test",
        "Role": "DeploymentValidation"
      }
    },
    "useLocalAzureIpAddress": {
      "value": true
    },
    "vpnSharedKey": {
      "value": "<vpnSharedKey>"
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/network/connection:<version>'

// Required parameters
param name = 'ncapipa001'
virtualNetworkGateway1: {
  id: '<id>'
}
// Non-required parameters
param connectionType = 'IPsec'
param customIPSecPolicy = {
  dhGroup: 'DHGroup14'
  ikeEncryption: 'AES256'
  ikeIntegrity: 'SHA256'
  ipsecEncryption: 'AES256'
  ipsecIntegrity: 'SHA256'
  pfsGroup: 'PFS14'
  saDataSizeKilobytes: 102400000
  saLifeTimeSeconds: 3600
}
param enableBgp = true
param gatewayCustomBgpIpAddresses = [
  {
    customBgpIpAddress: '169.254.21.1'
    ipConfigurationId: '<ipConfigurationId>'
  }
]
localNetworkGateway2ResourceId: '<localNetworkGateway2ResourceId>'
param location = '<location>'
param tags = {
  Environment: 'Test'
  'hidden-title': 'IPSec APIPA Connection Test'
  Role: 'DeploymentValidation'
}
param useLocalAzureIpAddress = true
param vpnSharedKey = '<vpnSharedKey>'
```

</details>
<p>

### Example 3: _Using large parameter set_

This instance deploys the module with most of its features enabled.


<details>

<summary>via Bicep module</summary>

```bicep
module connection 'br/public:avm/res/network/connection:<version>' = {
  name: 'connectionDeployment'
  params: {
    // Required parameters
    name: 'ncmax001'
    virtualNetworkGateway1: {
      id: '<id>'
    }
    // Non-required parameters
    connectionType: 'Vnet2Vnet'
    dpdTimeoutSeconds: 45
    enableBgp: false
    location: '<location>'
    lock: {
      kind: 'CanNotDelete'
      name: 'myCustomLockName'
    }
    tags: {
      Environment: 'Non-Prod'
      'hidden-title': 'This is visible in the resource name'
      Role: 'DeploymentValidation'
    }
    usePolicyBasedTrafficSelectors: false
    virtualNetworkGateway2ResourceId: '<virtualNetworkGateway2ResourceId>'
    vpnSharedKey: '<vpnSharedKey>'
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "ncmax001"
    },
    "virtualNetworkGateway1": {
      "value": {
        "id": "<id>"
      }
    },
    // Non-required parameters
    "connectionType": {
      "value": "Vnet2Vnet"
    },
    "dpdTimeoutSeconds": {
      "value": 45
    },
    "enableBgp": {
      "value": false
    },
    "location": {
      "value": "<location>"
    },
    "lock": {
      "value": {
        "kind": "CanNotDelete",
        "name": "myCustomLockName"
      }
    },
    "tags": {
      "value": {
        "Environment": "Non-Prod",
        "hidden-title": "This is visible in the resource name",
        "Role": "DeploymentValidation"
      }
    },
    "usePolicyBasedTrafficSelectors": {
      "value": false
    },
    "virtualNetworkGateway2ResourceId": {
      "value": "<virtualNetworkGateway2ResourceId>"
    },
    "vpnSharedKey": {
      "value": "<vpnSharedKey>"
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/network/connection:<version>'

// Required parameters
param name = 'ncmax001'
virtualNetworkGateway1: {
  id: '<id>'
}
// Non-required parameters
param connectionType = 'Vnet2Vnet'
param dpdTimeoutSeconds = 45
param enableBgp = false
param location = '<location>'
param lock = {
  kind: 'CanNotDelete'
  name: 'myCustomLockName'
}
param tags = {
  Environment: 'Non-Prod'
  'hidden-title': 'This is visible in the resource name'
  Role: 'DeploymentValidation'
}
param usePolicyBasedTrafficSelectors = false
virtualNetworkGateway2ResourceId: '<virtualNetworkGateway2ResourceId>'
param vpnSharedKey = '<vpnSharedKey>'
```

</details>
<p>

### Example 4: _WAF-aligned_

This instance deploys the module in alignment with the best-practices of the Azure Well-Architected Framework.


<details>

<summary>via Bicep module</summary>

```bicep
module connection 'br/public:avm/res/network/connection:<version>' = {
  name: 'connectionDeployment'
  params: {
    // Required parameters
    name: 'ncwaf001'
    virtualNetworkGateway1: {
      id: '<id>'
    }
    // Non-required parameters
    connectionType: 'Vnet2Vnet'
    location: '<location>'
    lock: {
      kind: 'CanNotDelete'
      name: 'myCustomLockName'
    }
    tags: {
      Environment: 'Non-Prod'
      'hidden-title': 'This is visible in the resource name'
      Role: 'DeploymentValidation'
    }
    virtualNetworkGateway2ResourceId: '<virtualNetworkGateway2ResourceId>'
    vpnSharedKey: '<vpnSharedKey>'
  }
}
```

</details>
<p>

<details>

<summary>via JSON parameters file</summary>

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    // Required parameters
    "name": {
      "value": "ncwaf001"
    },
    "virtualNetworkGateway1": {
      "value": {
        "id": "<id>"
      }
    },
    // Non-required parameters
    "connectionType": {
      "value": "Vnet2Vnet"
    },
    "location": {
      "value": "<location>"
    },
    "lock": {
      "value": {
        "kind": "CanNotDelete",
        "name": "myCustomLockName"
      }
    },
    "tags": {
      "value": {
        "Environment": "Non-Prod",
        "hidden-title": "This is visible in the resource name",
        "Role": "DeploymentValidation"
      }
    },
    "virtualNetworkGateway2ResourceId": {
      "value": "<virtualNetworkGateway2ResourceId>"
    },
    "vpnSharedKey": {
      "value": "<vpnSharedKey>"
    }
  }
}
```

</details>
<p>

<details>

<summary>via Bicep parameters file</summary>

```bicep-params
using 'br/public:avm/res/network/connection:<version>'

// Required parameters
param name = 'ncwaf001'
virtualNetworkGateway1: {
  id: '<id>'
}
// Non-required parameters
param connectionType = 'Vnet2Vnet'
param location = '<location>'
param lock = {
  kind: 'CanNotDelete'
  name: 'myCustomLockName'
}
param tags = {
  Environment: 'Non-Prod'
  'hidden-title': 'This is visible in the resource name'
  Role: 'DeploymentValidation'
}
virtualNetworkGateway2ResourceId: '<virtualNetworkGateway2ResourceId>'
param vpnSharedKey = '<vpnSharedKey>'
```

</details>
<p>

## Parameters

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`name`](#parameter-name) | string | Remote connection name. |
| [`virtualNetworkGateway1`](#parameter-virtualnetworkgateway1) | object | The primary Virtual Network Gateway. |

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`authorizationKey`](#parameter-authorizationkey) | securestring | The Authorization Key to connect to an Express Route Circuit. Used for connection type [ExpressRoute]. |
| [`connectionMode`](#parameter-connectionmode) | string | The connection connectionMode for this connection. Available for IPSec connections. |
| [`connectionProtocol`](#parameter-connectionprotocol) | string | Connection connectionProtocol used for this connection. Available for IPSec connections. |
| [`connectionType`](#parameter-connectiontype) | string | Gateway connection connectionType. |
| [`customIPSecPolicy`](#parameter-customipsecpolicy) | object | The IPSec Policies to be considered by this connection. |
| [`dpdTimeoutSeconds`](#parameter-dpdtimeoutseconds) | int | The dead peer detection timeout of this connection in seconds. Setting the timeout to shorter periods will cause IKE to rekey more aggressively, causing the connection to appear to be disconnected in some instances. The general recommendation is to set the timeout between 30 to 45 seconds. |
| [`enableBgp`](#parameter-enablebgp) | bool | Value to specify if BGP is enabled or not. |
| [`enablePrivateLinkFastPath`](#parameter-enableprivatelinkfastpath) | bool | Bypass the ExpressRoute gateway when accessing private-links. ExpressRoute FastPath (expressRouteGatewayBypass) must be enabled. Only available when connection connectionType is Express Route. |
| [`enableTelemetry`](#parameter-enabletelemetry) | bool | Enable/Disable usage telemetry for module. |
| [`expressRouteGatewayBypass`](#parameter-expressroutegatewaybypass) | bool | Bypass ExpressRoute Gateway for data forwarding. Only available when connection connectionType is Express Route. |
| [`gatewayCustomBgpIpAddresses`](#parameter-gatewaycustombgpipaddresses) | array | GatewayCustomBgpIpAddresses to be used for virtual network gateway Connection. Enables APIPA (Automatic Private IP Addressing) for custom BGP IP addresses on both Azure and on-premises sides. |
| [`localNetworkGateway2ResourceId`](#parameter-localnetworkgateway2resourceid) | string | The local network gateway resource ID. Used for connection type [IPsec]. |
| [`location`](#parameter-location) | string | Location for all resources. |
| [`lock`](#parameter-lock) | object | The lock settings of the service. |
| [`peerResourceId`](#parameter-peerresourceid) | string | The remote peer resource ID. Used for connection connectionType [ExpressRoute]. |
| [`routingWeight`](#parameter-routingweight) | int | The weight added to routes learned from this BGP speaker. |
| [`tags`](#parameter-tags) | object | Tags of the resource. |
| [`trafficSelectorPolicies`](#parameter-trafficselectorpolicies) | array | The traffic selector policies to be considered by this connection. |
| [`useLocalAzureIpAddress`](#parameter-uselocalazureipaddress) | bool | Use private local Azure IP for the connection. Only available for IPSec Virtual Network Gateways that use the Azure Private IP Property. |
| [`usePolicyBasedTrafficSelectors`](#parameter-usepolicybasedtrafficselectors) | bool | Enable policy-based traffic selectors. |
| [`virtualNetworkGateway2ResourceId`](#parameter-virtualnetworkgateway2resourceid) | string | The remote Virtual Network Gateway resource ID. Used for connection connectionType [Vnet2Vnet]. |
| [`vpnSharedKey`](#parameter-vpnsharedkey) | securestring | Specifies a VPN shared key. The same value has to be specified on both Virtual Network Gateways. |

### Parameter: `name`

Remote connection name.

- Required: Yes
- Type: string

### Parameter: `virtualNetworkGateway1`

The primary Virtual Network Gateway.

- Required: Yes
- Type: object

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`id`](#parameter-virtualnetworkgateway1id) | string | Resource ID of the virtual network gateway. |

### Parameter: `virtualNetworkGateway1.id`

Resource ID of the virtual network gateway.

- Required: Yes
- Type: string

### Parameter: `authorizationKey`

The Authorization Key to connect to an Express Route Circuit. Used for connection type [ExpressRoute].

- Required: No
- Type: securestring
- Default: `''`

### Parameter: `connectionMode`

The connection connectionMode for this connection. Available for IPSec connections.

- Required: No
- Type: string
- Default: `'Default'`
- Allowed:
  ```Bicep
  [
    'Default'
    'InitiatorOnly'
    'ResponderOnly'
  ]
  ```

### Parameter: `connectionProtocol`

Connection connectionProtocol used for this connection. Available for IPSec connections.

- Required: No
- Type: string
- Default: `'IKEv2'`
- Allowed:
  ```Bicep
  [
    'IKEv1'
    'IKEv2'
  ]
  ```

### Parameter: `connectionType`

Gateway connection connectionType.

- Required: No
- Type: string
- Default: `'IPsec'`
- Allowed:
  ```Bicep
  [
    'ExpressRoute'
    'IPsec'
    'Vnet2Vnet'
    'VPNClient'
  ]
  ```

### Parameter: `customIPSecPolicy`

The IPSec Policies to be considered by this connection.

- Required: No
- Type: object
- Default:
  ```Bicep
  {
      dhGroup: 'None'
      ikeEncryption: 'DES'
      ikeIntegrity: 'MD5'
      ipsecEncryption: 'None'
      ipsecIntegrity: 'MD5'
      pfsGroup: 'None'
      saDataSizeKilobytes: 0
      saLifeTimeSeconds: 0
  }
  ```

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`dhGroup`](#parameter-customipsecpolicydhgroup) | string | The DH Group used in IKE Phase 1 for initial SA. |
| [`ikeEncryption`](#parameter-customipsecpolicyikeencryption) | string | The IKE encryption algorithm (IKE phase 2). |
| [`ikeIntegrity`](#parameter-customipsecpolicyikeintegrity) | string | The IKE integrity algorithm (IKE phase 2). |
| [`ipsecEncryption`](#parameter-customipsecpolicyipsecencryption) | string | The IPSec encryption algorithm (IKE phase 1). |
| [`ipsecIntegrity`](#parameter-customipsecpolicyipsecintegrity) | string | The IPSec integrity algorithm (IKE phase 1). |
| [`pfsGroup`](#parameter-customipsecpolicypfsgroup) | string | The Pfs Group used in IKE Phase 2 for new child SA. |
| [`saDataSizeKilobytes`](#parameter-customipsecpolicysadatasizekilobytes) | int | The IPSec Security Association (also called Quick Mode or Phase 2 SA) payload size in KB for a site to site VPN tunnel. |
| [`saLifeTimeSeconds`](#parameter-customipsecpolicysalifetimeseconds) | int | The IPSec Security Association (also called Quick Mode or Phase 2 SA) lifetime in seconds for a site to site VPN tunnel. |

### Parameter: `customIPSecPolicy.dhGroup`

The DH Group used in IKE Phase 1 for initial SA.

- Required: Yes
- Type: string
- Allowed:
  ```Bicep
  [
    'DHGroup1'
    'DHGroup14'
    'DHGroup2'
    'DHGroup2048'
    'DHGroup24'
    'ECP256'
    'ECP384'
    'None'
  ]
  ```

### Parameter: `customIPSecPolicy.ikeEncryption`

The IKE encryption algorithm (IKE phase 2).

- Required: Yes
- Type: string
- Allowed:
  ```Bicep
  [
    'AES128'
    'AES192'
    'AES256'
    'DES'
    'DES3'
    'GCMAES128'
    'GCMAES256'
  ]
  ```

### Parameter: `customIPSecPolicy.ikeIntegrity`

The IKE integrity algorithm (IKE phase 2).

- Required: Yes
- Type: string
- Allowed:
  ```Bicep
  [
    'GCMAES128'
    'GCMAES256'
    'MD5'
    'SHA1'
    'SHA256'
    'SHA384'
  ]
  ```

### Parameter: `customIPSecPolicy.ipsecEncryption`

The IPSec encryption algorithm (IKE phase 1).

- Required: Yes
- Type: string
- Allowed:
  ```Bicep
  [
    'AES128'
    'AES192'
    'AES256'
    'DES'
    'DES3'
    'GCMAES128'
    'GCMAES192'
    'GCMAES256'
    'None'
  ]
  ```

### Parameter: `customIPSecPolicy.ipsecIntegrity`

The IPSec integrity algorithm (IKE phase 1).

- Required: Yes
- Type: string
- Allowed:
  ```Bicep
  [
    'GCMAES128'
    'GCMAES192'
    'GCMAES256'
    'MD5'
    'SHA1'
    'SHA256'
  ]
  ```

### Parameter: `customIPSecPolicy.pfsGroup`

The Pfs Group used in IKE Phase 2 for new child SA.

- Required: Yes
- Type: string
- Allowed:
  ```Bicep
  [
    'ECP256'
    'ECP384'
    'None'
    'PFS1'
    'PFS14'
    'PFS2'
    'PFS2048'
    'PFS24'
    'PFSMM'
  ]
  ```

### Parameter: `customIPSecPolicy.saDataSizeKilobytes`

The IPSec Security Association (also called Quick Mode or Phase 2 SA) payload size in KB for a site to site VPN tunnel.

- Required: Yes
- Type: int

### Parameter: `customIPSecPolicy.saLifeTimeSeconds`

The IPSec Security Association (also called Quick Mode or Phase 2 SA) lifetime in seconds for a site to site VPN tunnel.

- Required: Yes
- Type: int

### Parameter: `dpdTimeoutSeconds`

The dead peer detection timeout of this connection in seconds. Setting the timeout to shorter periods will cause IKE to rekey more aggressively, causing the connection to appear to be disconnected in some instances. The general recommendation is to set the timeout between 30 to 45 seconds.

- Required: No
- Type: int
- Default: `45`
- MinValue: 9
- MaxValue: 3600

### Parameter: `enableBgp`

Value to specify if BGP is enabled or not.

- Required: No
- Type: bool
- Default: `False`

### Parameter: `enablePrivateLinkFastPath`

Bypass the ExpressRoute gateway when accessing private-links. ExpressRoute FastPath (expressRouteGatewayBypass) must be enabled. Only available when connection connectionType is Express Route.

- Required: No
- Type: bool
- Default: `False`

### Parameter: `enableTelemetry`

Enable/Disable usage telemetry for module.

- Required: No
- Type: bool
- Default: `True`

### Parameter: `expressRouteGatewayBypass`

Bypass ExpressRoute Gateway for data forwarding. Only available when connection connectionType is Express Route.

- Required: No
- Type: bool
- Default: `False`

### Parameter: `gatewayCustomBgpIpAddresses`

GatewayCustomBgpIpAddresses to be used for virtual network gateway Connection. Enables APIPA (Automatic Private IP Addressing) for custom BGP IP addresses on both Azure and on-premises sides.

- Required: No
- Type: array
- Default: `[]`

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`customBgpIpAddress`](#parameter-gatewaycustombgpipaddressescustombgpipaddress) | string | The custom BgpPeeringAddress which belongs to IpconfigurationId. |
| [`ipConfigurationId`](#parameter-gatewaycustombgpipaddressesipconfigurationid) | string | The IpconfigurationId of ipconfiguration which belongs to gateway. |

### Parameter: `gatewayCustomBgpIpAddresses.customBgpIpAddress`

The custom BgpPeeringAddress which belongs to IpconfigurationId.

- Required: Yes
- Type: string

### Parameter: `gatewayCustomBgpIpAddresses.ipConfigurationId`

The IpconfigurationId of ipconfiguration which belongs to gateway.

- Required: Yes
- Type: string

### Parameter: `localNetworkGateway2ResourceId`

The local network gateway resource ID. Used for connection type [IPsec].

- Required: No
- Type: string
- Default: `''`

### Parameter: `location`

Location for all resources.

- Required: No
- Type: string
- Default: `[resourceGroup().location]`

### Parameter: `lock`

The lock settings of the service.

- Required: No
- Type: object

**Optional parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`kind`](#parameter-lockkind) | string | Specify the type of lock. |
| [`name`](#parameter-lockname) | string | Specify the name of lock. |

### Parameter: `lock.kind`

Specify the type of lock.

- Required: No
- Type: string
- Allowed:
  ```Bicep
  [
    'CanNotDelete'
    'None'
    'ReadOnly'
  ]
  ```

### Parameter: `lock.name`

Specify the name of lock.

- Required: No
- Type: string

### Parameter: `peerResourceId`

The remote peer resource ID. Used for connection connectionType [ExpressRoute].

- Required: No
- Type: string
- Default: `''`

### Parameter: `routingWeight`

The weight added to routes learned from this BGP speaker.

- Required: No
- Type: int

### Parameter: `tags`

Tags of the resource.

- Required: No
- Type: object

### Parameter: `trafficSelectorPolicies`

The traffic selector policies to be considered by this connection.

- Required: No
- Type: array
- Default: `[]`

**Required parameters**

| Parameter | Type | Description |
| :-- | :-- | :-- |
| [`localAddressRanges`](#parameter-trafficselectorpolicieslocaladdressranges) | array | A collection of local address spaces in CIDR format. |
| [`remoteAddressRanges`](#parameter-trafficselectorpoliciesremoteaddressranges) | array | A collection of remote address spaces in CIDR format. |

### Parameter: `trafficSelectorPolicies.localAddressRanges`

A collection of local address spaces in CIDR format.

- Required: Yes
- Type: array

### Parameter: `trafficSelectorPolicies.remoteAddressRanges`

A collection of remote address spaces in CIDR format.

- Required: Yes
- Type: array

### Parameter: `useLocalAzureIpAddress`

Use private local Azure IP for the connection. Only available for IPSec Virtual Network Gateways that use the Azure Private IP Property.

- Required: No
- Type: bool
- Default: `False`

### Parameter: `usePolicyBasedTrafficSelectors`

Enable policy-based traffic selectors.

- Required: No
- Type: bool
- Default: `False`

### Parameter: `virtualNetworkGateway2ResourceId`

The remote Virtual Network Gateway resource ID. Used for connection connectionType [Vnet2Vnet].

- Required: No
- Type: string
- Default: `''`

### Parameter: `vpnSharedKey`

Specifies a VPN shared key. The same value has to be specified on both Virtual Network Gateways.

- Required: No
- Type: securestring
- Default: `''`

## Outputs

| Output | Type | Description |
| :-- | :-- | :-- |
| `location` | string | The location the resource was deployed into. |
| `name` | string | The name of the remote connection. |
| `resourceGroupName` | string | The resource group the remote connection was deployed into. |
| `resourceId` | string | The resource ID of the remote connection. |

## Cross-referenced modules

This section gives you an overview of all local-referenced module files (i.e., other modules that are referenced in this module) and all remote-referenced files (i.e., Bicep modules that are referenced from a Bicep Registry or Template Specs).

| Reference | Type |
| :-- | :-- |
| `br/public:avm/utl/types/avm-common-types:0.5.1` | Remote reference |

## Notes

### Parameter Usage: `localNetworkGateway2`

The local virtual network gateway object.

<details>

<summary>Parameter JSON format</summary>

```json
"localNetworkGateway2": {
    "value": {
        "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myRG/providers/Microsoft.Network/localNetworkGateways/myGateway"
    }
}
```

</details>

<details>

<summary>Bicep format</summary>

```bicep
localNetworkGateway2: {
    id: '/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myRG/providers/Microsoft.Network/localNetworkGateways/myGateway'
}
```

</details>
<p>

### Parameter Usage: `peer`

The remote peer object used for ExpressRoute connections

<details>

<summary>Parameter JSON format</summary>

```json
"peer": {
    "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myRG/providers/Microsoft.Network/expressRouteCircuits/expressRoute"
}
```

</details>

<details>

<summary>Bicep format</summary>

```bicep
'peer': {
    id: '/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myRG/providers/Microsoft.Network/expressRouteCircuits/expressRoute'
}
```

</details>
<p>

### Parameter Usage: `customIPSecPolicy`

If ipsecEncryption parameter is empty, customIPSecPolicy will not be deployed. The parameter file should look like below.

<details>

<summary>Parameter JSON format</summary>

```json
"customIPSecPolicy": {
    "value": {
        "saLifeTimeSeconds": 0,
        "saDataSizeKilobytes": 0,
        "ipsecEncryption": "",
        "ipsecIntegrity": "",
        "ikeEncryption": "",
        "ikeIntegrity": "",
        "dhGroup": "",
        "pfsGroup": ""
    }
}
```

</details>

<details>

<summary>Bicep format</summary>

```bicep
customIPSecPolicy: {
    saLifeTimeSeconds: 0
    saDataSizeKilobytes: 0
    ipsecEncryption: ''
    ipsecIntegrity: ''
    ikeEncryption: ''
    ikeIntegrity: ''
    dhGroup: ''
    pfsGroup: ''
}
```

</details>
<p>

Format of the full customIPSecPolicy parameter in parameter file.

<details>

<summary>Parameter JSON format</summary>

```json
"customIPSecPolicy": {
    "value": {
        "saLifeTimeSeconds": 28800,
        "saDataSizeKilobytes": 102400000,
        "ipsecEncryption": "AES256",
        "ipsecIntegrity": "SHA256",
        "ikeEncryption": "AES256",
        "ikeIntegrity": "SHA256",
        "dhGroup": "DHGroup14",
        "pfsGroup": "None"
    }
}
```

</details>

<details>

<summary>Bicep format</summary>

```bicep
customIPSecPolicy: {
    saLifeTimeSeconds: 28800
    saDataSizeKilobytes: 102400000
    ipsecEncryption: 'AES256'
    ipsecIntegrity: 'SHA256'
    ikeEncryption: 'AES256'
    ikeIntegrity: 'SHA256'
    dhGroup: 'DHGroup14'
    pfsGroup: 'None'
}
```

</details>
<p>

## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the [repository](https://aka.ms/avm/telemetry). There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
