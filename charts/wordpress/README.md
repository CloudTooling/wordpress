# wordpress

![Version: 1.0.4](https://img.shields.io/badge/Version-1.0.4-informational?style=flat-square) ![AppVersion: 7.0.2](https://img.shields.io/badge/AppVersion-7.0.2-informational?style=flat-square)

WordPress is the world's most popular blogging and content management platform. Powerful yet simple, everyone from students to global corporations use it to build beautiful, functional websites.

**Homepage:** <https://github.com/CloudTooling>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Martin Reinhardt |  | <https://m13t.de> |

## Source Code

* <https://github.com/CloudTooling/wordpress>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| oci://registry-1.docker.io/bitnamicharts | common | 2.x.x |
| oci://registry-1.docker.io/bitnamicharts | mariadb | 26.x.x |
| oci://registry-1.docker.io/bitnamicharts | memcached | 8.x.x |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| allowEmptyPassword | bool | `true` |  |
| allowOverrideNone | bool | `false` |  |
| apacheConfiguration | string | `""` |  |
| args | list | `[]` |  |
| automountServiceAccountToken | bool | `false` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `11` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPU | int | `50` |  |
| autoscaling.targetMemory | int | `50` |  |
| clusterDomain | string | `"cluster.local"` |  |
| command | list | `[]` |  |
| commonAnnotations | object | `{}` |  |
| commonLabels | object | `{}` |  |
| containerPorts.http | int | `8080` |  |
| containerPorts.https | int | `8443` |  |
| containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| containerSecurityContext.enabled | bool | `true` |  |
| containerSecurityContext.privileged | bool | `false` |  |
| containerSecurityContext.readOnlyRootFilesystem | bool | `true` |  |
| containerSecurityContext.runAsGroup | int | `1001` |  |
| containerSecurityContext.runAsNonRoot | bool | `true` |  |
| containerSecurityContext.runAsUser | int | `1001` |  |
| containerSecurityContext.seLinuxOptions | object | `{}` |  |
| containerSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| customHTAccessCM | string | `""` |  |
| customLivenessProbe | object | `{}` |  |
| customPostInitScripts | object | `{}` |  |
| customReadinessProbe | object | `{}` |  |
| customStartupProbe | object | `{}` |  |
| diagnosticMode.args[0] | string | `"infinity"` |  |
| diagnosticMode.command[0] | string | `"sleep"` |  |
| diagnosticMode.enabled | bool | `false` |  |
| existingApacheConfigurationConfigMap | string | `""` |  |
| existingSecret | string | `""` |  |
| existingWordPressConfigurationSecret | string | `""` |  |
| externalCache.host | string | `"localhost"` |  |
| externalCache.port | int | `11211` |  |
| externalDatabase.database | string | `"bitnami_wordpress"` |  |
| externalDatabase.existingSecret | string | `""` |  |
| externalDatabase.host | string | `"localhost"` |  |
| externalDatabase.password | string | `""` |  |
| externalDatabase.port | int | `3306` |  |
| externalDatabase.user | string | `"bn_wordpress"` |  |
| extraContainerPorts | list | `[]` |  |
| extraDeploy | list | `[]` |  |
| extraEnvVars | list | `[]` |  |
| extraEnvVarsCM | string | `""` |  |
| extraEnvVarsSecret | string | `""` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| fips.openssl | string | `""` |  |
| fullnameOverride | string | `""` |  |
| global.compatibility.openshift.adaptSecurityContext | string | `"auto"` |  |
| global.defaultFips | string | `"restricted"` |  |
| global.defaultStorageClass | string | `""` |  |
| global.imagePullSecrets | list | `[]` |  |
| global.imageRegistry | string | `""` |  |
| global.security.allowInsecureImages | bool | `false` |  |
| hostAliases[0].hostnames[0] | string | `"status.localhost"` |  |
| hostAliases[0].ip | string | `"127.0.0.1"` |  |
| htaccessPersistenceEnabled | bool | `false` |  |
| httpRoute.annotations | object | `{}` |  |
| httpRoute.enabled | bool | `false` |  |
| httpRoute.extraRules | list | `[]` |  |
| httpRoute.filters | list | `[]` |  |
| httpRoute.hostnames[0] | string | `"wordpress.local"` |  |
| httpRoute.labels | object | `{}` |  |
| httpRoute.matches[0].path.type | string | `"PathPrefix"` |  |
| httpRoute.matches[0].path.value | string | `"/"` |  |
| httpRoute.parentRefs | list | `[]` |  |
| image.debug | bool | `false` |  |
| image.digest | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.pullSecrets | list | `[]` |  |
| image.registry | string | `"docker.io"` |  |
| image.repository | string | `"cloudtooling/wordpress"` |  |
| image.tag | string | `"7.0.2"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.apiVersion | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.extraHosts | list | `[]` |  |
| ingress.extraPaths | list | `[]` |  |
| ingress.extraRules | list | `[]` |  |
| ingress.extraTls | list | `[]` |  |
| ingress.hostname | string | `"wordpress.local"` |  |
| ingress.ingressClassName | string | `""` |  |
| ingress.path | string | `"/"` |  |
| ingress.pathType | string | `"ImplementationSpecific"` |  |
| ingress.secrets | list | `[]` |  |
| ingress.selfSigned | bool | `false` |  |
| ingress.tls | bool | `false` |  |
| ingress.tlsWwwPrefix | bool | `false` |  |
| initContainers | list | `[]` |  |
| kubeVersion | string | `""` |  |
| lifecycleHooks | object | `{}` |  |
| livenessProbe.enabled | bool | `true` |  |
| livenessProbe.failureThreshold | int | `6` |  |
| livenessProbe.initialDelaySeconds | int | `120` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.tcpSocket.port | string | `"http"` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| mariadb.architecture | string | `"standalone"` |  |
| mariadb.auth.database | string | `"bitnami_wordpress"` |  |
| mariadb.auth.password | string | `""` |  |
| mariadb.auth.rootPassword | string | `""` |  |
| mariadb.auth.username | string | `"bn_wordpress"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.primary.fips.openssl | string | `""` |  |
| mariadb.primary.persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| mariadb.primary.persistence.enabled | bool | `true` |  |
| mariadb.primary.persistence.size | string | `"8Gi"` |  |
| mariadb.primary.persistence.storageClass | string | `""` |  |
| mariadb.primary.resources | object | `{}` |  |
| mariadb.primary.resourcesPreset | string | `"micro"` |  |
| memcached.auth.enabled | bool | `false` |  |
| memcached.auth.existingPasswordSecret | string | `""` |  |
| memcached.auth.password | string | `""` |  |
| memcached.auth.username | string | `""` |  |
| memcached.enabled | bool | `false` |  |
| memcached.fips.openssl | string | `""` |  |
| memcached.resources | object | `{}` |  |
| memcached.resourcesPreset | string | `"nano"` |  |
| memcached.service.port | int | `11211` |  |
| metrics.containerPorts.metrics | int | `9117` |  |
| metrics.containerSecurityContext.allowPrivilegeEscalation | bool | `false` |  |
| metrics.containerSecurityContext.capabilities.drop[0] | string | `"ALL"` |  |
| metrics.containerSecurityContext.enabled | bool | `true` |  |
| metrics.containerSecurityContext.privileged | bool | `false` |  |
| metrics.containerSecurityContext.readOnlyRootFilesystem | bool | `true` |  |
| metrics.containerSecurityContext.runAsGroup | int | `1001` |  |
| metrics.containerSecurityContext.runAsNonRoot | bool | `true` |  |
| metrics.containerSecurityContext.runAsUser | int | `1001` |  |
| metrics.containerSecurityContext.seLinuxOptions | object | `{}` |  |
| metrics.containerSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| metrics.customLivenessProbe | object | `{}` |  |
| metrics.customReadinessProbe | object | `{}` |  |
| metrics.customStartupProbe | object | `{}` |  |
| metrics.enabled | bool | `false` |  |
| metrics.fips.golang | string | `"restricted"` |  |
| metrics.fips.openssl | string | `""` |  |
| metrics.image.digest | string | `""` |  |
| metrics.image.pullPolicy | string | `"IfNotPresent"` |  |
| metrics.image.pullSecrets | list | `[]` |  |
| metrics.image.registry | string | `"registry-1.docker.io"` |  |
| metrics.image.repository | string | `"bitnami/apache-exporter"` |  |
| metrics.image.tag | string | `"latest"` |  |
| metrics.livenessProbe.enabled | bool | `true` |  |
| metrics.livenessProbe.failureThreshold | int | `3` |  |
| metrics.livenessProbe.initialDelaySeconds | int | `15` |  |
| metrics.livenessProbe.periodSeconds | int | `10` |  |
| metrics.livenessProbe.successThreshold | int | `1` |  |
| metrics.livenessProbe.timeoutSeconds | int | `5` |  |
| metrics.podAnnotations | object | `{}` |  |
| metrics.readinessProbe.enabled | bool | `true` |  |
| metrics.readinessProbe.failureThreshold | int | `3` |  |
| metrics.readinessProbe.initialDelaySeconds | int | `5` |  |
| metrics.readinessProbe.periodSeconds | int | `10` |  |
| metrics.readinessProbe.successThreshold | int | `1` |  |
| metrics.readinessProbe.timeoutSeconds | int | `3` |  |
| metrics.resources | object | `{}` |  |
| metrics.resourcesPreset | string | `"nano"` |  |
| metrics.service.annotations."prometheus.io/port" | string | `"{{ .Values.metrics.containerPorts.metrics }}"` |  |
| metrics.service.annotations."prometheus.io/scrape" | string | `"true"` |  |
| metrics.service.ports.metrics | int | `9150` |  |
| metrics.serviceMonitor.enabled | bool | `false` |  |
| metrics.serviceMonitor.honorLabels | bool | `false` |  |
| metrics.serviceMonitor.interval | string | `""` |  |
| metrics.serviceMonitor.jobLabel | string | `""` |  |
| metrics.serviceMonitor.labels | object | `{}` |  |
| metrics.serviceMonitor.metricRelabelings | list | `[]` |  |
| metrics.serviceMonitor.namespace | string | `""` |  |
| metrics.serviceMonitor.relabelings | list | `[]` |  |
| metrics.serviceMonitor.scrapeTimeout | string | `""` |  |
| metrics.serviceMonitor.selector | object | `{}` |  |
| metrics.startupProbe.enabled | bool | `false` |  |
| metrics.startupProbe.failureThreshold | int | `15` |  |
| metrics.startupProbe.initialDelaySeconds | int | `10` |  |
| metrics.startupProbe.periodSeconds | int | `10` |  |
| metrics.startupProbe.successThreshold | int | `1` |  |
| metrics.startupProbe.timeoutSeconds | int | `1` |  |
| multisite.enable | bool | `false` |  |
| multisite.enableNipIoRedirect | bool | `false` |  |
| multisite.host | string | `""` |  |
| multisite.networkType | string | `"subdomain"` |  |
| nameOverride | string | `""` |  |
| networkPolicy.allowExternal | bool | `true` |  |
| networkPolicy.allowExternalEgress | bool | `true` |  |
| networkPolicy.enabled | bool | `true` |  |
| networkPolicy.extraEgress | list | `[]` |  |
| networkPolicy.extraIngress | list | `[]` |  |
| networkPolicy.ingressNSMatchLabels | object | `{}` |  |
| networkPolicy.ingressNSPodMatchLabels | object | `{}` |  |
| nodeAffinityPreset.key | string | `""` |  |
| nodeAffinityPreset.type | string | `""` |  |
| nodeAffinityPreset.values | list | `[]` |  |
| nodeSelector | object | `{}` |  |
| overrideDatabaseSettings | bool | `false` |  |
| pdb.create | bool | `true` |  |
| pdb.maxUnavailable | string | `""` |  |
| pdb.minAvailable | string | `""` |  |
| persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.annotations | object | `{}` |  |
| persistence.dataSource | object | `{}` |  |
| persistence.enabled | bool | `true` |  |
| persistence.existingClaim | string | `""` |  |
| persistence.selector | object | `{}` |  |
| persistence.size | string | `"10Gi"` |  |
| persistence.storageClass | string | `""` |  |
| podAffinityPreset | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podAntiAffinityPreset | string | `"soft"` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.enabled | bool | `true` |  |
| podSecurityContext.fsGroup | int | `1001` |  |
| podSecurityContext.fsGroupChangePolicy | string | `"Always"` |  |
| podSecurityContext.supplementalGroups | list | `[]` |  |
| podSecurityContext.sysctls | list | `[]` |  |
| priorityClassName | string | `""` |  |
| readinessProbe.enabled | bool | `true` |  |
| readinessProbe.failureThreshold | int | `6` |  |
| readinessProbe.httpGet.httpHeaders | list | `[]` |  |
| readinessProbe.httpGet.path | string | `"/wp-login.php"` |  |
| readinessProbe.httpGet.port | string | `"{{ .Values.wordpressScheme }}"` |  |
| readinessProbe.httpGet.scheme | string | `"{{ .Values.wordpressScheme | upper }}"` |  |
| readinessProbe.initialDelaySeconds | int | `30` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.timeoutSeconds | int | `5` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| resourcesPreset | string | `"micro"` |  |
| runtimeClassName | string | `""` |  |
| schedulerName | string | `""` |  |
| secondaryIngress.annotations | object | `{}` |  |
| secondaryIngress.apiVersion | string | `""` |  |
| secondaryIngress.enabled | bool | `false` |  |
| secondaryIngress.extraHosts | list | `[]` |  |
| secondaryIngress.extraPaths | list | `[]` |  |
| secondaryIngress.extraRules | list | `[]` |  |
| secondaryIngress.extraTls | list | `[]` |  |
| secondaryIngress.hostname | string | `"wordpress.local"` |  |
| secondaryIngress.ingressClassName | string | `""` |  |
| secondaryIngress.path | string | `"/"` |  |
| secondaryIngress.pathType | string | `"ImplementationSpecific"` |  |
| secondaryIngress.secrets | list | `[]` |  |
| secondaryIngress.selfSigned | bool | `false` |  |
| secondaryIngress.tls | bool | `false` |  |
| secondaryIngress.tlsWwwPrefix | bool | `false` |  |
| service.annotations | object | `{}` |  |
| service.clusterIP | string | `""` |  |
| service.externalTrafficPolicy | string | `"Cluster"` |  |
| service.extraPorts | list | `[]` |  |
| service.httpsTargetPort | string | `"https"` |  |
| service.loadBalancerIP | string | `""` |  |
| service.loadBalancerSourceRanges | list | `[]` |  |
| service.nodePorts.http | string | `""` |  |
| service.nodePorts.https | string | `""` |  |
| service.ports.http | int | `80` |  |
| service.ports.https | int | `443` |  |
| service.sessionAffinity | string | `"None"` |  |
| service.sessionAffinityConfig | object | `{}` |  |
| service.type | string | `"LoadBalancer"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automountServiceAccountToken | bool | `false` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| sidecars | list | `[]` |  |
| smtpExistingSecret | string | `""` |  |
| smtpFromEmail | string | `""` |  |
| smtpFromName | string | `""` |  |
| smtpHost | string | `""` |  |
| smtpPassword | string | `""` |  |
| smtpPort | string | `""` |  |
| smtpProtocol | string | `""` |  |
| smtpUser | string | `""` |  |
| startupProbe.enabled | bool | `false` |  |
| startupProbe.failureThreshold | int | `6` |  |
| startupProbe.httpGet.httpHeaders | list | `[]` |  |
| startupProbe.httpGet.path | string | `"/wp-login.php"` |  |
| startupProbe.httpGet.port | string | `"{{ .Values.wordpressScheme }}"` |  |
| startupProbe.httpGet.scheme | string | `"{{ .Values.wordpressScheme | upper }}"` |  |
| startupProbe.initialDelaySeconds | int | `30` |  |
| startupProbe.periodSeconds | int | `10` |  |
| startupProbe.successThreshold | int | `1` |  |
| startupProbe.timeoutSeconds | int | `5` |  |
| terminationGracePeriodSeconds | string | `""` |  |
| tolerations | list | `[]` |  |
| topologySpreadConstraints | list | `[]` |  |
| updateStrategy.type | string | `"RollingUpdate"` |  |
| usePasswordFiles | bool | `true` |  |
| volumePermissions.containerSecurityContext.runAsUser | int | `0` |  |
| volumePermissions.containerSecurityContext.seLinuxOptions | object | `{}` |  |
| volumePermissions.enabled | bool | `false` |  |
| volumePermissions.fips.openssl | string | `""` |  |
| volumePermissions.image.digest | string | `""` |  |
| volumePermissions.image.pullPolicy | string | `"IfNotPresent"` |  |
| volumePermissions.image.pullSecrets | list | `[]` |  |
| volumePermissions.image.registry | string | `"registry-1.docker.io"` |  |
| volumePermissions.image.repository | string | `"bitnami/os-shell"` |  |
| volumePermissions.image.tag | string | `"latest"` |  |
| volumePermissions.resources | object | `{}` |  |
| volumePermissions.resourcesPreset | string | `"nano"` |  |
| wordpressBlogName | string | `"User's Blog!"` |  |
| wordpressConfiguration | string | `""` |  |
| wordpressConfigureCache | bool | `false` |  |
| wordpressEmail | string | `"user@example.com"` |  |
| wordpressExtraConfigContent | string | `""` |  |
| wordpressFirstName | string | `"FirstName"` |  |
| wordpressHost | string | `""` |  |
| wordpressLastName | string | `"LastName"` |  |
| wordpressPassword | string | `""` |  |
| wordpressPlugins | string | `"none"` |  |
| wordpressScheme | string | `"http"` |  |
| wordpressSkipInstall | bool | `false` |  |
| wordpressTablePrefix | string | `"wp_"` |  |
| wordpressUsername | string | `"user"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
