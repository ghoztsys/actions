# `ghoztsys/actions/gcloud-artifacts-auth` ![GitHub Release](https://img.shields.io/github/v/release/ghoztsys/actions?label=latest)

Authenticates to Google Artifact Registry.

## Usage

```yml
permissions:
  contents: read
  id-token: write
steps:
  - uses: ghoztsys/actions/gcloud-artifacts-auth@v2
    with:
      registry: ${{ vars.GCP_CORE_CONTAINER_REGISTRY }}
      service-account: ${{ github.event_name == 'release' && vars.GCP_CORE_SERVICE_ACCOUNT_PROD || vars.GCP_CORE_SERVICE_ACCOUNT_DEV }}
      workload-identity-provider: ${{ github.event_name == 'release' && vars.GCP_CORE_WORKLOAD_IDENTITY_PROVIDER_PROD || vars.GCP_CORE_WORKLOAD_IDENTITY_PROVIDER_DEV }}
```

### Inputs

| Input | Required | Default | Description |
| ----- | -------- | ------- | ----------- |
| `registry` | `false` | `us-docker.pkg.dev` | Registry host (i.e. `<location>-docker.pkg.dev` for GAR or `gcr.io` for GCR) |
| `service-account` | `true` | | GCP service account to impersonate by the Workload Identity |
| `workload-identity-provider` | `true` | | Workload Identity Provider name, i.e. `projects/123456789/locations/global/workloadIdentityPools/my-pool/providers/my-provider` |

### Outputs

| Output | Description |
| ------ | ----------- |
| `repository` | Google Artifact Registry repository (i.e. `<registry_host>/<project_id>`) |

## Permissions

Required permissions:

```yml
permissions:
  contents: read
  id-token: write
```
