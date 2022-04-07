output "ecs" {
	value = aws_ecs_cluster.ecs
	description = "ECS Cluster"
}

output "ecs_role" {
	value = aws_iam_role.ecs_task_execution_role
	description = "Execution role for task"
}

output "task_role" {
	value = aws_iam_role.ecs_task_role
	description = "Task Role"
}