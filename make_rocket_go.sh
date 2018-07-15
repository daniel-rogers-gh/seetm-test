#!/bin/bash

echo "
####################################################################################
# Thanks for making the rocket go!!                                                #
####################################################################################
"
echo "In order to make rocket go please provide the following details when prompted:

    1) AWS Access Key (root account)
    2) AWS Secret Key (root account)
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
echo "The following actions will occur:

    1) Git clone of daniel-rogers-gh/seetm-test.git
    2) Playbook site.yml will be executed
      2a) Please enter your Ansible Vault key when prompted

Hopefully it will work, approximate running time is x min

For your convenience the URL of the load balancer will be displayed upon completion

Please don't run this in a production environment

echo $aws_access
echo $aws_secret
echo $vault_key
echo
# ansible-playbook --ask-vault-pass ./test_playbooks/test-aws_creds_b.yml          #
