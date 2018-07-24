#!/bin/bash

jira_exec="jira"
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
  echo "    s|sub-task  create additional sub-task (sub-issue), requires --parent flag"
  echo ""
  echo "  OPTIONS:"
  echo ""
  echo "    --summary       summary string which appears in the title of the issues"
  echo "    --description   description of the project"
  echo "    --file          alternatively pass description through a text file"
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

  ${jira_exec} --assignee ${jira_usr}\
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
