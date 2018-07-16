#!/bin/bash

printf "
####################################################################################
#                         Thanks for making the rocket go!                         #
#                Please don't run this in a production environment                 #
####################################################################################
"
printf "Please provide the following details when prompted:

    1) AWS Access Key (root account)
    2) AWS Secret Key (root account)
    3) User generated Ansible Vault encryption key

The AWS passwords will be stored using Ansible Vault, encrypted with the provided password.\n\n"

AWS_FILE=./group_vars/all/vault
if [ -z "$AWS_ACCESS" ]; then
    read -sp 'Please paste AWS Access Key: ' AWS_ACCESS
fi
echo "vault_aws_access_key: ${AWS_ACCESS}" > "${AWS_FILE}"

if [ -z "$AWS_SECRET" ]; then
    read -sp $'\nPlease paste AWS Secret Key: ' AWS_SECRET
fi
echo "vault_aws_secret_key: ${AWS_SECRET}" >> "${AWS_FILE}"

if [ -z "$VAULT_PASS" ]; then
    read -sp $'\nPlease enter a strong passphrase for Vault encryption: ' VAULT_PASS
fi

VAULT_FILE=vault_key
echo "${VAULT_PASS}" > "${VAULT_FILE}"

printf "\n\nThe main playbook will now be executed against the us-east-2 region, please enter your Ansible Vault key when prompted.

Provisioning time is ~8 minutes.\n\n"

ansible-vault encrypt $AWS_FILE --vault-password-file "${VAULT_FILE}" 1>/dev/null

rm -rf "${VAULT_FILE}"

ansible-playbook --ask-vault-pass ./site.yml

