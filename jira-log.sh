#!/bin/bash

jira_exec="jira"
action="addWork"

if [[ -z "$@" ]]
then
  echo ""
  echo "  MESSAGE: this is --action ${action}"
  echo ""
  echo "  OPTIONS:"
  echo ""
  echo "    --issue       provide issue number, e.g bip-547"
  echo "    --timeSpent   specify the time e.g 3h 30m"
  echo "    --comment     comment string to add"
  echo ""
  exit
fi

${jira_exec} --action ${action}\
             "$@"
