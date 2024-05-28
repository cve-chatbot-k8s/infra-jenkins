resource "aws_vpc" "jenkins-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "jenkins-VPC"
  }
}

resource "aws_subnet" "jenkins_subnet" {
  vpc_id     = aws_vpc.jenkins-vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "jenkins-subnet"
  }
}

resource "aws_internet_gateway" "jenkins_igw" {
  vpc_id = aws_vpc.jenkins-vpc.id
  tags = {
    Name = "jenkins-igw"
  }
}

resource "aws_route_table" "jenkins_route_table" {
  vpc_id = aws_vpc.jenkins-vpc.id
  tags = {
    Name = "jenkins-Route_Table"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.jenkins_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.jenkins_igw.id
}

resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.jenkins_subnet.id
  route_table_id = aws_route_table.jenkins_route_table.id
}

resource "aws_security_group" "jenkins_sg" {
  vpc_id = aws_vpc.jenkins-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "jenkins-sg"
  }
}
