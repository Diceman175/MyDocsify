# ============================================================
# Title: Your Terraform Configuration
# Purpose: A brief description of what this infrastructure defines
# ============================================================
#
# METADATA:
#   filename: main.tf
#   title: Your Terraform Configuration
#   authorname: Your Name
#   version: 2026-04-21
#   created: 2026-04-20
#   last_updated: 2026-04-21
#
# CHANGELOG:
#   Version 2026-04-21 - Your Name
#     OPS: Include rules-change-codes files and update metadata
#   Version 2026-04-21 - Your Name
#     CHG: Clean 1.0.2 baseline snapshot
#   Most recent entries first. Reference change codes from
#   rules-change-codes.jsonc for semantic versioning.
#
#   Version 0.1.0 - 2026-04-20 - Your Name
#     IMP: Initial Terraform configuration with metadata template
#
# CHANGE CODES:
#   Reference: rules-change-codes.jsonc
#
#   FIX  - Bug fixes (patch bump)
#   IMP  - New features (minor bump)
#   CHG  - Improvements/refactoring (minor bump)
#   REF  - Documentation/references (patch bump)
#   BRK  - Breaking changes (major bump)
#   SEC  - Security fixes (patch bump)
#   TST  - Tests/CI (patch bump)
#   DOC  - Documentation (patch bump)
#   CFG  - Configuration (minor bump)
#   DEP  - Dependencies (patch bump)
#   OPS  - Operations/deployment (patch bump)
#   WIP  - Work in progress (no version bump)
#
# USAGE:
#   terraform init
#   terraform plan  -var-file="terraform.tfvars"
#   terraform apply -var-file="terraform.tfvars"
#   terraform destroy
#
# NOTES:
#   Copy terraform.tfvars.example -> terraform.tfvars and fill values.
#   Never commit terraform.tfvars or *.tfstate to version control.
#   For full code definitions, see rules-change-codes.jsonc
# ============================================================


# ============================================================
# Terraform Settings
# ============================================================

terraform {
  required_version = ">= 1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    # azurerm = {
    #   source  = "hashicorp/azurerm"
    #   version = "~> 3.0"
    # }
  }

  # Remote state backend (uncomment and configure as needed)
  # backend "s3" {
  #   bucket         = "your-tf-state-bucket"
  #   key            = "your-project/terraform.tfstate"
  #   region         = "us-east-1"
  #   encrypt        = true
  #   dynamodb_table = "your-tf-lock-table"
  # }
}


# ============================================================
# Provider Configuration
# ============================================================

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
      Owner       = var.owner
    }
  }
}


# ============================================================
# Variables
# ============================================================

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment: dev, staging, or production"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "production"], var.environment)
    error_message = "environment must be one of: dev, staging, production"
  }
}

variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}

variable "owner" {
  description = "Owner name or team responsible for this infrastructure"
  type        = string
}


# ============================================================
# Locals
# ============================================================

locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
    Owner       = var.owner
  }
}


# ============================================================
# Data Sources
# ============================================================

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}


# ============================================================
# Resources
# ============================================================

# Example: S3 bucket
resource "aws_s3_bucket" "example" {
  bucket = "${local.name_prefix}-example-bucket"
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.example.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket                  = aws_s3_bucket.example.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


# ============================================================
# Outputs
# ============================================================

output "bucket_name" {
  description = "The name of the example S3 bucket"
  value       = aws_s3_bucket.example.bucket
}

output "account_id" {
  description = "AWS account ID"
  value       = data.aws_caller_identity.current.account_id
  sensitive   = false
}
