resource "aws_security_group" "instance_sg" {
  name        = "instance_sg"
  description = "open 80 and 22 to my IP"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["76.145.11.0/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_instance" "prod_instance" {
  count                  = 2                     #set the desired count here
  ami                    = var.LINUX[var.region] # Replace with your desired AMI ID  #CHANGED
  instance_type          = "t2.micro"
  key_name               = var.KEY[var.region] #CHANGED
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  tags = {
    Name = "production"
  }

  user_data = <<-EOF
#!/bin/bash
# Use this for your user data (script from top to bottom)
# install httpd (Linux 2 version)
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
EOF

}


resource "aws_instance" "dev_instance" {
  count                  = 2                     #set the desired count here
  ami                    = var.LINUX[var.region] # Replace with your desired AMI ID  #CHANGED
  instance_type          = "t2.micro"
  key_name               = var.KEY[var.region] #CHANGED
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  tags = {
    Name = "development"
  }

  user_data = <<-EOF
    #!/bin/bash
    IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
    echo "<html><body style='background-color:lightpurple'><center><h1>Hello World from $IP</h1></center></body></html>" > index.html
    nohup python -m SimpleHTTPServer 80 &
EOF

}



