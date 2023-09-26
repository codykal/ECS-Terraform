resource "aws_db_instance" "MySQL-Instance" {
    db_name = "rds-mysql"
    instance_class = "db.t2.micro"
    engine = "mysql"
    engine_version = "8.0.27"
  
}