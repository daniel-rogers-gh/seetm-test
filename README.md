## What does seetm-test do?

[This project](https://github.com/daniel-rogers-gh/seetm-test) will create a pair of load balanced webservers with supporting AWS infrastructure.

#### AWS components (high level)

- VPC + associated requirements
- Key Pair
- Security / Target Groups
- Launch Configuration
- Auto Scaling Group + instances
- Application Load Balancer

#### Region & AMI

- The region has been set to **us-east-2**
- Instances run Amazon Linux 2 (ami-8c122be9)

## General pre-requisites

- AWS account (trial account recommended)
- AWS root account access and secret keys (generate via IAM)

## Package pre-requisites (in no particular order)

**Package        : version used in development**
- python2.7      : 2.7.12
  - https://www.makeuseof.com/tag/install-pip-for-python/
- python3        : 3.5.2
  - https://realpython.com/installing-python/
- python-pip     : 10.0.1
  - https://www.makeuseof.com/tag/install-pip-for-python/
- python3-pip    : 8.1.1
  - https://www.makeuseof.com/tag/install-pip-for-python/
- boto           : 2.49.0
  - https://github.com/boto/boto
- boto3          : 1.7.56
  - https://github.com/boto/boto3
- ansible        : 2.6.1
  - https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
- git            : 2.7.4
  - https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

## Usage

### Disclaimer

Do not run this in a production environment! I am not responsible for any damage or costs incurred by running this code. Charges may be made to an AWS account (even a trial) if the limits have been exceeded.

#### Installation

Once all pre-requisites have been fulfilled and the warning above has been read, perform the following:

```
git clone https://github.com/daniel-rogers-gh/seetm-test.git
cd ./seetm-test
./make_rocket_go.sh
```

or for the one liner concatenate the commands like so:

`git clone https://github.com/daniel-rogers-gh/seetm-test.git && cd ./seetm-test && ./make_rocket_go.sh`

The script will ask for:

- AWS access key for root account
- AWS secret key for root account
- A passphrase to encrypt the AWS credentials with Ansible Vault

Once these values have been supplied the credentials will be encrypted and the main playbook `site.yml` will execute.

The key pair for the instances will be downloaded to `seetm-test/aws-private.pem`

Approximate provisioning time is 8 minutes. 

**Please note this script is not currently idempotent. If an error is encountered (missing package etc) please delete any provisioned resources before re-running the script**

#### Workstation configuration

To date this has only been executed on Ubuntu Linux. It should work on OSX but I am unable to verify this.

## Future improvements

- Dynamically pick correct ami id for any region
  - Add `Desired OS` and `instance size` to launcher, query for appropriate ami id, update vars
- Dynamic provisioning of VPC and network resources to better leverage Availability Zones
  - Find reliable return count for Availability Zone query (based on region)
  - Update launcher to specify min max AZ available, make it user configurable?
- Improve inventory of instances generated by Auto Scaling Group
- Give thought to smoother host configuration/index.html alteration
  - Slightly limited by no `amazon-linux-extras` ansible module
  - Further research needed
- Role mapping to remove requirement for root keys

## Known issues / current limitations

- Limited to region **us-east-2**
  - The ami id is different in each region for Amazon Linux 2 t2.micro instance and I have not implemented a dynamic picker yet
  - Note AWS region is set with variables so it is ready to go once the ami id detection is working
- Idempotency issues - rerunning playbook gives errors
  - I believe this is related to ansible caching facts, `--flush-cache` option does not seem to resolve it. Further research required
- Dynamic inventory for ASG instances (webservers) is not persistent
  - It is currently generated in a previous role which allows them to be targeted
  - Marked as a high priority improvement
- Limited testing across varied environments - issues will undoubtedly be present somewhere
- The first webserver play may give an error "Failed to connect to the host via ssh"
  - It **should** still complete successfully
  - I thought this was a race condition issue but even after a wait step it had the same result
  - [This thread](https://github.com/ansible/ansible/issues/15321) indicates it is most likely an issue with my variable setup

## Outstanding tasks for submission

- [x] Gather ansible log output and approximate running time
- [x] Finish launcher `make_rocket_go.sh`
- [x] Test launcher in newly registered AWS trial account
- [x] Output load balancer public DNS upon script completion
- [x] Spell check README.md
- [x] Complete 1st draft README.md
- [x] Merge aws-prereqs and aws-core roles into single playbook

## References

A subset of the many reference pieces that were used for this project:

Ansible documentation / best practices
- https://docs.ansible.com/ansible/latest/modules/list_of_all_modules.html
- https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html

Ansible + VPC blog
- https://jeremievallee.com/2016/07/27/aws-vpc-ansible.html

Ansible Vault
- https://docs.ansible.com/ansible/2.5/user_guide/vault.html
- https://gadelkareem.com/2018/04/10/ansible-vault-encrypt-decrypt-shell-script/

Git README markdown
- https://help.github.com/articles/basic-writing-and-formatting-syntax
- https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet

SSH Key Files
- https://stackoverflow.com/questions/42123317/how-to-use-a-public-keypair-pem-file-for-ansible-playbooks

AWS Regions & Availability Zones
- https://gist.github.com/neilstuartcraig/0ccefcf0887f29b7f240

Sample Ansible repository layout
- https://github.com/enginyoyen/ansible-best-practises

AWS documentation
- https://aws.amazon.com/documentation/

