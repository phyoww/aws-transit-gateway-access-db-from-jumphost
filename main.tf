#############################################################################################################################
# Create VPC1,Public Subnet,Internet Gateway,Route Table, RT association, default route to internet, route to transit gateway
##############################################################################################################################
#VPC1
resource "aws_vpc" "vpc1" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "cloudideastar-vpc1"

  }
}

# Configuration section for internet gateway
resource "aws_internet_gateway" "internet_gateway1" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "IGW1"
  }
}

# Subnet1
resource "aws_subnet" "public_subnet1" {

  cidr_block = "10.1.0.0/24"
  vpc_id     = aws_vpc.vpc1.id
  tags = {
    Name = "public-subnet-1"
  }
}

# Configuration section for route table public subnet
resource "aws_route_table" "public_subnet1" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    "Name" = "public-rt1"
  }

}

# Create route table public subnet association
resource "aws_route_table_association" "public_subnet_association1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_subnet1.id
}


# Configuration section for default route to internet from public subnet
resource "aws_route" "default_route_public_subnet1" {
  route_table_id         = aws_route_table.public_subnet1.id
  destination_cidr_block = var.default_route
  gateway_id             = aws_internet_gateway.internet_gateway1.id
}


# Create route to transist gateway in route table 
resource "aws_route" "tgw-route-1" {
  route_table_id         = aws_route_table.public_subnet1.id
  destination_cidr_block = "10.2.0.0/16"
  transit_gateway_id     = aws_ec2_transit_gateway.cloudideastar-tgw.id
  depends_on = [
    aws_ec2_transit_gateway.cloudideastar-tgw
  ]
}

# Create route to transist gateway in route table 
resource "aws_route" "tgw-route-11" {
  route_table_id         = aws_route_table.public_subnet1.id
  destination_cidr_block = "172.16.0.0/16"
  transit_gateway_id     = aws_ec2_transit_gateway.cloudideastar-tgw.id
  depends_on = [
    aws_ec2_transit_gateway.cloudideastar-tgw
  ]
}

#############################################################################################################################
# Create VPC2,Public Subnet,Internet Gateway,Route Table, RT association, default route to internet, route to transit gateway
##############################################################################################################################
#VPC2
resource "aws_vpc" "vpc2" {
  cidr_block = "10.2.0.0/16"
  tags = {
    Name = "cloudideastar-vpc2"

  }
}

# Configuration section for internet gateway
resource "aws_internet_gateway" "internet_gateway2" {
  vpc_id = aws_vpc.vpc2.id

  tags = {
    Name = "IGW2"
  }
}

# Subnet1
resource "aws_subnet" "public_subnet2" {

  cidr_block = "10.2.0.0/24"
  vpc_id     = aws_vpc.vpc2.id
  tags = {
    Name = "public-subnet-2"
  }
}

# Configuration section for route table public subnet
resource "aws_route_table" "public_subnet2" {
  vpc_id = aws_vpc.vpc2.id
  tags = {
    "Name" = "public-rt2"
  }

}

# Create route table public subnet association
resource "aws_route_table_association" "public_subnet_association2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_subnet2.id
}


# Configuration section for default route to internet from public subnet
resource "aws_route" "default_route_public_subnet2" {
  route_table_id         = aws_route_table.public_subnet2.id
  destination_cidr_block = var.default_route
  gateway_id             = aws_internet_gateway.internet_gateway2.id
}


# Create route to transist gateway in route table 
resource "aws_route" "tgw-route-2" {
  route_table_id         = aws_route_table.public_subnet2.id
  destination_cidr_block = "10.1.0.0/16"
  transit_gateway_id     = aws_ec2_transit_gateway.cloudideastar-tgw.id
  depends_on = [
    aws_ec2_transit_gateway.cloudideastar-tgw
  ]
}

# Create route to transist gateway in route table 
resource "aws_route" "tgw-route-22" {
  route_table_id         = aws_route_table.public_subnet2.id
  destination_cidr_block = "172.16.0.0/16"
  transit_gateway_id     = aws_ec2_transit_gateway.cloudideastar-tgw.id
  depends_on = [
    aws_ec2_transit_gateway.cloudideastar-tgw
  ]
}


#############################################################################################################################
# Create VPC3,Public Subnet,Internet Gateway,Route Table, RT association, default route to internet, route to transit gateway
##############################################################################################################################

#VPC3
resource "aws_vpc" "vpc3" {
  cidr_block = "172.16.0.0/16"
  tags = {
    Name = "cloudideastar-vpc3"
  }
}

# Configuration section for internet gateway
resource "aws_internet_gateway" "internet_gateway3" {
  vpc_id = aws_vpc.vpc3.id

  tags = {
    Name = "IGW3"
  }
}

# public subnet3
resource "aws_subnet" "public_subnet3" {
  cidr_block = "172.16.0.0/24"
  vpc_id     = aws_vpc.vpc3.id
  tags = {
    Name = "public-subnet-3"
  }
}

# private subnet1
resource "aws_subnet" "private_subnet1" {
  cidr_block = "172.16.1.0/24"
  vpc_id     = aws_vpc.vpc3.id
  tags = {
    Name = "private-subnet-1"
  }
}


# Configuration section for route table public subnet3
resource "aws_route_table" "public_subnet3" {
  vpc_id = aws_vpc.vpc3.id
  tags = {
    "Name" = "public-rt3"
  }

}

# Configuration section for route table private subnet1
resource "aws_route_table" "private_subnet1" {
  vpc_id = aws_vpc.vpc3.id
  tags = {
    "Name" = "private-rt1"
  }

}

# Create route table public subnet association
resource "aws_route_table_association" "public_subnet_association3" {
  subnet_id      = aws_subnet.public_subnet3.id
  route_table_id = aws_route_table.public_subnet3.id
}

# Create route table private subnet association
resource "aws_route_table_association" "private_subnet_association1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_subnet1.id
}


# Configuration section for default route to internet from public subnet
resource "aws_route" "default_route_public_subnet3" {
  route_table_id         = aws_route_table.public_subnet3.id
  destination_cidr_block = var.default_route
  gateway_id             = aws_internet_gateway.internet_gateway3.id
}

# Create route to transist gateway in route table
resource "aws_route" "tgw-route-3" {

  route_table_id         = aws_route_table.public_subnet3.id
  destination_cidr_block = "10.1.0.0/16"
  transit_gateway_id     = aws_ec2_transit_gateway.cloudideastar-tgw.id
  depends_on = [
    aws_ec2_transit_gateway.cloudideastar-tgw
  ]
}

# Create route to transist gateway in route table
resource "aws_route" "tgw-route-33" {

  route_table_id         = aws_route_table.public_subnet3.id
  destination_cidr_block = "10.2.0.0/16"
  transit_gateway_id     = aws_ec2_transit_gateway.cloudideastar-tgw.id
  depends_on = [
    aws_ec2_transit_gateway.cloudideastar-tgw
  ]
}

# Create route to transist gateway in route table
resource "aws_route" "tgw-route-4" {

  route_table_id         = aws_route_table.private_subnet1.id
  destination_cidr_block = "10.1.0.0/16"
  transit_gateway_id     = aws_ec2_transit_gateway.cloudideastar-tgw.id
  depends_on = [
    aws_ec2_transit_gateway.cloudideastar-tgw
  ]
}
# Create route to transist gateway in route table
resource "aws_route" "tgw-route-44" {

  route_table_id         = aws_route_table.private_subnet1.id
  destination_cidr_block = "10.2.0.0/16"
  transit_gateway_id     = aws_ec2_transit_gateway.cloudideastar-tgw.id
  depends_on = [
    aws_ec2_transit_gateway.cloudideastar-tgw
  ]
}

# Create route to transist gateway in route table toward VPC1 internet
resource "aws_route" "tgw-route-444" {

  route_table_id         = aws_route_table.private_subnet1.id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = aws_ec2_transit_gateway.cloudideastar-tgw.id
  depends_on = [
    aws_ec2_transit_gateway.cloudideastar-tgw
  ]
}

#############################################################################################################################
# Create Tgw, VPC attachment
##############################################################################################################################

# create tgw in AWS Network Account 
resource "aws_ec2_transit_gateway" "cloudideastar-tgw" {

  description                     = "Transit Gateway testing scenario with 2 VPCs, subnets each"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  tags = {
    Name        = "cloudideastar-tgw"
    environment = "prd"
  }
}


## Attachement of VPC1 from AWS production Account

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc1-attachment" {

  subnet_ids         = [aws_subnet.public_subnet1.id]
  transit_gateway_id = aws_ec2_transit_gateway.cloudideastar-tgw.id
  vpc_id             = aws_vpc.vpc1.id
  tags = {
    "Name" = "transit-gateway-attachment1"
  }
}

## Attachement of VPC2 from AWS production Account
resource "aws_ec2_transit_gateway_vpc_attachment" "vpc2-attachment" {

  subnet_ids         = [aws_subnet.public_subnet2.id]
  transit_gateway_id = aws_ec2_transit_gateway.cloudideastar-tgw.id
  vpc_id             = aws_vpc.vpc2.id
  tags = {
    "Name" = "transit-gateway-attachment2"
  }
}

## Attachement of VPC3 from AWS production Account
resource "aws_ec2_transit_gateway_vpc_attachment" "vpc3-attachment" {

  subnet_ids         = [aws_subnet.public_subnet3.id,aws_subnet.private_subnet1.id]
  transit_gateway_id = aws_ec2_transit_gateway.cloudideastar-tgw.id
  vpc_id             = aws_vpc.vpc3.id
  tags = {
    "Name" = "transit-gateway-attachment3"
  }
}


## Static Route on TGW route table
resource "aws_ec2_transit_gateway_route" "vpc1" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpc1-attachment.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.cloudideastar-tgw.association_default_route_table_id
}

#############################################################################################################################
# Create security Groups with ingress and egress rules
##############################################################################################################################

# Create SG1

resource "aws_security_group" "sg1" {
  name        = "sg1"
  description = "allow ssh from internet and icmp from 10.2.0.0/24"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8 # the ICMP type number for 'Echo'
    to_port     = 0 # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["10.2.0.0/24"]
  }

  ingress {
    from_port   = 8 # the ICMP type number for 'Echo'
    to_port     = 0 # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["172.16.0.0/24"]
  }  
  ingress {
    from_port   = 8 # the ICMP type number for 'Echo'
    to_port     = 0 # the ICMP code
    protocol    = "tcp"
    cidr_blocks = ["172.16.1.0/24"]
  }    

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "sg1"

  }
}

# Create SG2


resource "aws_security_group" "sg2" {
  name        = "sg2"
  description = "allow ssh from internet and icmp from 10.1.0.0/24"
  vpc_id      = aws_vpc.vpc2.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8 # the ICMP type number for 'Echo'v
    to_port     = 0 # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["10.1.0.0/24"]
  }
  ingress {
    from_port   = 8 # the ICMP type number for 'Echo'v
    to_port     = 0 # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["172.16.0.0/24"]
  }    
  ingress {
    from_port   = 8 # the ICMP type number for 'Echo'v
    to_port     = 0 # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["172.16.1.0/24"]
  }  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg2"

  }
}

# Create SG3


resource "aws_security_group" "sg3" {
  name        = "sg3"
  description = "allow ssh from internet and icmp from 10.1.0.0/24"
  vpc_id      = aws_vpc.vpc3.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8 # the ICMP type number for 'Echo'v
    to_port     = 0 # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["10.1.0.0/24"]
  }
  ingress {
    from_port   = 8 # the ICMP type number for 'Echo'v
    to_port     = 0 # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["10.2.0.0/24"]
  }  
  ingress {
    from_port   = 8 # the ICMP type number for 'Echo'v
    to_port     = 0 # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["172.16.0.0/16"]
  }    
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg3"

  }
}


#############################################################################################################################
# Create four vms in each VPCs
##############################################################################################################################

resource "aws_instance" "Cloudideastar-Svr1" {
  ami                         = "ami-03e312c9b09e29831"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public_subnet1.id
  vpc_security_group_ids      = [aws_security_group.sg1.id]
  key_name                    = aws_key_pair.cloudideastar-keypair.key_name

  tags = {
    Name = "Cloudideastar-Svr1"

  }

}


resource "aws_instance" "Cloudideastar-Svr2" {
  ami                         = "ami-03e312c9b09e29831"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public_subnet2.id
  vpc_security_group_ids      = [aws_security_group.sg2.id]
  key_name                    = aws_key_pair.cloudideastar-keypair.key_name

  tags = {
    Name = "Cloudideastar-Svr2"

  }

}

resource "aws_instance" "Cloudideastar-Svr3" {
  ami                         = "ami-03e312c9b09e29831"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public_subnet3.id
  vpc_security_group_ids      = [aws_security_group.sg3.id]
  key_name                    = aws_key_pair.cloudideastar-keypair.key_name

  tags = {
    Name = "Cloudideastar-Svr3"

  }

}

resource "aws_instance" "Cloudideastar-PrivateSvr1" {
  ami                         = "ami-03e312c9b09e29831"
  instance_type               = "t2.micro"
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.private_subnet1.id
  vpc_security_group_ids      = [aws_security_group.sg3.id]
  key_name                    = aws_key_pair.cloudideastar-keypair.key_name

  tags = {
    Name = "Cloudideastar-PrivateSvr1"

  }

}

#############################################################################################################################
# Create SSH key pair
##############################################################################################################################

##Key Pair

resource "aws_key_pair" "cloudideastar-keypair" {
  key_name   = "cloudideastar-keypair"
  public_key = "keypari AsvzlN0VG local" # put your (public key) here
}
