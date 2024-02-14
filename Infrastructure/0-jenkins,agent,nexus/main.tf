terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}



resource "aws_instance" "jenkins" {
  ami                    = "ami-0f3c7d07486cad139"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-01d1c07254aeb8065"]

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp2"
  }

  user_data = file("jenkins.sh")

  tags = {
    Name = "Jenkins"
  }

}



resource "aws_instance" "AGENT_1" {
  ami                    = "ami-0f3c7d07486cad139"
  instance_type          = "t3.medium"
  vpc_security_group_ids = ["sg-01d1c07254aeb8065"]
  iam_instance_profile   = "instance_creation_shell"

  root_block_device {
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "gp2"
  }

  user_data = file("agent-1.sh")

  tags = {
    Name = "AGENT-1"
  }
}


resource "aws_instance" "nexus" {

  ami                    = "ami-0f3c7d07486cad139"
  instance_type          = "t3.medium"
  vpc_security_group_ids = ["sg-01d1c07254aeb8065"]

  root_block_device {
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "gp2"
  }

  user_data = file("nexus.sh")


  tags = {
    Name = "Nexus"
  }

}


output "jenkins_private_ip" {
  value = aws_instance.jenkins.private_ip
}

output "jenkins_public_ip" {
  value = "${aws_instance.jenkins.public_ip}:8080"
}

output "AGENT_1_private_ip" {
  value = aws_instance.AGENT_1.private_ip
}

output "AGENT_1_public_ip" {
  value = aws_instance.AGENT_1.public_ip
}

output "nexus_private_ip" {
  value = aws_instance.nexus.private_ip
}

output "nexus_public_ip" {
  value = "${aws_instance.nexus.public_ip}:8081"
}

# output "sonarqube_private_ip" {
#   value = aws_instance.sonarqube.private_ip
# }

# output "sonarqube_public_ip" {
#   value = "${aws_instance.sonarqube.public_ip}:9000"
# }



# resource "aws_instance" "sonarqube" {

#   ami                    = "ami-0f3c7d07486cad139"
#   instance_type          = "t3.medium"
#   vpc_security_group_ids = ["sg-01d1c07254aeb8065"]

#   root_block_device {
#     delete_on_termination = true
#     volume_size           = 30
#     volume_type           = "gp2"
#   }

#   user_data = file("sonarqube.sh")


#   tags = {
#     Name = "SonarQube"
#   }

# }
