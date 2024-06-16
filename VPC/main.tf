# Resource-1: Create VPC
resource "aws_vpc" "myvpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "myvpc"
  }
}

# Resource-2: Create public Subnet 1
resource "aws_subnet" "my-public-subnet-1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  #any EC2 instances launched in these subnets will automatically receive a public IP address
  map_public_ip_on_launch = true
  tags = {
    "Name" = "my-public-subnet-1"
  }
}

# Resource-3: Create public Subnet 2
resource "aws_subnet" "my-public-subnet-2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-west-2b"
  #any EC2 instances launched in these subnets will automatically receive a public IP address
  map_public_ip_on_launch = true
  tags = {
    "Name" = "my-public-subnet-2"
  }
}

# Resource-4: Internet Gateway
resource "aws_internet_gateway" "myIGW" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    "Name" = "myIGW"
  }
}

# Resource-5: Create Route Table for public subnets
resource "aws_route_table" "my-public-RT" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    "Name" = "my-public-RT"
  }
}

# Resource-6: Create Route in public Route Table for Internet Access
resource "aws_route" "vpc-public-route" {
  route_table_id         = aws_route_table.my-public-RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myIGW.id
}

# Resource-7: Associate the public Route Table with public Subnet 1
resource "aws_route_table_association" "vpc-public-route-table-associate-1" {
  route_table_id = aws_route_table.my-public-RT.id
  subnet_id      = aws_subnet.my-public-subnet-1.id
}

# Resource-8: Associate the public Route Table with public Subnet 2
resource "aws_route_table_association" "vpc-public-route-table-associate-2" {
  route_table_id = aws_route_table.my-public-RT.id
  subnet_id      = aws_subnet.my-public-subnet-2.id
}
