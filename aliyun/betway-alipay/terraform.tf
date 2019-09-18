provider "alicloud" {}

resource "alicloud_vpc" "vpc" {
  name       = "betway-alipay"
  cidr_block = "10.14.0.0/16"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "10.14.0.0/24"
  availability_zone = "cn-shanghai-c"
}

resource "alicloud_security_group" "default" {
  name = "sg-betway-alipay"
  vpc_id = "${alicloud_vpc.vpc.id}"
}


resource "alicloud_security_group_rule" "allow_all_tcp_from_office" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "1/65535"
  priority          = 1
  security_group_id = "${alicloud_security_group.default.id}"
  cidr_ip           = "202.39.9.79/32"
}

resource "alicloud_security_group_rule" "allow_all_from_zabbix" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "10050/10051"
  priority          = 1
  security_group_id = "${alicloud_security_group.default.id}"
  cidr_ip           = "0.0.0.0/0"
}

module "tf-instances" {
  source = "alibaba/ecs-instance/alicloud"
  vswitch_id = "${alicloud_vswitch.vsw.id}"
  group_ids = ["${alicloud_security_group.default.*.id}"]
  availability_zone = "cn-shanghai-c"
  disk_category = "cloud_ssd"
  disk_name = "my_module_disk"
  disk_size = "100"
  number_of_disks = 1

  image_id = "m-uf6b1y67msdaa8txvsyi"
  instance_type = "ecs.n4.xlarge"
  instance_name = "betway-alipay-service"
  host_name = "betway-alipay"
  internet_charge_type = "PayByTraffic"
  number_of_instances = "2"
  password="!QAZ2wsx#EDC"

  image_id = "m-uf6b1y67msdaa8txvsyi"
  instance_type = "ecs.n4.xlarge"
  instance_name = "betway-alipay-logstash"
  host_name = "betway-alipay-logstash"
  internet_charge_type = "PayByTraffic"
  number_of_instances = "2"
  password="!QAZ2wsx#EDC"
}

