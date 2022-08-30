# ami-repository-template

Provides a base template for Packer and Ansible based AMI builds.

### Ansible

All Ansible configuration resides in the `./ansible` directory. The Ansible configuration will be called during the provisioning step of the Packer build as defined in `./packer/build.pkr.hcl`.

This template provides the basic code layout and structure only.

### Development

For convenience development scripts have been supplied and are as follows:

| Script                | Description                                                                                                                                       |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| inventory_aws_ec2.yml | Defines a dynamic inventory for Ansible by way of the `aws_ec2` plugin                                                                            |
| print-inventory       | Prints the inventory hosts for debugging purposes                                                                                                 |
| run-ansible           | Runs the playbook against the configured hosts. **Note**: This requires Ansible be installed on the host system                                   |
| variables.json        | A means of specifying additional variables. **Note**: These values should never be committed and as such this file has been added to `.gitignore` |

### Packer Variables

All Packer configuration resides in the `./packer` directory and utilises standard Packer configuration syntax.

The template provides the following variables to control the Packer build and provisioning process.

| Variable                   | Type   | Default                          | Description                                                                                                                                               |
| -------------------------- | ------ | -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ami_account_ids            | string | -                                | A list of account IDs that have access to launch the resulting AMI(s).                                                                                    |
| ami_name_prefix            | string | -                                | Prefix used for the name tags of resulting AMIs. The version will be appended to this.                                                                    |
| aws_instance_type          | string | t3.small                         | AWS EC2 instance type used when building the AMI.                                                                                                         |
| aws_region                 | string | eu-west-2                        | The region in which the AMI will be built.                                                                                                                |
| aws_source_ami_filter_name | string | amzn2-base-\*                    | Source AMI filter string as per the DescribeImages API documentation. If multiple match, the latest image will be used.                                   |
| aws_source_ami_owner_id    | string | -                                | The source AMI owner ID. Used in combination with `aws_source_ami_filter_name` to match the source AMI.                                                   |
| aws_subnet_filter_name     | string | -                                | Subnet filter string as per the DescribeSubnets API documentation. If multiple match, the subnet with the greatest number of IPv4 addresses will be used. |
| configuration_group        | string | unnamed                          | The name of the group to which to add the instance for configuration purposes                                                                             |
| data_volume_size_gib       | number | -                                | The EC2 instance data volume size in Gibibytes (GiB)                                                                                                      |
| force_delete_snapshot      | bool   | false                            | Automatically delete snapshots associated with AMIs deregistered by `force_deregister`.                                                                   |
| force_deregister           | bool   | false                            | Deregister an existing AMI if one with the same name exists.                                                                                              |
| playbook_file_path         | string | ../ansible/playbook.yml          | Relative path to the Ansible playbook file.                                                                                                               |
| root_volume_size_gb        | number | 20                               | The EC2 instance root volume size in Gibibytes (GiB).                                                                                                     |
| ssh_private_key_file       | string | /home/packer/.ssh/packer-builder | The path to the common Packer builder private SSH key.                                                                                                    |
| ssh_username               | string | centos                           | The username Packer will use when connecting with SSH.                                                                                                    |
| version                    | string | -                                | Semantic version number for the AMI. Will be automatically appended to `ami_name_prefix` to tag the resulting AMI and snapshots.                          |
