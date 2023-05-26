data "ns_connection" "sqs" {
  name     = "sqs"
  contract = "datastore/aws/sqs"
}

locals {
  queue_name  = data.ns_connection.sqs.outputs.queue_name
  queue_url   = data.ns_connection.sqs.outputs.queue_url
  queue_arn   = data.ns_connection.sqs.outputs.queue_arn
  kms_key_id  = try(data.ns_connection.sqs.outputs.kms_key_id, "")
  kms_key_arn = local.kms_key_id == "" ? "" : data.aws_kms_key.sqs_key[0].arn
}

data "aws_kms_key" "sqs_key" {
  count  = local.kms_key_id == "" ? 0 : 1
  key_id = local.kms_key_id
}
