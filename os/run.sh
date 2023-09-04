#! /bin/sh
#
# run.sh
# Copyright (C) 2021 user <user@vivobook>
#
# Distributed under terms of the MIT license.
#

export INVENTORY="${INVENTORY:-inventory.yaml}"
export PLAYBOOK="k3s_servers.yaml"

git pull
ansible-galaxy role install --force -r requirements.yaml
ansible-galaxy collection install --force -r requirements.yaml
ansible-playbook -i "${INVENTORY}" "${PLAYBOOK}" -e target=k3s_servers -e gh_token="${GITHUB_TOKEN}" -e aws_access_key_id="${AWS_ACCESS_KEY_ID}" -e aws_secret_access_key="${AWS_SECRET_ACCESS_KEY}" -vvvv
