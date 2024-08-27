// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

# Resource name variables
variable "logical_product_family" {
  type        = string
  description = <<EOF
    (Required) Name of the product family for which the resource is created.
    Example: org_name, department_name.
  EOF
  nullable    = false
  default     = "launch"

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_family))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }
}
variable "logical_product_service" {
  type        = string
  description = <<EOF
    (Required) Name of the product service for which the resource is created.
    For example, backend, frontend, middleware etc.
  EOF
  nullable    = false
  default     = "backend"

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_service))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }
}

variable "region" {
  type        = string
  description = <<EOF
    (Required) The location where the resource will be created. Must not have spaces
    For example, us-east-1, us-west-2, eu-west-1, etc.
  EOF
  nullable    = false
  default     = "us-east-2"

  validation {
    condition     = length(regexall("\\b \\b", var.region)) == 0
    error_message = "Spaces between the words are not allowed."
  }
}

variable "class_env" {
  type        = string
  default     = "dev"
  description = "(Required) Environment where resource is going to be deployed. For example. dev, qa, uat"
  nullable    = false

  validation {
    condition     = length(regexall("\\b \\b", var.class_env)) == 0
    error_message = "Spaces between the words are not allowed."
  }
}

variable "instance_env" {
  type        = number
  description = "Number that represents the instance of the environment."
  default     = 0

  validation {
    condition     = var.instance_env >= 0 && var.instance_env <= 999
    error_message = "Instance number should be between 1 to 999."
  }
}

variable "instance_resource" {
  type        = number
  description = "Number that represents the instance of the resource."
  default     = 0

  validation {
    condition     = var.instance_resource >= 0 && var.instance_resource <= 100
    error_message = "Instance number should be between 1 to 100."
  }
}

variable "maximum_length" {
  type        = number
  description = "Number that represents the maximum length the resource name could have."
  default     = 60

  validation {
    condition     = var.maximum_length >= 10 && var.maximum_length <= 512
    error_message = "Maximum length number should be between 24 to 512."
  }
}

variable "separator" {
  type        = string
  description = "Separator to be used in the name"
  default     = "-"

  validation {
    condition     = length(trimspace(var.separator)) == 1
    error_message = "Length of the separator must be 1 character."
  }

  validation {
    condition     = length(regexall("[._-]", var.separator)) > 0
    error_message = "Only '.', '_', '-' are allowed as separator."
  }
}


variable "resource_names_map" {
  description = "A map of key to resource_name that will be used by tf-launch-module_library-resource_name to generate resource names."
  type = map(object(
    {
      name       = string
      max_length = optional(number, 60)
    }
  ))
  default = {
    s3_bucket = {
      name = "s3"
    }
  }
}

# Secret variables
variable "secret_name" {
  description = "The description of the secrets."
  type        = string
  default     = null
}

variable "description" {
  description = "The description of the secrets."
  type        = string
  default     = null
}

variable "recovery_window_in_days" {
  description = "The number of days to retain the secret after rotation before deletion"
  type        = number
  default     = null
}

variable "ignore_secret_changes" {
  description = "Determines whether or not Terraform will ignore changes made externally to secret_string or secret_binary. Changing this value after creation is a destructive operation"
  type        = bool
  default     = false
}

variable "secret_string" {
  description = "The JSON string containing the secret data"
  type        = string
  default     = null
}

variable "enable_rotation" {
  description = "Whether to enabled rotation for the secret"
  type        = bool
  default     = false
}

variable "rotation_lambda_arn" {
  description = "The ARN of the Lambda function that performs rotation"
  type        = string
  default     = ""
}

variable "rotation_rules" {
  description = "Rotation rules for the secret, including the schedule expression"
  type        = object({})
  default     = {}
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`). Neither the tag keys nor the tag values will be modified by this module."

  validation {
    condition     = alltrue([for k, v in keys(var.tags) : can(regex("^.{1,127}$", k) && can(regex("^.{1,255}$", v)))])
    error_message = "Keys and values in tags must be between 1 and 127 and 1 and 255 characters long, respectively."
  }
}

variable "kms_key_description" {
  description = "KMS key description. This KMS key is used for SSE-KMS encryption f source bucket."
  type        = string
  default     = "KMS key used for source bucket encryption"
}

variable "kms_key_deletion_window_in_days" {
  description = "(Optional) The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key. If you specify a value, it must be between 7 and 30, inclusive. If you do not specify a value, it defaults to 30. If the KMS key is a multi-Region primary key with replicas, the waiting period begins when the last of its replica keys is deleted. Otherwise, the waiting period begins immediately."
  type        = number
  default     = 30
}
