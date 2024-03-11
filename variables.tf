variable "public_subnets" {
  type        = list(string)
  description = "A list of the CIDR ranges required for the public subnets"
}

variable "private_subnets" {
  type        = list(string)
  description = "A list of the CIDR ranges required for the private subnets"
}

variable "azs" {
  type        = list(string)
  description = "A list of the Availability Zones you wish to provision infrastructure in"
}

variable "instance_type" {
  type = string
}

variable "desired_capacity" {
  type = number
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "launch_template_aws_launch_template_lighting" {
  type = string
}

variable "launch_template_aws_launch_template_heating" {
  type = string
}

variable "launch_template_aws_launch_template_auth" {
  type = string
}

variable "launch_template_aws_launch_template_status" {
  type = string
}