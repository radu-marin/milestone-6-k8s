# <======================   EBS   ======================>
resource "aws_ebs_volume" "ebs" {
  availability_zone = "${var.ebs_az}"
  size = var.ebs_size
  encrypted = true

  tags = {
    Name = "${var.naming}-${var.environment}-ebs"
    Owner = "${var.owner}"
  }
}