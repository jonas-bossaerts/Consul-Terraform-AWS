resource "aws_iam_role" "stage" {
  name = "eks-cluster-stage"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "stage-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.stage.id
}

resource "aws_eks_cluster" "stage" {
  name     = "demo"
  role_arn = aws_iam_role.stage.arn

  vpc_config {
    subnet_ids = [ 
      aws_subnet.private-eu-west-1a.id,
      aws_subnet.private-eu-west-1b.id,
      aws_subnet.private-eu-west-1c.id,
      aws_subnet.public-eu-west-1a.id,
    ]
  }

  #depends_on = [aws_iam_role_policy_attachment.demo-AmazonEKSClusterPolicy]
}