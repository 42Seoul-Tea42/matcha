# EC2 인스턴스의 공개 IP 출력
output "ec2_public_ip" {
  value = aws_eip.matcha_prod_eip.public_ip
}