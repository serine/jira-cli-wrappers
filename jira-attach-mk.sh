#!/bin/bash

jira_exec="jira"
action="addAttachment"

if [[ -z "$@" ]]
then
  echo ""
  echo "  MESSAGE: this is --action ${action}"
  echo ""
  echo "  OPTIONS:"
  echo ""
  echo "    --issue       provide issue number, e.g bip-547"
  echo "    --file        provide file to attach"
  echo ""
  exit
fi

${jira_exec} --action ${action}\
             "$@"
