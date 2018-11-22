# Hadolint Action

A GitHub action that runs [hadolint](https://github.com/hadolint/hadolint) against a pull request.

## Usage

```
workflow "hadolint action" {
  on = "pull_request"
  resolves = ["hadolint on pr"]
}

action "hadolint on pr" {
  uses = "burdzwastaken/hadolint-action@master"
  secrets = ["GITHUB_TOKEN"]
  env = {
    HADOLINT_ACTION_DOCKERFILE_FOLDER = "."
  }
}
```

## Environment Variables

Name | Default | Description
--- | --- | ---
`HADOLINT_ACTION_DOCKERFILE_FOLDER` | `.` | Which directory the `Dockerfile` to run hadolint on resides in. Relative to the root of the repository.
`HADOLINT_ACTION_COMMENT` | `true` | Set to `false` to disable commenting back on pull request with the failed rules of the `Dockerfile`.

![demo](images/404-no-beta-access)

## TODO
* Let users supply their own configuration file
* Multiple `Dockerfile` support
