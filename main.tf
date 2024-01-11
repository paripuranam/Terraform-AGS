provider "aws" {
  region = "us-east-1"

}

resource "aws_launch_configuration" "example" {
  image_id        = "ami-0005e0cfe09cc9050"
  instance_type   = "t2.micro"
  security_groups = ["sg-0ca19ef8a652cf338"]
  
  user_data = "${file("userdata.sh")}"
}
data "aws_vpc" "default" {
  default = true
}
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
resource "aws_autoscaling_group" "Demo_asg" {
  launch_configuration = aws_launch_configuration.example.name
  vpc_zone_identifier  = data.aws_subnets.default.ids
  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}

