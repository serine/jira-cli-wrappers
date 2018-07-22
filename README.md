# jira-cli-wrappers

> At work we are using [jira](https://www.atlassian.com/software/jira) for project management.
> It appears to have all the features that one would want for projects management, particular for software engineering type work (from what I understand at least). However I personally find both graphical (web) interface and cli rather clunky to use. I won't go into a full spill about here, but the fact that there are a few wrappers and re-writes of jira-cli exists out there confirms the point.
> Here I'm not doing anything special simply wrote a few BASH scripts that simplify a few essential commands that I'm using on a day to day basis.

## Install and usage

- essential environmental variables to be set

Hopefully all self explanatory. Note `JIRA_PASSWORD` is a sensible variable.
I would say only use this from your machine that no one else has access to
since your `JIRA_PASSWORD` string going to be in clear if you `ps aux | grep jira` 

```
jira_exec="java -jar ${JIRA_EXEC}"
jira_usr=${JIRA_USER}
jira_pass=${JIRA_PASSWORD}
jira_proj=${JIRA_PROJECT}
jira_server=${JIRA_SERVER}
```

I have a file that I source in before using jira

```
[biostation2]~$ cat ~/Documents/jira.txt 
export JIRA_EXEC=/opt/atlassian-cli-4.5.0/lib/jira-cli-4.5.0.jar
export JIRA_USER=serine
export JIRA_PROJECT=foo
export JIRA_SERVER="https://jira.blah.blah.edu"
```

I have a separate file that exports `JIRA_PASSWORD` since as I said this is rather sensible information

- will need `sudo` for this

```
cd /usr/local/bin
for i in /opt/jira-cli-wrappers/*.sh;do ln -s $i $(basename $i .sh);done
```

more coming shortly..

