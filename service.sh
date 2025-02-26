#!/bin/bash

set -e

fatal()
{
   echo "error: $1" >&2
   exit 1
}

flags_found=false

while getopts 's:g:n:r:u:l:df' opt; do
    flags_found=true

    case $opt in
    s)
        runner_scope=$OPTARG
        ;;
    *)
        echo "
Runner Service Installer
Examples:
RUNNER_CFG_PAT=<yourPAT> ./create-latest-svc.sh myuser/myrepo my.ghe.deployment.net
RUNNER_CFG_PAT=<yourPAT> ./create-latest-svc.sh -s myorg -u user_name -l label1,label2
Usage:
    export RUNNER_CFG_PAT=<yourPAT>
    ./create-latest-svc scope [ghe_domain] [name] [user] [labels]
    -s          required  scope: repo (:owner/:repo) or org (:organization)
    -g          optional  ghe_hostname: the fully qualified domain name of your GitHub Enterprise Server deployment
    -n          optional  name of the runner, defaults to hostname
    -r          optional  name of the runner group to add the runner to, defaults to the Default group
    -u          optional  user svc will run as, defaults to current
    -l          optional  list of labels (split by comma) applied on the runner
    -d          optional  allow runner to remain on the current version for one month after the release of a newer version
    -f          optional  replace any existing runner with the same name"
        exit 0
        ;;
    esac
done

#---------------------------------------
# Configuring as a service
#---------------------------------------
echo
echo "Configuring as a service ..."



first_word=$(echo "$runner_scope" | cut -d'/' -f1)
second_word=$(echo "$runner_scope" | cut -d'/' -f2)

nom_service="actions.runner.${first_word}-${second_word}.${svc_user}.service"

prefix="sudo"

# si le service existe peu importe le fichier on le refait pas
if [ -f "/etc/systemd/system/${nom_service}" ]; then
    echo "Service already exists. skipping service creation."
else
    echo "Creating service ..."
    cd ./runner 
    ./svc.sh install $svc_user 
    echo "Service created."
    echo "Starting service ..."
    ./svc.sh start $svc_user 
    echo "Service started."
fi

