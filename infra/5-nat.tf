resource "aws_eip" "nat" {
  tags = {
    Name = "${local.name_prefix}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_us_east_1a.id

  tags = {
    Name = "${local.name_prefix}-nat"
  }

  depends_on = [aws_internet_gateway.igw]
}
