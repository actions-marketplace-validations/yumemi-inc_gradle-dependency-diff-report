[![CI](https://github.com/yumemi-inc/gradle-dependency-diff-report/actions/workflows/ci.yml/badge.svg)](https://github.com/yumemi-inc/gradle-dependency-diff-report/actions/workflows/ci.yml)

# [BETA] Gradle Dependency Diff Report

A GitHub Action that reports Gradle dependency differences.
The report is displayed in the pull request job summary, like [this](https://github.com/yumemi-inc/gradle-dependency-diff-report/actions/runs/6195029024).

At a minimum, you can simply implement a workflow as follows:

```yaml
name: Dependency Diff Report

on: pull_request

permissions: {}

jobs:
  report:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      pull-requests: read
    steps:
      - uses: yumemi-inc/gradle-dependency-diff-report@main
        with:
          modules: 'app'
          configuration: 'releaseRuntimeClasspath'
```

Reports are created with Gradle `dependencies` task, [dependency-diff-tldr](https://github.com/careem/dependency-diff-tldr), and [Dependency Tree Diff](https://github.com/JakeWharton/dependency-tree-diff).

## Usage

See [action.yml](action.yml) for available action inputs and outputs.
Also, this action requires `contents: read` and `pull-requests: read` permissions.

### Specify multiple modules

Basically, if you specify only the root module of the application, the modules that root depends on will also be reported, but if there are multiple root modules or if you need to report on individual modules, specify them separated by spaces.

```yaml
- uses: yumemi-inc/gradle-dependency-diff-report@main
  with:
    modules: 'app feature:main feature:login domain'
    configuration: 'releaseRuntimeClasspath'
```

At this time, if you want to apply a different configuration, specify it separated by `|`.

```yaml
- uses: yumemi-inc/gradle-dependency-diff-report@main
  with:
    modules: 'app|productReleaseRuntimeClasspath feature:main feature:login domain|debugRuntimeClasspath'
    configuration: 'releaseRuntimeClasspath'
```

### Specify java version

If not specified, the default version of the runner will be applied.
For `ubuntu-22.04` it is `11`.
If you want to use a different version, specify it using [actions/setup-java](https://github.com/actions/setup-java).

```yaml
- uses: actions/setup-java@v3
  with:
    distribution: 'zulu'
    java-version: 17
- uses: yumemi-inc/gradle-dependency-diff-report@main
  with:
    modules: 'app'
    configuration: 'releaseRuntimeClasspath'
```
