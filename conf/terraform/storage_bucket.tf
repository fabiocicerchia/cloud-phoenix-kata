resource "aws_s3_bucket" "cpk-bucket" {
  acl    = "private"
  bucket = var.s3_bucket

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true

    noncurrent_version_expiration {
      days = 7
    }
  }

  tags = {
    Terraform   = "true"
    Author      = "fabiocicerchia"
    Environment = "base"
    Service     = "cloud-phoenix-kata"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "access_block" {
  bucket = aws_s3_bucket.cpk-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
