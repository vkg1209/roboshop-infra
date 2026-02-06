data "aws_ami" "joindevops" {
    owners           = ["973714476881"]
    most_recent      = true
    
    filter {
        name   = "name"
        values = ["Redhat-9-DevOps-Practice"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}

data "aws_ssm_parameter" "mongodb_sg_id" {
  name = "/${var.project}/${var.env}/mongodb/sg-id"
}

data "aws_ssm_parameter" "database_subnet_ids" {
  name = "/${var.project}/${var.env}/database_subnet_ids"
}

data "aws_ssm_parameter" "redis_sg_id" {
    name = "/${var.project}/${var.env}/redis/sg-id"
}

data "aws_ssm_parameter" "rabbitmq_sg_id" {
    name = "/${var.project}/${var.env}/rabbitmq/sg-id"
}

data "aws_ssm_parameter" "rabbitmq_sg_id" {
    name = "/${var.project}/${var.env}/mysql/sg-id"
}