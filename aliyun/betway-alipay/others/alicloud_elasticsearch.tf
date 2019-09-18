resource "alicloud_elasticsearch_instance" "instance" {
  instance_charge_type = "PostPaid"
  data_node_amount     = "2"
  data_node_spec       = "elasticsearch.sn2ne.large"
  data_node_disk_size  = "20"
  data_node_disk_type  = "cloud_ssd"
  vswitch_id           = "${alicloud_vswitch.vsw.id}"
  password             = "!QAZ2wsx#EDC"
  version              = "5.5.3_with_X-Pack"
  description          = "description"
  zone_count           = "2"
}
