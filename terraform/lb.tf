resource "google_compute_http_health_check" "port9292healthcheck" {
  name               = "port9292healthcheck"
  port               = "9292"
  timeout_sec        = 1
  check_interval_sec = 1
}

resource "google_compute_target_pool" "puma_pool" {
  name = "puma"

  instances = [
    "${google_compute_instance.app.*.self_link}",
  ]

  health_checks = [
    "${google_compute_http_health_check.port9292healthcheck.name}",
  ]
}

resource "google_compute_forwarding_rule" "puma_forwarding_rule" {
  name = "puma-forwarding-rule"

  target = "${google_compute_target_pool.puma_pool.self_link}"

  port_range = "9292"
}
