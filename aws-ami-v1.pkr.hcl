# If you have your default VPC available then use it. 

# packer puglin for AWS 
# https://www.packer.io/plugins/builders/amazon 
packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# which ami to use as the base and where to save it
source "amazon-ebs" "amazon-linux" {
  region          = "ap-southeast-2"
  ami_name        = "ami-version-1.0.1-{{timestamp}}"
  instance_type   = "t2.micro"
  source_ami      = "ami-0d6294dcaac5546e4"
  ssh_username    = "ec2-user"
  #ami_users       = ["AWS Account ID"]
  ami_regions     = [
                      "ap-southeast-2"
                    ]
}

# what to install, configure and file to copy/execute
build {
  name = "hq-packer"
  sources = [
    "source.amazon-ebs.amazon-linux"
  ]

  provisioner "file" {
  source = "ansible-playbook.yml"
  destination = "/tmp/ansible-playbook.yml"
}
  provisioner "shell" {
  inline = [
    "sudo yum install -y epel-release",
    "sudo yum install -y ansible",
    "ansible --version",
    "ansible-playbook --version",
    "ansible-playbook -i localhost, /tmp/ansible-playbook.yml"
  ]
}
}