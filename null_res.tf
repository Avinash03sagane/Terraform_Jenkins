resource "null_resource" "name" {

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/Downloads/AV_AV.pem")
    host        = aws_instance.Jenkins_DEMO.public_ip

  }

  provisioner "file" {
    source      = "user_data1.sh"
    destination = "/tmp/user_data1.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/user_data1.sh",
      "sh /tmp/user_data1.sh",
    ]
  }

  
  depends_on = [aws_volume_attachment.ebs_att]
}

output "websiteURL" {
  value = join("", ["http://", aws_instance.Jenkins_DEMO.public_ip, ":", "8080"])
}