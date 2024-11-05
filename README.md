# artifactory-ami

Packer and Ansible configuration to build an AMI for use with Artifactory

## Ansible

All Ansible configuration resides in the `./ansible` directory. The Ansible configuration will be called during the provisioning step of the Packer build as defined in `./packer/build.pkr.hcl`.

This template provides the basic code layout and structure only.

## Packer

All Packer configuration resides in the `./packer` directory and utilises standard Packer configuration syntax.

### Packer Variables

The template provides the following variables to control the Packer build and provisioning process.

| Variable                           | Type   | Default                          | Description                                                                                                                                               |
| ---------------------------------- | ------ | -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ami_account_ids                    | string | -                                | A list of account IDs that have access to launch the resulting AMI(s).                                                                                    |
| ami_name_prefix                    | string | -                                | Prefix used for the name tags of resulting AMIs. The version will be appended to this.                                                                    |
| aws_instance_type                  | string | t3.small                         | AWS EC2 instance type used when building the AMI.                                                                                                         |
| aws_region                         | string | eu-west-2                        | The region in which the AMI will be built.                                                                                                                |
| aws_source_ami_filter_name         | string | amzn2-base-\*                    | Source AMI filter string as per the DescribeImages API documentation. If multiple match, the latest image will be used.                                   |
| aws_source_ami_owner_id            | string | -                                | The source AMI owner ID. Used in combination with `aws_source_ami_filter_name` to match the source AMI.                                                   |
| aws_subnet_filter_name             | string | -                                | Subnet filter string as per the DescribeSubnets API documentation. If multiple match, the subnet with the greatest number of IPv4 addresses will be used. |
| configuration_group                | string | unnamed                          | The name of the group to which to add the instance for configuration purposes                                                                             |
| force_delete_snapshot              | bool   | false                            | Automatically delete snapshots associated with AMIs deregistered by `force_deregister`.                                                                   |
| force_deregister                   | bool   | false                            | Deregister an existing AMI if one with the same name exists.                                                                                              |
| kms_key_id                         | string | alias/packer-builders-kms        | The KMS key ID or alias to use when encrypting the AMI EBS volumes; defaults to the AWS managed key if empty.                                             |
| playbook_file_path                 | string | ../ansible/playbook.yml          | Relative path to the Ansible playbook file.                                                                                                               |
| root_volume_delete_on_termination  | bool   | true                             | Indicates whether the EBS volume is deleted on instance termination.                                                                                      |
| root_volume_iops                   | number | 3000                             | The volume IOPS; 3000 is the gp3 default.                                                                                                                 |
| root_volume_size_gb                | number | 20                               | The EC2 instance root volume size in Gibibytes (GiB).                                                                                                     |
| root_volume_throughput             | number | 125                              | The volume throughput in MiB/s; 125 is the gp3 default.                                                                                                   |
| ssh_private_key_file               | string | /home/packer/.ssh/packer-builder | The path to the common Packer builder private SSH key.                                                                                                    |
| ssh_username                       | string | centos                           | The username Packer will use when connecting with SSH.                                                                                                    |
| version                            | string | -                                | Semantic version number for the AMI. Will be automatically appended to `ami_name_prefix` to tag the resulting AMI and snapshots.                          |
| artifactory_version                | string | 7.77.14                          | The semantic version number for the Artifactory release which is subsequently passed in to Ansible.                                                       |
| resource_bucket_name               | string | -                                | The name of the S3 resources bucket which is subsequently passed in to Ansible.                                                                           |
| resource_bucket_artifactory_prefix | string | -                                | The object prefix for artifactory packages within the S3 resources bucket which is subsequently passed in to Ansible.                                     |
