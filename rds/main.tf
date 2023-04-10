resource "aws_security_group" "db_sg" {
  description = "security group for the private db"

  name_prefix = "${var.env}-${var.project}-db-sg"
  vpc_id      = var.vpc_id
  ingress {
        from_port = var.db_port
        to_port = var.db_port
        protocol = "tcp"
        security_groups = [var.security_groups]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

  tags = merge(
    {
      "Name" = format("%s", "${var.env}-${var.project}-db-sg")
    },
    {
      "Environment" = format("%s", var.env)
    },
  )
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = var.subnet_id

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "medium-pg" {
  allocated_storage        = 20 # gigabytes
  backup_retention_period  = 0   # in days
  engine                   = "postgres"
  engine_version           = "12.9"
  db_subnet_group_name = aws_db_subnet_group.default.name
  identifier               = "${var.project}-${var.env}-pg"
  instance_class           = "db.t2.micro"
  db_name                     = "akmaral"
  password                 = "${var.database_master_password}"
  port                     = var.db_port
  publicly_accessible      = false
#   storage_encrypted        = "${var.storage_encrypted}"
  storage_type             = "gp2"
  username                 = "${var.database_master_user}"
  vpc_security_group_ids   = [aws_security_group.db_sg.id]
  skip_final_snapshot      = true
}
