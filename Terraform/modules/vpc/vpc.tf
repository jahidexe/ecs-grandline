# ----------------------
# Get Availability Zones
# ----------------------

data "aws_availability_zones" "available" {
  state = "available"
}

# ---------
# AWS VPC
# ---------

resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    {
      Name = "${var.project_name}-vpc"
    },
    var.common_tags
  )
}

# ------------------
# Internet Gateway
# ------------------

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      Name = "${var.project_name}-igw"
    },
    var.common_tags
  )
}

# ------------
# NAT Gateway
# ------------

resource "aws_nat_gateway" "main" {
  connectivity_type = "public"
  allocation_id     = aws_eip.eip_nat.allocation_id
  subnet_id         = aws_subnet.public[0].id

  tags = merge(
    {
      Name = "${var.project_name}-ngw"
    },
    var.common_tags
  )

  depends_on = [aws_internet_gateway.main]
}

# ---------------------------
# Elastic IP For NAT Gateway
# ---------------------------

resource "aws_eip" "eip_nat" {
  domain = "vpc"

  tags = merge(
    {
      Name = "${var.project_name}-eip"
    },
    var.common_tags
  )
}

# ---------------
# Public Subnets
# ---------------

resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    {
      Name = "${var.project_name}-public-subnet-${count.index + 1}"
    },
    var.common_tags
  )
}

# ------------------------------
# Route Table - Public Subnets
# ------------------------------

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.route_table_cidr_block
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    {
      Name = "${var.project_name}-public-rt"
    },
    var.common_tags
  )
}

# ---------------
# Private Subnets
# ---------------

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(
    {
      Name = "${var.project_name}-private-subnet-${count.index + 1}"
    },
    var.common_tags
  )
}


# ------------------------------
# Route Table - Private Subnets
# ------------------------------

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.route_table_cidr_block
    gateway_id = aws_nat_gateway.main.id
  }

  tags = merge(
    {
      Name = "${var.project_name}-private-rt"
    },
    var.common_tags
  )
}

# ------------------------------------------
# Route Table Association - Public Subnets
# ------------------------------------------

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# ------------------------------------------
# Route Table Association - Private Subnets
# ------------------------------------------

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
