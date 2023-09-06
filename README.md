[![CI](https://github.com/yumemi-inc/gradle-dependency-diff-report/actions/workflows/ci.yml/badge.svg)](https://github.com/yumemi-inc/gradle-dependency-diff-report/actions/workflows/ci.yml)

# [BETA] Gradle Dependency Diff Report

A GitHub Action that reports Gradle dependency differences.
The report is displayed in the pull request job summary, like [this](https://github.com/yumemi-inc/gradle-dependency-diff-report/actions/runs/5995110818).

Reports are created with Gradle's `dependencies` task and the following tools:
- [dependency-diff-tldr](https://github.com/careem/dependency-diff-tldr)
- [Dependency Tree Diff](https://github.com/JakeWharton/dependency-tree-diff)

## Usage

### Minimum usage

Specify the target module and configuration of Gradle's `dependencies` task.

```yaml
name: Dependency Diff Report

on: pull_request

permissions:
  contents: read
  pull-requests: read

jobs:
  report:
    runs-on: ubuntu-latest
    steps:
      - uses: yumemi-inc/gradle-dependency-diff-report@main
        with:
          modules: 'app'
          configuration: 'releaseRuntimeClasspath'
```
