connection_throttle: 4000
connection_throttle_limit: 3
disabled_commands:
- disabledcommandhere
forge_support: false
groups:
  ${mc_ops}:
  - admin
ip_forward: true
listeners:
- bind_local_address: true
  force_default_server: false
  forced_hosts: null
  host: 0.0.0.0:25577
  max_players: 1
  motd: ${proxy_motd}
  ping_passthrough: false
  priorities:
  - ${proxy_priority_server}
  proxy_protocol: false
  query_enabled: false
  query_port: 25577
  tab_list: GLOBAL_PING
  tab_size: 60
log_commands: false
log_pings: false
network_compression_threshold: 256
online_mode: true
permissions:
  admin:
  - bungeecord.command.alert
  - bungeecord.command.end
  - bungeecord.command.ip
  - bungeecord.command.reload
  default:
  - bungeecord.command.server
  - bungeecord.command.list
player_limit: -1
prevent_proxy_connections: false
remote_ping_cache: -1
remote_ping_timeout: 5000
server_connect_timeout: 5000
servers:
%{ for server in servers ~}
  ${server}:
    address: ${server}:25565
%{ endfor ~}
stats: 19659f49-ed6b-47e3-8b81-63bd14ade63a
timeout: 30000