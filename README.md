# SQS Consumer

Nullstone capability to consume SQS messages manually.

This injects `QUEUE_NAME` and `QUEUE_URL` for an attached SQS datastore.
Additionally, it grants the application IAM role access to consume messages from the queue through manual API operations.
This includes receiving messages and deleting messages that the application processes.
