resource "aws_iam_role" "eks_role" {
	name = "kwa-eks-role"
	assume_role_policy = jsonencode({
		Version = "2012-10-17"
		Statement = [
			{
				Action = "sts:AssumeRole"
				Effect = "Allow"
				Principal = {
					Service = "eks.amazonaws.com"	
				}
			}
		]
	})
}

resource "aws_iam_role_policy_attachment" "eks_policy" {
	policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
	role = aws_iam_role.eks_role.name
}

resource "aws_iam_role_policy_attachment" "eks_vpc_controller" {
	policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
	role       = aws_iam_role.eks_role.name
}

resource "aws_eks_cluster" "eks" {
	name = var.cluster_name
	role_arn = aws_iam_role.eks_role.arn

	vpc_config {
		subnet_ids = [var.public, var.private]
	}

	tags = {
		Name = "kwa-aline-cluster"
	}

	depends_on = [aws_iam_role_policy_attachment.eks_policy, aws_iam_role_policy_attachment.eks_vpc_controller]
}