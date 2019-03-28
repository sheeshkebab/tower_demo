# Instructions for Provisioning EC2 Instances


NOTE : before you run any AWS ansible modules you need to install the underlying pyhton support for the AWS sdk.

please read here and install the boto pythn libraries.....


## Step 1
In the aws.yml playbook,  edit the vars section so that it includes
   - your RHN portal account id
   - the EC2 subnet id where your vm's will be placed. The one provided will be enough to allow you to ssh into instances.
   - Security Group. The one proviuded should be adequate for SSH access into the instance.
   - ssh key
   - EC2 region
   etc.

## Step 2
Edit the vault file and enter your AWS account credentials, same as those which you exported for the `ec2.py` script. Also enter your rhn portal account and password.
 
### Note
  The default password for opening the vault file is `password`, run the command below to edit the vault file.

  `ansible-vault edit group_vars/all/vault.yml`

## Step 3
Edit the `ssh-cfg` file and point it to the location of your AWS secret key so that any ansible playbooks can coonect using it. The ssh-cfg assumes you want to connect to your instances as the `ec2-user`. This is the default user ID for RHEL instances on AWS. If you dont have an ssh key you will need to go and create one via the console. Dont forget to save the contens of your private key locally......typicall stored within your home directory. IE : `/Users/yourname/.ssh/private.key`

## Step 4
Run the aws playbook using the create tag

`ansible-playbook ../demo/aws.yml --tags "create" --ask-vault-pass`

## Step 5
Run the aws playbook using the delete tag to clean up

`ansible-playbook ../demo/aws.yml --tags "delete" --ask-vault-pass`

IF YOU DONT SUPPLY A TAG THE PLAYBOOK WILL CREATE AND THEN DELETE ANYTHING INSTANCE WITH THE TAG ASSOCIATED.


## Testing

Run a test ping to your instances. This assumaes that you already have tagged instances in AWS.

`ansible tag_Webservers_rjh -i ./ec2.py -m ping --ask-vault-pass`


# Generating Dynamic Inventory for Anisble playbooks

The ec2.py script lets you list ansible inventory dynamically, It does this by querying the EC2 api and formatting the output as JSON.
Read more about the topic of dynamic inventory [here](http://docs.ansible.com/ansible/latest/user_guide/intro_dynamic_inventory.html).

The inventory script will output the details of your hosts according to their EC2 TAGS so always taa your instances with something meaningful to you and then use that

For example.  If the tag name for your instance is `tag_Webservers_rjh`
```
---
- name: My cool playbook
  hosts: tag_Webservers_rjh
```


### Using the dynamic Inventory script

In order for the `ec2.py` script to query the AWS endpoint, you will need to provide it with your API credentials. The easiest way to do this is to export your AWS ec2 access credentials as shell variables.

Note:
Your API identity keys can be found within the AWS console under security information.
If you dont know what these are then chances are you will need to go into the console and create some.

`export AWS_ACCESS_KEY_ID=ABCDEFGHILFJKHUSKAJHSD`

`export AWS_SECRET_ACCESS_KEY=LONGKEYTHATISSECRET`

`./ec2.py`

