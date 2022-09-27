build {
  sources = [
    "source.amazon-ebs.builder",
  ]

  provisioner "ansible" {
    host_alias = "${var.ansible_host_alias}"
    groups = [ "${var.configuration_group}" ]
    playbook_file = "${var.playbook_file_path}"
    extra_arguments  = [
      "-e", "aws_region=${var.aws_region}",
      "-e", "artifactory-version=${var.artifactory-version}",
      "-e", "ssh_username=${var.ssh_username}",
      "-e", "jfrog=${var.jfrog}",
      "-e", "resource_bucket_name=${var.resource_bucket_name}"
    ]
  }
}