resource "aws_subnet" "private-eu-west-1a" {
  vpc_id            = aws_vpc.main.id 
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    "Name"                              = "private-eu-west-1a"
    "kubernetes.io/role/internal-elb"   = "1"
    "kubernetes.io/cluster/stage"        = "owned"
  }
}

resource "aws_subnet" "private-eu-west-1b" {
  vpc_id            = aws_vpc.main.id 
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    "Name"                              = "private-eu-west-1b"
    "kubernetes.io/role/internal-elb"   = "1"
    "kubernetes.io/cluster/stage"        = "owned"
  }
}

resource "aws_subnet" "private-eu-west-1c" {
  vpc_id            = aws_vpc.main.id 
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-1c"

  tags = {
    "Name"                              = "private-eu-west-1c"
    "kubernetes.io/role/internal-elb"   = "1"
    "kubernetes.io/cluster/stage"        = "owned"
  }
}

resource "aws_subnet" "public-eu-west-1a" {
  vpc_id                    = aws_vpc.main.id 
  cidr_block                = "10.0.4.0/24"
  availability_zone         = "eu-west-1a"
  map_public_ip_on_launch   = true

  tags = {
    "Name"                              = "public-eu-west-1a"
    "kubernetes.io/role/internal-elb"   = "1"
    "kubernetes.io/cluster/stage"        = "owned"
  }
}