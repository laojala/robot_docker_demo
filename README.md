# Robot Framework CI Demo

This project demonstrates how to setup Continous Integration for Robot Framework tests using [GitHub Actions](https://docs.github.com/en/actions).

## Use Cases

Demo covers these use cases:

* Run Robot Framework tests:
    * when new commits are pushed to the main branch
    * when new commits are pushed to a Pull request
    * run tests with a pre-defined schedule
    * Trigger tests manually. Input variables for a test run.
* Reporting:
    * Store Robot Framework reports from test runs
    * Post summary of results as a comment to a commit. The comment is posted only to the main (master) branch.

In other words, a separate CI server (such as Jenkins) is not needed to run Robot Framework tests. 

### Why use Actions for CI?

Using GitHub Actions for setup CI is almost better than sourdough bread 🍞🎉 Setup is straightforward and usage is free for public repositories (see [pricing](https://github.com/pricing) for other types of repositories).

Setup described here is very simple for demo purposes. It is possible to add more bells and whistles if needed.

## Description of the setup

CI Workflows are configured in YAML files in a folder `.github/workflows`. When Job is run, it is visible in the [Actions tab](https://github.com/laojala/robot_docker_demo/actions) in the repository. 

This repository has two workflows for demo purposes:
* [run_robot_framework_tests.yml](.github/workflows/run_robot_framework_tests.yml)
    * runs test for push events, pull requests and scheduled
    * steps in this file are documented in detail
* [trigger_robot_framework_tests_manually.yml](.github/workflows/trigger_robot_framework_tests_manually.yml)
    * triggers tests manually with the given parameters

Docker container used in this demo is [ppodgorsek/robot-framework](https://hub.docker.com/r/ppodgorsek/robot-framework). The container has many pre-installed libraries and tools (it is even possible to run Selenium Browser tests).

Workflow fails if Robot Framework tests fail. Robot Framework results reports are stored in a zip file.

The next chapter describes how to modify example workflows for your project.

### To configure example setup to your own project

1. Configure `docker run` command according to your project:
    * Place your tests to the `test` folder
    * Modify line `-e ROBOT_OPTIONS="--variable DINOSAUR:Achillobator --variable NOT_DINOSAUR:kissa" \` according to your project or remove it completely

```
docker run \
    -v ${PWD}/reports:/opt/robotframework/reports:Z \
    -v ${PWD}/tests:/opt/robotframework/tests:Z \
    -e ROBOT_OPTIONS="--variable DINOSAUR:Achillobator --variable NOT_DINOSAUR:kissa" \
    --user $(id -u):$(id -g) \
    ppodgorsek/robot-framework:latest
```

2. All other configurations, such as changing the cron schedule are optional. 

Things to consider:

   * If workflow needs secrets, those can be stored in repository settings. Secret is used in the flow like this `${{ secrets.MY_SECRET_NAME }}`
   * Docker image `ppodgorsek/robot-framework:latest` is not versioned. `latest` tag can contain any version of the Robot Framework and other libraries. *It is strongly advised to use some other version controlled image for running tests.*

## Acknowledgments

* List of dinosaur names used in tests (it would be actually possible to configure updating list of dinosaur names using Actions 🦕🦖): [https://www.npmjs.com/package/dinosaurs](https://www.npmjs.com/package/dinosaurs)
* Docker container used to run Robot Framework tests: [ppodgorsek/robot-framework Docker container](https://hub.docker.com/r/ppodgorsek/robot-framework)
