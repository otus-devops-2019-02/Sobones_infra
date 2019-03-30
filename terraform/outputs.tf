output "app_external_ip" {
  value = "${google_compute_instance.app.*.network_interface.0.access_config.0.nat_ip}"
}

#output "lb_external_ip" {
#  value = "${google_compute_forwarding_rule.puma_forwarding_rule.primary.attributes.ip_address}"
#}

output "lb_external_ip" {
  value = "${google_compute_forwarding_rule.puma_forwarding_rule.ip_address}"
}
