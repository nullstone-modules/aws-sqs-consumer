output "env" {
  value = [
    {
      name  = "QUEUE_URL"
      value = local.queue_url
    },
    {
      name  = "QUEUE_NAME"
      value = local.queue_name
    }
  ]
}
