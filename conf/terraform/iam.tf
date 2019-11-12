resource "aws_iam_policy" "cpk-ECRPush" {
  name        = "cpk-ECRPush"
  path        = "/"

  policy = templatefile("conf/terraform/files/aws_policies/ecr-push.json", {
    region : var.region,
    owner_id : var.owner_id,
    ecr_name : var.ecr_name
  })
}

resource "aws_iam_group" "cpk-group" {
  name = "cloud-phoenix-kata"
}

resource "aws_iam_group_policy_attachment" "cpk-ecr" {
  group      = aws_iam_group.cpk-group.name
  policy_arn = aws_iam_policy.cpk-ECRPush.arn
}
