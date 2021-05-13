#!/bin/bash

set -e

function log() {
  message="$*"
  echo -e "$(date '+%Y/%m/%d %H:%M/:%S'): ${message}"
}

function _usage() {
cat <<- EOS
  Set the following in the environment variables.
  Recommended is direnv.

  export GITHUB_TOKEN=xxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  export REVIEWER_MEMBERS=jonh:michael:apple:sushi
  export GITHUB_REPOSITORY=<name>/<repo name>

  [Terminal] $ ./github_auto_assing_reviwer.sh

  After executing the command, the dialogue starts.

  > > PullRequest Number: <pull_request_number>

  done.
EOS
}

readonly GITHUB_API=api.github.com

function environments_check() {
  if [[ -z ${REVIEWER_MEMBERS} && -z ${GITHUB_REPOSITORY} ]];
  then
    _usage
    exit 1
  fi
}

function members_to_array_str() {
  members_original=( `echo $REVIEWER_MEMBERS | tr -s ':' ' '`)

  tmp='['

  for member in "${members_original[@]}" ; do
    tmp+="\"${member}\","
  done

  members+=${tmp/%?/}']'
}

function final_check_log() {
  log "endpoint:\n"
  log "> https://${GITHUB_API}/repos/${GITHUB_REPOSITORY}/pulls/${PR_NUMBER}/requested_reviewers \n"

  log "Reviewers:\n"
  log "> ${members}\n"
}

function send_api() {
  curl -X POST -u :${GITHUB_TOKEN} \
    "https://${GITHUB_API}/repos/${REPOSITORY}/pulls/${PR_NUMBER}/requested_reviewers" \
    -d "{\"reviewers\":${members}}"
}

# check enviroments
environments_check
# Modified REVIEWER_MEMBERS so that it can be sent by API
members_to_array_str
# Acceptance and confirmation of PR number
read -p "> > PullRequest Number: " pr_number
case $pr_number in
  [0-9]* )
          log "Pull Request Number is ${PR_NUMBER}"
          readonly PR_NUMBER=${pr_number}
          ;;
  *      )
          exit 1
          ;;
esac

# final log
final_check_log

# Send after confirming Yes / No
read -p "send ready? (y/N): " yn
case "$yn" in
  [yY]*  ) send_api
           log "bye :)"
           ;;
  *      ) echo "abort ;("
           exit 1
           ;;
esac
