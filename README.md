# Robot Docker Demo

Project demonstrates how to setup Continous Integration for Robot Frameowrk tests using [GitHub Actions](https://docs.github.com/en/actions).

## Use Cases

Demo covers these use cases:

* Run tests:
    * when new commits are pushed to the main branch
    * when new commits are pushed to a Pull request
    * run tests with pre-defined schedule
    * Trigger tests manually. Input variables for a test run.
* Reporting:
    * Store Robot Framework reports from test runs
    * Post summary of results as comment to a commit to a main (master) branch

In other words, separate CI server (such as Jenkins) is not needed to run Robot Framework tests. 

### Why to use Actions for CI?

Using GitHub Actions for setup CI is far  far better than sliced bread 🥯🎉 Setup is straightforward and usage is free for public repos (see [pricing](https://github.com/pricing) for other types of repositories).

Setup described here is very simple for demo purposes. In a real world scenario, it is possible to add more bells and whisthles.

## Description of the setup

CI Workflows are configured in YAML files in a folder `.github/workflows`. When Job is run, it is visible in the [Actions tab](https://github.com/laojala/robot_docker_demo/actions) in the repository. 

Workflow fails if Robot Framework tests fail. Robot Framwework results reports are stored in a zip file to the Workflow artifacts.

This repository has two workflows for demo purposes:
* [run_robot_framework_tests.yml](.github/workflows/run_robot_framework_tests.yml)
    * runs test for push events, pull requests and scheduled
* [trigger_robot_framework_tests_manually.yml](.github/workflows/trigger_robot_framework_tests_manually.yml)

Docker container used in this demo is [ppodgorsek/robot-framework](https://hub.docker.com/r/ppodgorsek/robot-framework). Container has has many pre-installed libraries and tools (it is even possible to run Selenium Browser tests).

Next chapter describes how to modify example workflows for your project.

### To configure example setup to your own project:

1. Modify `docker run` command according to your project:
    * `reports` folder needs to exist in a repository. As it is not possible to add empty folder in a git, place a single file called log.log to the `/reports` folder and commit it (this is bit hacky, but I could not get ppodgorsek container's priviledges to work without this dummy file)
    * Place your tests to the `test` folder, or modify docker run command accordingly
    * Replace line `-e ROBOT_OPTIONS="--variable DINOSAUR:Achillobator --variable NOT_DINOSAUR:kissa" \` according your project or remove it completely

```
docker run \
    -v ${PWD}/reports:/opt/robotframework/reports:Z \
    -v ${PWD}/tests:/opt/robotframework/tests:Z \
    -e ROBOT_OPTIONS="--variable DINOSAUR:Achillobator --variable NOT_DINOSAUR:kissa" \
    --user $(id -u):$(id -g) \
    ppodgorsek/robot-framework:latest
```

2. All other modifications, such as changing cron schedule are optional. Things to consider:
    * If workflow needs secrets, those can be stored in repository settings. Secret is referred in the flow like this `${{ secrets.MY_SECRET_NAME }}`

## Acknowledgments

* [https://github.com/joonvena/robotframework-reporter-action](https://github.com/joonvena/robotframework-reporter-action)
    * GitHub Action that posts summary of test result as commment for commit messages
    * [Blog post of usage](https://medium.com/faun/robot-framework-testing-using-github-actions-e0aa8df16fd8)
* [https://www.npmjs.com/package/dinosaurs](https://www.npmjs.com/package/dinosaurs)
    * List of dinosaur names used in tests (it would be actually possible to configure updating list of dinosaur names using Actions 🦕🦖)
* [ppodgorsek/robot-framework Docker container](https://hub.docker.com/r/ppodgorsek/robot-framework)
