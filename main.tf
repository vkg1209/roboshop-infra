
resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.mongodb_sg_id]
  subnet_id = local.database_subnet_id


  tags = merge(
    local.common-tags,
    {
        Name = "${local.common_suffix_name}-mongodb"
    }
  )
}

resource "terraform_data" "mongodb" {
    triggers_replace = [aws_instance.mongodb.id]

    connection {
        type     = "ssh"
        user     = "ec2-user"
        password = "DevOps321"
        host     = aws_instance.mongodb.private_ip
  }

    provisioner "file" {
      source = "bootstrap.sh"
      destination = "/tmp/bootstrap.sh"
    }

    provisioner "remote-exec" {
      inline = [ 
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh mongodb"
       ]
    }

}


resource "aws_instance" "redis" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.redis_sg_id]
  subnet_id = local.database_subnet_id


  tags = merge(
    local.common-tags,
    {
        Name = "${local.common_suffix_name}-redis"
    }
  )
}

resource "terraform_data" "redis" {
    triggers_replace = [aws_instance.redis.id]

    connection {
        type     = "ssh"
        user     = "ec2-user"
        password = "DevOps321"
        host     = aws_instance.redis.private_ip
  }

    provisioner "file" {
      source = "bootstrap.sh"
      destination = "/tmp/bootstrap.sh"
    }

    provisioner "remote-exec" {
      inline = [ 
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh redis"
       ]
    }

}


resource "aws_instance" "rabbitmq" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.rabbitmq_sg_id]
  subnet_id = local.database_subnet_id


  tags = merge(
    local.common-tags,
    {
        Name = "${local.common_suffix_name}-rabbitmq"
    }
  )
}

resource "terraform_data" "rabbitmq" {
    triggers_replace = [aws_instance.rabbitmq.id]

    connection {
        type     = "ssh"
        user     = "ec2-user"
        password = "DevOps321"
        host     = aws_instance.rabbitmq.private_ip
  }

    provisioner "file" {
      source = "bootstrap.sh"
      destination = "/tmp/bootstrap.sh"
    }

    provisioner "remote-exec" {
      inline = [ 
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh rabbitmq"
       ]
    }

}

resource "aws_instance" "mysql" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.mysql_sg_id]
  subnet_id = local.database_subnet_id

  iam_instance_profile = aws_iam_instance_profile.mysql_profile.name

  tags = merge(
    local.common-tags,
    {
        Name = "${local.common_suffix_name}-mysql"
    }
  )
}

resource "terraform_data" "mysql" {
    triggers_replace = [aws_instance.mysql.id]

    connection {
        type     = "ssh"
        user     = "ec2-user"
        password = "DevOps321"
        host     = aws_instance.mysql.private_ip
  }

    provisioner "file" {
      source = "bootstrap.sh"
      destination = "/tmp/bootstrap.sh"
    }

    provisioner "remote-exec" {
      inline = [ 
        "chmod +x /tmp/bootstrap.sh",
        "sudo sh /tmp/bootstrap.sh mysql dev"
       ]
    }

}

resource "aws_iam_instance_profile" "mysql_profile" {
  name = "mysql"
  role = "ec2SSMParameter"
}

resource "aws_route53_record" "mongodb" {
  zone_id = "${local.zone_id}"
  name    = "mongodb-${var.env}.${var.domain_name}" # mongodb.daws86s.fun
  type    = "A"
  ttl     = 1
  records = [aws_instance.mongodb.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "redis" {
  zone_id = "${local.zone_id}"
  name    = "redis-${var.env}.${var.domain_name}" 
  type    = "A"
  ttl     = 1
  records = [aws_instance.redis.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "rabbitmq" {
  zone_id = "${local.zone_id}"
  name    = "rabbitmq-${var.env}.${var.domain_name}" # 
  type    = "A"
  ttl     = 1
  records = [aws_instance.rabbitmq.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "mysql" {
  zone_id = "${local.zone_id}"
  name    = "mysql-${var.env}.${var.domain_name}" # 
  type    = "A"
  ttl     = 1
  records = [aws_instance.mysql.private_ip]
  allow_overwrite = true
}

