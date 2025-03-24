# gcloud-artifacts-build-push

Builds and pushes a container image to Google Artifact Registry.

## Usage

```yml
steps:
  - uses: ghoztsys/actions/gcloud-artifacts-build-push@v2
    with:
      build-args: APP=api
      build-artifact-dir: build/
      build-artifact-name: api-build
      dockerfile-path: apps/Dockerfile
      image-name: api
      namespace: ${{ vars.CONTAINER_REPOSITORY }}
      push: true
      registry: ${{ vars.GCP_CORE_CONTAINER_REGISTRY }}
      service-account: ${{ github.event_name == 'release' && vars.GCP_CORE_SERVICE_ACCOUNT_PROD || vars.GCP_CORE_SERVICE_ACCOUNT_DEV }}
      workload-identity-provider: ${{ github.event_name == 'release' && vars.GCP_CORE_WORKLOAD_IDENTITY_PROVIDER_PROD || vars.GCP_CORE_WORKLOAD_IDENTITY_PROVIDER_DEV }}
```

### Inputs

| Input | Required | Default | Description |
| ----- | -------- | ------- | ----------- |
| `build-args` | `false` | | List of build-time arguments |
| `build-artifact-dir` | `false` | | Path to the built files directory in the container for artifact upload (newline-delimited string for each path, relative to the container's working directory) |
| `build-artifact-name` | `false` | `build-artifact` | Name of the artifact containing the built files to be uploaded |
| `build-artifact-working-dir` | `false` | `/var/app` | Absolute path to the container’s working directory to set the upload location for built files (newline-delimited string, no trailing slash) |
| `build-secrets` | `false` | | List of build-time secrets (newline-delimited string) |
| `dockerfile-path` | `false` | `Dockerfile` | Path to the Dockerfile (relative to context) |
| `image-artifact-dir` | `false` | | Path to the directory containing the built image for artifact upload (absolute or relative to working directory) |
| `image-artifact-name` | `false` | `image-artifact` | Name of the artifact containing the built image to be uploaded |
| `image-name` | `false` | `${{ github.repository }}` | Docker image base name (excluding GCP project ID and registry) |
| `image-tag-suffix` | `false` | | Docker image tag suffix |
| `namespace` | `false` | | Repository namespace, i.e. GAR repository name |
| `push` | `false` | `false` | Specifies if the built image should be pushed to the registry |
| `registry` | `false` | `us-docker.pkg.dev` | Registry path |
| `service-account` | `false` | | GCP service account to impersonate by the Workload Identity |
| `workload-identity-provider` | `false` | | Workload Identity Provider name, i.e. `projects/123456789/locations/global/workloadIdentityPools/my-pool/providers/my-provider` |

### Outputs

| Output | Description |
| ------ | ----------- |
| `build-artifact-dir` | Path to the directory of the uploaded artifact of built files (relative to working directory) |
| `build-artifact-name` | Name of the uploaded artifact of built files |
| `image` | The full name of built Docker image, including the registry host, repository namespace, image name and tag (highest priority tag is used) |
| `image-artifact-dir` | Path to the directory of the uploaded artifact of the built image (absolute or relative to working directory) |
| `image-artifact-file` | Path to the uploaded artifact of the built image (absolute or relative to working directory) |
| `image-artifact-name` | Name of the uploaded artifact of the built image |
| `repository` | Full path to the repository in the registry including the registry host |
| `version` | The highest priority tag of the built Docker image |

## Permissions

Required permissions if using the automatically created `GITHUB_TOKEN` to authenticate to GitHub Container Registry:

```yml
permissions:
  contents: read
  packages: write
```
