#!/bin/bash

#NOTE one could use hack similar to this one below
# instead of hard coding jira path if they prefer
# the ultimate goal here is simply to get jira_exec to point to jar file
# e.g jira_exec="java -jar /some/path/to/lib/jira-cli-4.5.0.jar"

#orig=$(readlink -f ${BASH_SOURCE[0]})
#jira_dir=$(dirname $orig)
#jira_exec="java -jar ${jira_dir}/lib/jira-cli-4.5.0.jar"

jira_exec="java -jar ${JIRA_EXEC}"
jira_chk="jira-check"

jira_usr=${JIRA_USER}
jira_pass=${JIRA_PASSWORD}
jira_proj=${JIRA_PROJECT}
jira_server=${JIRA_SERVER}

if [[ -s ${jira_chk} ]]
then
  echo "ERROR: This shouldn't happend, ${jira_chk} not found"
else
  #${jira_dir}/${jira_chk}
  ${jira_chk}
  if [[ ${PIPESTATUS[0]} != 0 ]]
  then
    exit
  fi
fi

# NOTE using enviromental variable is no good since this will show up in ps aux output
# This thread https://bobswift.atlassian.net/browse/CSOAP-334
# This got fixed in 5.2 onwards
# https://bobswift.atlassian.net/wiki/spaces/ACLI/pages/128221363/Release+Notes+5.2
# https://bobswift.atlassian.net/wiki/spaces/ACLI/pages/143851700/How+to+use+environment+variables+for+password+parameters
# However Monash is still on jira 4.5.0 so using it at my own risk

if [[ -z "$@" ]]
then
  echo ""
  echo "  MESSAGE: this is general jira interface"
  echo "           you will need to specify --action <ACTION>"
  echo ""
  echo "           For more help use --help"
  echo ""
  exit
fi

${jira_exec} --server ${jira_server}\
             --user ${jira_usr}\
             --password ${jira_pass}\
             --project ${jira_proj}\
             "$@"
