data "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = "arn:aws:secretsmanager:us-west-2:913087840426:secret:ECSProject-RDSSecret-SIdslx"
}


resource "aws_db_instance" "MySQL-Instance" {
  allocated_storage    = 20
  db_name              = "rds-mysql"
  instance_class       = "db.t2.micro"
  engine               = "mysql"
  engine_version       = "8.0.33"
  username             = jsondecode(data.aws_secretsmanager_secret_version.db_credentials.secret_string)["username"]
  password             = jsondecode(data.aws_secretsmanager_secret_version.db_credentials.secret_string)["password"]
  db_subnet_group_name = "aws_db_subnet_group.privategroup"
  skip_final_snapshot  = true
  availability_zone    = "us-west-2a"

  // Disable Automated Backups
  backup_retention_period = 0

}