#!/bin/bash

jira_exec="jira"
action="getLinkList"

if [[ -z "$@" ]]
then
  echo ""
  echo "  MESSAGE: this is --action ${action}"
  echo ""
  echo "  OPTIONS:"
  echo ""
  echo "    --issue       provide issue number, e.g bip-547"
  echo ""
  echo "  NOTES:"
  echo ""
  echo "    - Link Direction inward means that To Issue is the parent issue"
  echo "    - Link Direction outward means that the Issue is the parent issue"
  echo ""
  exit
fi

${jira_exec} --action ${action}\
             --columns "Issue,To Issue,Link Direction"\
             "$@" | tr -d '"'
