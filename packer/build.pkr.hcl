build {
  sources = [
    "source.amazon-ebs.builder",
  ]

  provisioner "ansible" {
    groups = [ "${var.configuration_group}" ]
    playbook_file = "${var.playbook_file_path}"
    extra_arguments  = [
      "-e", "aws_region=${var.aws_region}",
      "-e", "artifactory_version=${var.artifactory_version}",
      "-e", "ssh_username=${var.ssh_username}",
      "-e", "resource_bucket_artifactory_prefix=${var.resource_bucket_artifactory_prefix}",
      "-e", "resource_bucket_name=${var.resource_bucket_name}"
    ]
  }
}
