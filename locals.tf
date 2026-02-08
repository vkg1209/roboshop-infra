locals {
    common_suffix_name = "${var.project}-${var.env}"
    ami_id = data.aws_ami.joindevops.id
    mongodb_sg_id = data.aws_ssm_parameter.mongodb_sg_id.value
    redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value
    rabbitmq_sg_id = data.aws_ssm_parameter.rabbitmq_sg_id.value
    mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
    database_subnet_id = split(",", data.aws_ssm_parameter.database_subnet_ids.value)[0]
    zone_id = data.aws_route53_zone.domain_name.zone_id
    common-tags = {
        Project = var.project
        Environment = var.env
        Terraform = "true"
    }
}   