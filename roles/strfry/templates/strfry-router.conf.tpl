streams {
{% if relay_sync_peers is defined %}
    peer_sync {
        dir = "both"
        urls = [
{% for peer in relay_sync_peers %}
            "ws://{{ peer }}:7777"{{ "," if not loop.last else "" }}
{% endfor %}
        ]
    }
{% endif %}
}
