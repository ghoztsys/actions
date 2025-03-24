# sentry-release

Creates a Sentry release.

## Usage

```yml
steps:
  - uses: ghoztsys/actions/sentry-release@v2
    with:
      auth-token: ${{ secrets.SENTRY_AUTH_TOKEN }}
      environment: production
      org: your-org-slug
      project: your-project-slug
      sourcemaps-artifacts-name: sourcemaps-artifact
      sourcemaps-path: path/to/sourcemaps
      version: your-release-version
```

### Inputs

| Input | Required | Default | Description |
| ----- | -------- | ------- | ----------- |
| `auth-token` | `true` | | Sentry authentication token |
| `environment` | `false` | `development` | Environment for the release |
| `org` | `true` | | Sentry organization slug |
| `project` | `true` | | Sentry project slug |
| `sourcemaps-artifacts-name` | `false` | | Name of the sourcemap artifacts to download |
| `sourcemaps-path` | `true` | | Path (relative to working directory) to the sourcemaps |
| `version` | `true` | | Identifier that uniquely identifies the release |

### Outputs

This action does not produce any outputs.
