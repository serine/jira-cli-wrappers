#!/bin/bash

jira_exec="jira"
jira_chk="jira-check"

jira_usr=${JIRA_USER}
jira_pass=${JIRA_PASSWORD}
jira_proj=${JIRA_PROJECT}
jira_server=${JIRA_SERVER}

if [[ -s ${jira_chk} ]]
then
  echo "ERROR: This shouldn't happend, ${jira_chk} not found"
else
  ${jira_chk}
  if [[ ${PIPESTATUS[0]} != 0 ]]
  then
    exit
  fi
fi

action="getIssueList"

usage() {

  echo ""
  echo "  MESSAGE: this is --action ${action}"
  echo ""
  echo "  USAGE: <COMMAND>"
  echo ""
  echo "  COMMANDS:"
  echo ""
  echo "    a|all        show all issues"
  echo "    s|short      show short issues"
  echo "    l|long       show long issues"
  echo "    j|jobs       show issues that are worked on"
  echo "    c|complete   show done issues"
  echo "    f|follow     show issues that need following up"
  echo "    t|todo       show issues that needs doing"
  echo "    w|wait       show issues in waiting"
  echo ""
  exit

}

run_jira() {

  ${jira_exec} --action ${action}\
               --jql "assignee=currentUser() ${issue_type}"\
               --dateFormat "dd-MM-yyyy"\
               --columns "Key,Summary,Created,Status" | tr -d '"'

}

issue_type=""

case "${1}" in
  (all|a)
    issue_type=""
    ;;
  (short|s)
    issue_type="AND status=Short"
    ;;
  (long|l)
    issue_type="AND status='Development In Progress'"
    ;;
  (jobs|j)
    issue_type="AND status in ('Development In Progress', 'Short')"
    ;;
  (complete|c)
    issue_type="AND status='Done'"
    ;;
  (todo|t)
    issue_type="AND status='To Do'"
    ;;
  (wait|w)
    issue_type="AND status=Waiting"
    ;;
  (follow|f)
    issue_type="AND status='Follow Up'"
    ;;
  (*)
    usage
esac

run_jira
