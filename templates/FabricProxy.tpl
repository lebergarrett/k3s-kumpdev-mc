BungeeCord = ${proxy_type == "WATERFALL" || proxy_type == "BUNGEECORD" ? true : false}
Velocity = ${proxy_type == "VELOCITY" ? true : false}
secret = "${proxy_type == "VELOCITY" ? forwarding_secret : ""}"