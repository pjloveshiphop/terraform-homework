resource "aws_dynamodb_table" "dynamodb_remote_backend" {
  name         = var.dynamodb_remote_backend_table_nm
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
