# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

/*===========================
      AWS S3 resources
============================*/

resource "aws_s3_bucket" "s3_bucket" {
  bucket        = var.bucket_name
  # acl           = "private"
  force_destroy = true
  tags = {
    Name = var.bucket_name
  }
}

# aws_s3_bucket_acl
# resource "aws_s3_bucket_acl" "s3_bucket_acl" {
#   bucket = aws_s3_bucket.s3_bucket.id
#   acl    = "private"

#   lifecycle {
#     ignore_changes = [acl]
#   }
# }

# resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
#   bucket = aws_s3_bucket.s3_bucket.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }

#   lifecycle {
#     ignore_changes = [versioning_configuration]
#   }
# }

# resource "aws_s3_bucket_policy" "s3_bucket_policy" {
#   bucket = aws_s3_bucket.s3_bucket.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = "*"
#         Action = "s3:GetObject"
#         Resource = "${aws_s3_bucket.s3_bucket.arn}/*"
#       }
#     ]
#   })
# }

# variable "bucket_name" {
#   description = "The name of the S3 bucket"
#   type        = string
#   default     = "my-ecs-app-bucket"
# } 

# variable "create_bucket" {
#   description = "Flag to create the S3 bucket"
#   type        = bool
#   default     = true
# } 

# variable "create_versioning" {
#   description = "Flag to enable versioning on the S3 bucket"
#   type        = bool
#   default     = true
# }
