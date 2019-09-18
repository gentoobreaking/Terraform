variable "name" {
  default = "terraformtestslbconfig"
}
data "alicloud_zones" "default" {
    available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "default" {
  name = "${var.name}"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "default" {
  vpc_id = "${alicloud_vpc.default.id}"
  cidr_block = "172.16.0.0/21"
  availability_zone = "${data.alicloud_zones.default.zones.0.id}"
  name = "${var.name}"
}

resource "alicloud_slb" "default" {
  name = "${var.name}"
  specification = "slb.s2.small"
  vswitch_id = "${alicloud_vswitch.default.id}"
  tags = {
    tag_a = 1
    tag_b = 2
    tag_c = 3
    tag_d = 4
    tag_e = 5
    tag_f = 6
    tag_g = 7
    tag_h = 8
    tag_i = 9
    tag_j = 10
  }
}

