# gcloud-container-deploy

Deploys a container image to Google Kubernetes Engine.

## Usage

```yml
permissions:
  contents: read
  id-token: write
steps:
  - uses: ghoztsys/actions/gcloud-container-deploy@v1
    with:
      cluster-labels: service=foo,environment=bar
      cluster-region-zone: us-central1-a
      k8s-container: my-container
      k8s-deployment: my-deployment
      k8s-namespace: default
      image: us-docker.pkg.dev/my-project/my-image:latest
      service-account: ${{ secrets.GCP_SERVICE_ACCOUNT }}
      workload-identity-provider: ${{ secrets.GCP_WORKLOAD_IDENTITY_PROVIDER }}
```

### Inputs

| Input | Required | Default | Description |
| ----- | -------- | ------- | ----------- |
| `cluster-labels` | `false` | | Comma-delimited labels to match when searching for clusters to deploy to (i.e. "service=foo,environment=bar") |
| `cluster-region-zone` | `false` | | Specific region zone of the GKE cluster(s) to deploy to |
| `k8s-container` | `true` | | Target Kubernetes container to update |
| `k8s-deployment` | `true` | | Target Kubernetes deployment to update |
| `k8s-namespace` | `false` | `default` | Target Kubernetes namespace where the deployment is located |
| `image` | `true` | | Docker image to deploy |
| `service-account` | `true` | | Google Cloud service account to impersonate by the current Workload Identity |
| `workload-identity-provider` | `true` | | Workload Identity Provider name, i.e. `projects/123456789/locations/global/workloadIdentityPools/my-pool/providers/my-provider` |

### Outputs

| Output | Description |
| ------ | ----------- |
| `console-url` | URL of the last deployed Kubernetes cluster on Google Cloud console |
| `deployment-url` | URL of the last deployed Kubernetes cluster |

## Permissions

Required permissions:

```yml
permissions:
  contents: read
  id-token: write
```
