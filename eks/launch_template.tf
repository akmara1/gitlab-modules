resource "aws_launch_template" "example" {
  name          = "akmarals"
  instance_type = "t2.medium"

  tags = {
    "environment" = "${var.project}"
  }
}