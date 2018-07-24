#!/bin/bash

jira_exec="jira"
action="addComment"

if [[ -z "$@" ]]
then
  echo ""
  echo "  MESSAGE: this is --action ${action}"
  echo ""
  echo "  OPTIONS:"
  echo ""
  echo "    --issue       provide issue number, e.g bip-547"
  echo "    --comment     comment string to add"
  echo "    --file        alternatively pass comments through a text file"
  echo ""
  exit
fi

${jira_exec} --type Task\
             --priority=Routine\
             --assignee ${jira_usr}\
             --action ${action}\
             "$@"
