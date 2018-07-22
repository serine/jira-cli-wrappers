#!/bin/bash

jira_chk=(JIRA_USER JIRA_PASSWORD JIRA_PROJECT JIRA_SERVER)

for j in ${jira_chk[@]}
do
  if [[ -z "${!j}" ]]
  then
   
    echo "ERROR: You haven't set ${j}"
    exit 1
  fi
done
