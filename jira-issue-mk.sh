#!/bin/bash

orig=$(readlink -f ${BASH_SOURCE[0]})
jira_dir=$(dirname $orig)

jira_usr=${JIRA_USER}
jira_pass=${JIRA_PASSWORD}
jira_proj=${JIRA_PROJECT}
jira_server=${JIRA_SERVER}

jira_chk=jira-check.sh

if [[ -s ${jira_chk} ]]
then
  echo "ERROR: This shouldn't happend, ${jira_chk} not found"
else
  ${jira_dir}/${jira_chk}
  if [[ ${PIPESTATUS[0]} != 0 ]]
  then
    exit
  fi
fi

action="createIssue"

usage() {

  echo ""
  echo "  MESSAGE: this is --action ${action}"
  echo ""
  echo "  USAGE: <COMMAND> [OPTIONS]"
  echo ""
  echo "  COMMANDS:"
  echo ""
  echo "    t|task      create new task (issue)"
  echo "    t|sub-task  create additional sub-task (sub-issue), requires --parent flag"
  echo ""
  echo "  OPTIONS:"
  echo ""
  echo "    --summary       summary string which appears in the title of the issues"
  echo "    --description   description of the project"
  echo "    --parent        specify parent issue id e.g bip-547, this will create sub-task of that parent"
  echo ""
  exit

}

run_jira() {

  if [[ -z ${issue_type} ]]
  then
    echo "ERROR: This shouldn't happened, issue_type is ${issue_type}"
    exit
  fi

  java -jar ${jira_dir}/lib/jira-cli-4.5.0.jar --server ${jira_server}\
                                               --user ${jira_usr}\
					       --password ${jira_pass}\
                                               --project ${jira_proj}\
                                               --assignee ${jira_usr}\
                                               --priority=Routine\
                                               --type=${issue_type}\
                                               --action ${action}\
                                               "${@}"
}

issue_type=""

case "${1}" in
  (task|t)
    issue_type="Task"
    ;;
  (subtask|s)
    issue_type="Sub-task"
    ;;
  (*)
    usage
esac

shift
run_jira "${@}"
