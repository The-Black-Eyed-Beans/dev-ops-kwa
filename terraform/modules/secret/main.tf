resource "aws_secretsmanager_secret" "resources" {
	name = "aline-kwa/dev/secrets/resource"
}

resource "aws_secretsmanager_secret_version" "version" {
	secret_id = aws_secretsmanager_secret.resources.id
	secret_string = <<EOF
	{
		"VpcId": "${var.vpc_id}",
		"LoadBalancerArn": "${var.alb.arn}",
		"Public1": "${var.public1}",
		"Public2": "${var.public2}",
		"Private1": "${var.private1}",
		"Private2": "${var.private2}",
		"ExecutionRole": "${var.ecs_role.arn}",
		"TaskRole": "${var.task_role.arn}",
		"Sghttp": "${var.sg_http}"
	}
EOF
}