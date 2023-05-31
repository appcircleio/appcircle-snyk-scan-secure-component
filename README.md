# Appcircle _Snyk Scan Security_ component

By utilizing this step, you will be able to test your project dependencies for vulnerabilities during builds and use Snyk to monitor your projects.

## Required Inputs

- `AC_REPOSITORY_DIR`: Repository Directory. Specifies the cloned repository directory.
- `AC_SNYK_AUTH_TOKEN`: Snyk Authentication Token. Your Snyk authentication token (see https://app.snyk.io/account).
- `AC_SNYK_ORGANIZATION`: Organization. Name of the Snyk organisation name, under which this project should be tested and monitored.

If omitted the default organization will be used.


## Optional Inputs

- `AC_SYK_CLI_COMMAND`: Snyk CLI Command to Run. This is the CLI command to run with Snyk.Default value: `test`
- `AC_SNYK_SEVERITY_THRESHOLD`: Severity Threshold. Only report vulnerabilities of the provided level or higher.
- `AC_SNYK_FAIL_ON_ISSUES`: Fail on Issues. Specifies whether to fail the build or not based on the results found by Snyk.

Snyk by default returns an error code from the test command. This may break your Appcircle workflow. By specifying `no`, the build can continue even if vulnerabilities are found.

- `AC_SNYK_CREATE_REPORT`: Create HTML Report. Specifies whether to create an HTML report.

If set to `yes`, an HTML report will be created and available as a build artifact.

- `AC_SNYK_MONITOR`: Monitor (Import to Snyk). If enabled, imports the snapshot of dependencies to Snyk for continuous monitoring after a successful test.

Set this value to `yes` to import the snapshot of dependencies to Snyk after a successful test. Snyk will then start monitoring the dependencies for new vulnerabilities and alert when a new vulnerability is discovered.

- `AC_SNYK_ADD_ARG`: Snyk CLI Additional Arguments. Snyk CLI additional arguments for command line.

## Output Variables

- `AC_SNYK_REPORT`: Snyk Report HTML File. Snyk report of executed tests.
- `AC_SNYK_MONITOR_EXPLORE_LINK`: Snyk Monitor Explore Link. The link where the project result is monitored.
