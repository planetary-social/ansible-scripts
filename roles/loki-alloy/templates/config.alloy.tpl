discovery.docker "linux_host" {
  host = "unix:///var/run/docker.sock"
}

discovery.relabel "logs_integrations_docker" {
            targets = []


            rule {
                target_label = "job"
                replacement = "integrations/docker"
            }


            rule {
                target_label = "instance"
                replacement = constants.hostname
            }


            rule {
                source_labels = ["__meta_docker_container_name"]
                regex = "/(.*)"
                target_label = "container"
            }


            rule {
                source_labels = ["__meta_docker_container_log_stream"]
                target_label = "stream"
            }
}

loki.source.docker "all_containers" {
  host = "unix:///var/run/docker.sock"
  targets = discovery.docker.linux_host.targets
  relabel_rules = discovery.relabel.logs_integrations_docker.rules
  refresh_interval = "5s"
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