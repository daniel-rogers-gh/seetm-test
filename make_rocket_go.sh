#!/bin/bash

echo "
####################################################################################
# Thanks for making the rocket go!!                                                #
####################################################################################
"
echo "In order to make rocket go please provide the following details when prompted:

    1) AWS Access Key
    2) AWS Secret Key
    3) User generated Ansible Vault encryption key

The AWS passwords will be stored using Ansible Vault, encrypted with the provided password.
"
echo
read -sp 'Please paste AWS Access Key: ' aws_access
echo
read -sp 'Please paste AWS Secret Key: ' aws_secret
echo
read -sp 'Please enter a strong passphrase for Vault encryption: ' vault_key
echo
echo
echo $aws_access
echo $aws_secret
echo $vault_key
echo
# ansible-playbook --ask-vault-pass ./test_playbooks/test-aws_creds_b.yml          #
