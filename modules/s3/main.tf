resource "aws_s3_bucket" "remote_backend_bucket" {
  bucket = var.s3_remote_backend_bucket_nm
  lifecycle {
    # prevent_destroy = each.value.prevent_destroy
    prevent_destroy = false
  }
  tags = {
    Name = var.s3_remote_backend_bucket_nm
  }
}

resource "aws_s3_bucket_versioning" "remote_backend_bucket_versioning" {
  bucket = aws_s3_bucket.remote_backend_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "remote_backend_bucket_sse" {
  bucket = aws_s3_bucket.remote_backend_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
