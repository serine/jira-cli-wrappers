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

java -jar ${jira_dir}/lib/jira-cli-4.5.0.jar --server ${jira_server}\
                                             --user ${jira_usr}\
                                             --password ${jira_pass}\
                                             --project ${jira_proj}\
                                             --action ${action}\
                                             --columns "Issue,To Issue,Link Direction"\
                                             "$@" | tr -d '"'
