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