# General Variables
#region
variable "region" {
  description = "Default region for provider"
  type        = string
  default     = "us-west-2"
}

#profile
variable "profile" {
  description = "aws profile name"
  type        = string
  default     = "test" #give profile name
}
