discovery.docker "docker_containers" {
    host = "unix:///var/run/docker.sock"
}

discovery.relabel "docker_containers" {
    targets = discovery.docker.docker_containers.targets

    rule {
        source_labels = ["__meta_docker_container_name"]
        target_label  = "container"
    }
}

loki.source.docker "docker_logs" {
    host    = "unix:///var/run/docker.sock"
    targets = discovery.relabel.docker_containers.output
    forward_to = [loki.process.process_logs.receiver]
}

loki.process "process_logs" {
    stage.docker { }
    stage.static_labels {
      values = {
        hostname = "{{ inventory_hostname }}",
      }
    }
    forward_to = [loki.write.verse_loki_endpoint.receiver]
}

loki.write "verse_loki_endpoint" {
  endpoint {
    url = "https://loki.planetary.tools/loki/api/v1/push"
    basic_auth {
        username = "{{ vault_traefik_user }}"
        password = "{{ vault_traefik_password | password_hash(hashtype='md5') }}"
    }
  }
}