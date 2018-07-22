#!/bin/bash

orig=$(readlink -f ${BASH_SOURCE[0]})
jira_dir=$(dirname $orig)

jira_usr=${JIRA_USER}
jira_pass=${JIRA_PASSWORD}
jira_proj=${JIRA_PROJECT}
jira_server=${JIRA_SERVER}

action="transitionIssue"

usage() {

  echo ""
  echo "  MESSAGE: this is --action ${action}"
  echo ""
  echo "  USAGE: <COMMAND> [OPTIONS]"
  echo ""
  echo "  COMMANDS:"
  echo ""
  echo "    c|complete  progress task to a state done"
  echo "    s|short     progress task to a short state"
  echo "    l|long      progress task to a long state"
  echo "    f|follow    progress task to a follow up state"
  echo "    t|todo      progress task to a to do state"
  echo "    w|wait      progress task to a waiting state"
  echo ""
  echo "  OPTIONS:"
  echo ""
  echo "    --issue       provide issue number, e.g bip-547"
  echo ""
  exit

}

run_jira() {

  if [[ -z ${issue_state} ]]
  then
    echo "ERROR: This shouldn't happened, issue_state is ${issue_state}"
    exit
  fi

  java -jar ${jira_dir}/lib/jira-cli-4.5.0.jar --server ${jira_server}\
                                               --user ${jira_usr}\
                                               --password ${jira_pass}\
                                               --project ${jira_proj}\
                                               --action ${action}\
                                               --transition ${issue_state}\
                                              "${@}"
}

issue_state=""

case "${1}" in
  (complete|c)
    issue_state="Done"
    ;;
  (short|s)
    issue_state="Short"
    ;;
  (long|l)
    issue_state="In Progress"
    ;;
  (follow|f)
    issue_state="Follow Up"
    ;;
  (todo|t)
    issue_state="To Do"
    ;;
  (wait|w)
    issue_state="Waiting"
    ;;
  (*)
    usage
esac

shift
run_jira "${@}"
