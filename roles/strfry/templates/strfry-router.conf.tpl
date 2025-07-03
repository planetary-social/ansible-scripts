streams {
{% if relay_sync_peers is defined %}
    peer_sync {
        dir = "both"
        urls = [
{% for peer in relay_sync_peers %}
            "{{ peer }}"{{ "," if not loop.last else "" }}
{% endfor %}
        ]
    }
{% endif %}
}
