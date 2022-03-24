
variable "launch_az" {
  description = "Availability zones for Launch Configuration"
  type = list(string)
  default     = ["eu-west-1"]
}



variable "instance_ami" {
    description = "EC2 Instance AMI ID"
    default = "ami-08ca3fed11864d6bb"
}
variable "instance_type" {
    default = "t2.micro"
}






variable "lb_name" {   
    default = "Test"
}
variable "security_group_id" {  
    default = "sg-0fb16386f5ba98e52"
}
variable "subnet_id" { 
    default = "subnet-030063870047c1671"  
}
variable "aws_lb_target_group_name" {   
    default = "tf-example-lb-tg"
}
variable "vpc_id"{
    default = "vpc-086494f1d711d68c6"
}

variable "eks_name" {
    default = "Example"
    type = string
}
variable "iam_role" {
    default = "arn:aws:iam::360305708524:role/LmbdaTest"
}
