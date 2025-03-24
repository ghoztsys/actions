# `ghoztsys/actions/gcloud-run-deploy` ![GitHub Release](https://img.shields.io/github/v/release/ghoztsys/actions?label=latest)

Deploys a container image to Google Cloud Run.

## Usage

```yml
permissions:
  contents: read
  id-token: write
steps:
  - uses: ghoztsys/actions/gcloud-run-deploy@v2
    with:
      image: us-docker.pkg.dev/my-project/my-image:latest
      labels: service=foo,environment=bar
      region: us-central1
      service-account: ${{ secrets.GCP_SERVICE_ACCOUNT }}
      workload-identity-provider: ${{ secrets.GCP_WORKLOAD_IDENTITY_PROVIDER }}
```

### Inputs

| Input | Required | Description |
| ----- | -------- | ----------- |
| `image` | `true` | Docker image to deploy |
| `labels` | `false` | Comma-delimited labels to match when searching for Cloud Run services to deploy to (i.e. "service=foo,environment=bar") |
| `region` | `false` | Specific region of the Cloud Run service(s) to deploy to |
| `service-account` | `true` | GCP service account to impersonate by the current Workload Identity |
| `workload-identity-provider` | `true` | Workload Identity Provider name, i.e. `projects/123456789/locations/global/workloadIdentityPools/my-pool/providers/my-provider` |

### Outputs

| Output | Description |
| ------ | ----------- |
| `console-url` | URL of the last deployed Cloud Run service on Google Cloud console |
| `deployment-url` | URL of the last deployed Cloud Run service |

## Permissions

Required permissions:

```yml
permissions:
  contents: read
  id-token: write
```
