#!/bin/bash
set -e
set -o pipefail

run_test()
{
  command=$1
  sev_threshold=$2
  create_report=$3
  additional_arguments=$4
  if [[ "$AC_SNYK_CREATE_REPORT" == "yes" ]]; then
    cd $AC_REPOSITORY_DIR
    snyk $AC_SYK_CLI_COMMAND --severity-threshold=$sev_threshold $additional_arguments --json | snyk-to-html -o $AC_REPOSITORY_DIR/snyk_report.html
    echo "AC_SNYK_REPORT=$AC_OUTPUT_DIR/snyk_report.html" >> $AC_ENV_FILE_PATH
  else
    snyk $AC_SYK_CLI_COMMAND --severity-threshold=$sev_threshold $additional_arguments
  fi
}

command_to_use=$AC_SYK_CLI_COMMAND
packages="snyk"
org_arg=""

if [[ "${AC_SNYK_CREATE_REPORT}" == "yes" ]]; then
  packages="snyk snyk-to-html"
fi

npm install -g ${packages}
snyk auth ${AC_SNYK_AUTH_TOKEN}

[[ ! -z "$AC_SNYK_ORGANIZATION" ]] && org_arg="--org=${AC_SNYK_ORGANIZATION}"
[[ ! -z "$AC_SNYK_ADD_ARG" ]] && additional_arguments="${AC_SNYK_ADD_ARG}"

if [[ "${AC_SNYK_FAIL_ON_ISSUES}" == "yes" ]]; then
    run_test "${command_to_use}" ${AC_SNYK_SEVERITY_THRESHOLD} ${AC_SNYK_CREATE_REPORT} ${additional_arguments}
else
    run_test "${command_to_use}" ${AC_SNYK_SEVERITY_THRESHOLD} ${AC_SNYK_CREATE_REPORT} ${additional_arguments} || true
fi

if [[ "${AC_SNYK_MONITOR}" == "yes" ]]; then
    cd $AC_REPOSITORY_DIR
    MONITOR_EXPLORE=`snyk monitor ${org_arg} ${additional_arguments}`
    echo "${MONITOR_EXPLORE}"|grep -Eo 'https://[^ >]+'|head -1" >> $AC_ENV_FILE_PATH
fi