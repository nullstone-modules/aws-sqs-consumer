resource "aws_iam_role_policy_attachment" "access" {
  role       = var.app_metadata["role_name"]
  policy_arn = aws_iam_policy.access.arn
}

resource "aws_iam_policy" "access" {
  name   = local.resource_name
  tags   = local.tags
  policy = data.aws_iam_policy_document.access.json
}

data "aws_iam_policy_document" "access" {
  statement {
    effect    = "Allow"
    resources = [local.queue_arn]

    actions = [
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:DeleteMessageBatch",
      "sqs:ChangeMessageVisibility",
      "sqs:ChangeMessageVisibilityBatch",
      "sqs:GetQueueUrl"
    ]
  }

  dynamic "statement" {
    for_each = local.kms_key_arn == "" ? [] : [local.kms_key_arn]

    content {
      effect    = "Allow"
      resources = [statement.value]
      actions   = ["kms:Decrypt"]
    }
  }
}
