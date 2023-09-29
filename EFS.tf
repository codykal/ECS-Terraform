resource "aws_efs_file_system" "EFS-Filesystem" {
  creation_token = "metabase-volume"

  availability_zone_name = "us-west-2a"

  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
}

resource "aws_efs_mount_target" "EFS-MountTarget" {
  file_system_id = aws_efs_file_system.EFS-Filesystem.id
  subnet_id      = aws_subnet.public1.id
}