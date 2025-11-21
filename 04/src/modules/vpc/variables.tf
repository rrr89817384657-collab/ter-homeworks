
variable "env_name" {
  type        = string
  description = "environment name "
}

variable "zone" {
  type        = string
  description = "zone for subnet"
}

variable "v4_cidr_blocks" {
  type        = string
  description = "cidr for subnet"
}