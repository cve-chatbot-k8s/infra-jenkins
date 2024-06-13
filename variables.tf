variable "ami_id" {
  description = "Value of the jenkins ami image"
  type        = string
  #  default     = "ami-0672ad10ddf65a6ee"
}

variable "instance_type" {
  description = "EC2 instance machine type"
  type        = string
  default     = "t2.medium"
}

variable "instance_name" {
  description = "EC2 instance machine name tag"
  type        = string
  default     = "JenkinsServerInstance"
}

variable "region" {
  description = "Region for deployment"
  type        = string
  default     = "us-east-1"
}

variable "required_version" {
  description = "Minimum required version of tf"
  type        = string
  default     = ">= 1.2.0"
}

variable "aws_provider_version" {
  description = "Required version of tf"
  type        = string
  default     = "~>4.16"
}

variable "allocation_id" {
  description = "Allocated ID of EIP"
  type        = string
  default     = "eipalloc-04d1bcc0cd1f66ba3"
}
