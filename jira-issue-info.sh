#!/bin/bash

jira_exec="jira"
action="getIssue"

if [[ -z "$@" ]]
then
  echo ""
  echo "  MESSAGE: this is --action ${action}"
  echo ""
  echo "  OPTIONS:"
  echo ""
  echo "    --issue       provide issue number, e.g bip-547"
  echo ""
  exit
fi

${jira_exec} --action ${action}\
             "$@"
