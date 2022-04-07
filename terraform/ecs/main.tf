resource "aws_ecs_cluster" "ecs" {
    name = "kwa-aline-ecs"

    setting {
        name = "containerInsights"
        value = "enabled"
    }

    tags = {
        Name = "kwa-aline-ecs"
    }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "kwa-aline-task-role"
 
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role" "ecs_task_role" {
  name = "kwa-role"
 
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}
 
resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "task_s3" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "task_ecr" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

#resource "aws_iam_role_policy_attachment" "ecs-service-role-policy-attachment" {
#  role       = aws_iam_role.ecs_task_execution_role.name
#  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSServiceRolePolicy"
#}

#resource "aws_ecs_task_definition" "user-task" {
#  family                   = "user-task"
#  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
#  task_role_arn            = aws_iam_role.ecs_task_role.arn
#  network_mode             = "awsvpc"
#  cpu                      = "256"
#  memory                   = "1024"
#  requires_compatibilities = ["FARGATE"]
#  container_definitions = jsonencode([
#         {
#             name = "UserMicroservice-kwa"
#             image = "086620157175.dkr.ecr.us-east-1.amazonaws.com/kwa-user_microservice"
#             essential = true
#             environment = [
#                 {"name": "ENCRYPT_SECRET_KEY",  "value": "NVNCWq4KEDHXNjsazdGX2oZ1"},
#                 {"name": "JWT_SECRET_KEY",      "value": "1wHqQFdUlUr5TZNr1wTCiuyM0Vye2L4jX"},
#                 {"name": "DB_USERNAME",         "value": "kevin.wang"},
#                 {"name": "DB_PASSWORD",         "value": "Kw990318!"},
#                 {"name": "DB_HOST",             "value": "aline-database-instance-1.cpghzbngoldo.us-east-1.rds.amazonaws.com"},
#                 {"name": "DB_PORT",             "value": "3306"},
#                 {"name": "DB_NAME",             "value": "alinedb-kwa"},
#                 {"name": "APP_PORT",            "value": "8070"}
#             ]
#             portMappings = [
#                 {
#                     containerPort = 8070
#                     hostPort = 8070
#                 }
#             ]
#        }
#     ])
#}

#resource "aws_ecs_service" "service" {
#  name            = "user-service"
#  cluster         = aws_ecs_cluster.ecs.id
#  task_definition = aws_ecs_task_definition.user-task.arn
#  desired_count = 1
#  launch_type = "FARGATE"
#  #iam_role        = aws_iam_role.ecs_task_execution_role.arn

#  network_configuration {
#    subnets = [var.public, var.public2]
#    security_groups = [var.sg_http, var.sg_ssh]

#  }

#  load_balancer {
#    target_group_arn = aws_lb_target_group.tg.arn
#    container_name   = "UserMicroservice-kwa"
#    container_port   = 8070
#  }
#}

#resource "aws_lb_target_group" "tg" {
#  name     = "kwa-alb-tg"
#  port     = 8083
#  protocol = "HTTP"
#  target_type = "ip"
#  vpc_id   = var.vpc_id
#}

#resource "aws_lb_listener" "alb-listener" {
#  load_balancer_arn = var.alb.arn
#  port              = "8083"
#  protocol          = "HTTP"
  
#  default_action {
#    type             = "forward"
#    target_group_arn = aws_lb_target_group.tg.arn
#  }
#}