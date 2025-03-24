# `ghoztsys/actions/gcloud-artifacts-build-push` ![GitHub Release](https://img.shields.io/github/v/release/ghoztsys/actions?label=latest)

Builds and pushes a container image to Google Artifact Registry.

## Usage

```yml
permissions:
  contents: read
  id-token: write
steps:
  - uses: ghoztsys/actions/gcloud-artifacts-build-push@v2
    with:
      build-args: |
        ARG1=value1
        ARG2=value2
      build-artifact-dir: path/to/build/artifacts
      build-artifact-name: custom-build-artifact
      build-artifact-working-dir: /custom/working/dir
      build-secrets: |
        SECRET1=value1
        SECRET2=value2
      dockerfile-path: path/to/Dockerfile
      image-artifact-dir: path/to/image/artifacts
      image-artifact-name: custom-image-artifact
      image-name: custom-image
      namespace: custom-namespace
      push: true
      service-account: ${{ secrets.GCP_SERVICE_ACCOUNT }}
      workload-identity-provider: ${{ secrets.GCP_WORKLOAD_IDENTITY_PROVIDER }}
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

Required permissions:

```yml
permissions:
  contents: read
  id-token: write
```
