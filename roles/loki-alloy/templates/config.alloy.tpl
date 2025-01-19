discovery.docker "linux_host" {
  host = "unix:///var/run/docker.sock"
}

loki.source.docker "all_containers" {
  host       = "unix:///var/run/docker.sock"
  targets    = discovery.docker.linux_host.targets
  labels     = {
    "source" = "docker"
    "host" = "{{ inventory_hostname }}"
  }
  forward_to = [loki.write.verse_loki_endpoint.receiver]
}

loki.write "verse_loki_endpoint" {
  endpoint {
    url = "loki.planetary.tools:3100/loki/api/v1/push"
    basic_auth {
        username = "verse"
        password = "{{ loki_password_hashed_escaped }}"
    }
  }
}