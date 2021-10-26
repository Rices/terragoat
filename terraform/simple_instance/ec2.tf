provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "ssh_traffic" {
  name        = "ssh_traffic"
  description = "Allow SSH inbound traffic"
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    git_commit           = "83cb31211c1003f8b680967d59d6abe253179926"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-10-26 01:22:40"
    git_last_modified_by = "sebastian.salla@uqconnect.edu.au"
    git_modifiers        = "sebastian.salla"
    git_org              = "Rices"
    git_repo             = "terragoat"
    yor_trace            = "0add4b35-7be6-469b-b8b3-424ba2a54053"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "83cb31211c1003f8b680967d59d6abe253179926"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-10-26 01:22:40"
    git_last_modified_by = "sebastian.salla@uqconnect.edu.au"
    git_modifiers        = "sebastian.salla"
    git_org              = "Rices"
    git_repo             = "terragoat"
    yor_trace            = "7f821c07-475b-49aa-bd3f-7174ce58e089"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
