
resource "aws_instance" "Jenkins_DEMO" {
  ami                         = "ami-06f855639265b5541"
  instance_type               = "t2.medium"
  availability_zone           = "ap-south-1a"
  vpc_security_group_ids      = [aws_security_group.dynamicsg.id]
  associate_public_ip_address = "true"
  key_name                    = "AV_AV"

  tags = {
    Name = "Jenkins_DEMO"
  }

}

resource "aws_ebs_volume" "JK_home" {
  availability_zone = "ap-south-1a"
  size              = 10
  depends_on        = [aws_instance.Jenkins_DEMO]
  
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.JK_home.id
  instance_id = aws_instance.Jenkins_DEMO.id
}



