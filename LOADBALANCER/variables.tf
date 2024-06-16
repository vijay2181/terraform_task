# Variables
variable "profile" {
  default = "test" # Replace with your AMI ID
}

variable "region" {
  default = "us-west-2" # Replace with your AMI ID
}

variable "ami_id" {
  default = "ami-0a761e7046802d0a2" # Replace with your AMI ID
}

variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_id" {
  default = "vpc-0eced1a0c6e463c0d"
}

variable "subnet_ids" {
  default = ["subnet-0bf55b0a46cdb6ba7", "subnet-081fe455765966829"]
}

variable "lb_sg_id" {
  default = "sg-0a72d9abf258c4956"
}

variable "public_sg_id" {
  default = "sg-07cb0e6a56c07980e"
}
