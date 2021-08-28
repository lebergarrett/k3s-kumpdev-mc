resource "kubernetes_config_map" "whitelist" {
  metadata {
    name      = "whitelist-configmap"
    namespace = var.server_name
  }
  data = {
    "whitelist.json" = file("${path.root}/templates/whitelist.tpl")
  }
}


resource "kubernetes_config_map" "paper_config" {
  count = length(var.paper_config) > 0 ? 1 : 0
  metadata {
    name      = "paper-configmap"
    namespace = var.server_name
  }
  data = {
    "spigot.yml" = templatefile("${path.root}/templates/spigot.tpl", {
      proxy_type = var.proxy_type
    })
    "paper.yml" = templatefile("${path.root}/templates/paper.tpl", {
      forwarding_secret = var.proxy_type == "VELOCITY" ? random_password.velocity_secret[0].result : ""
      proxy_type        = var.proxy_type
    })
  }
}

resource "kubernetes_config_map" "paper_essentials" {
  count = length(var.paper_config) > 0 ? 1 : 0
  metadata {
    name      = "paper-essentials-configmap"
    namespace = var.server_name
  }
  data = {
    "config.yml" = file("${path.root}/templates/essentials-config.tpl")
  }
}

resource "kubernetes_config_map" "paper_luckperms" {
  for_each = var.paper_config
  metadata {
    name      = "${each.key}-luckperms-configmap"
    namespace = var.server_name
  }
  data = {
    "config.yml" = templatefile("${path.root}/templates/luckperms-paper-config.tpl", {
      server          = each.key
      mariadb_address = "luckperms-mariadb"
      mariadb_db      = "luckperms"
      mariadb_user    = var.MARIADB_USER
      mariadb_pass    = var.MARIADB_PASS
    })
  }
}

resource "kubernetes_config_map" "fabric_servers" {
  count = length(var.fabric_config) > 0 ? 1 : 0
  metadata {
    name      = "fabric-servers-configmap"
    namespace = var.server_name
  }
  data = {
    "FabricProxy.toml" = templatefile("${path.root}/templates/FabricProxy.tpl", {
      forwarding_secret = var.proxy_type == "VELOCITY" ? random_password.velocity_secret[0].result : ""
      proxy_type        = var.proxy_type
    })
  }
}

# resource "kubernetes_config_map" "ftb_servers" {
#   metadata {
#     name      = "ftb-servers-configmap"
#     namespace = var.server_name
#   }
#   data = {
#     "global.conf" = file("${path.root}/templates/sponge-global.tpl")
#   }
# }

resource "random_password" "velocity_secret" {
  count  = length(merge(var.fabric_config, var.paper_config, var.ftb_config)) > 1 && var.proxy_type == "VELOCITY" ? 1 : 0
  length = 16
}

resource "kubernetes_config_map" "velocity_proxy" {
  count = length(merge(var.fabric_config, var.paper_config, var.ftb_config)) > 1 && var.proxy_type == "VELOCITY" ? 1 : 0
  metadata {
    name      = "velocity-proxy-configmap"
    namespace = var.server_name
  }
  data = {
    "velocity.toml" = templatefile("${path.root}/templates/velocity.tpl", {
      forwarding_secret = random_password.velocity_secret[0].result
      proxy_motd        = var.proxy_motd
      servers           = concat([for server, config in var.paper_config : server], [for server, config in var.fabric_config : server], [for server, config in var.ftb_config : server])
    })
  }
}

resource "kubernetes_config_map" "bungee_waterfall_proxy" {
  count = length(merge(var.fabric_config, var.paper_config, var.ftb_config)) > 1 && var.proxy_type == "WATERFALL" ? 1 : 0
  metadata {
    name      = "bungee-waterfall-proxy-configmap"
    namespace = var.server_name
  }
  data = {
    "config.yml" = templatefile("${path.root}/templates/bungee-waterfall-config.tpl", {
      mc_ops                = var.mc_ops
      proxy_motd            = var.proxy_motd
      proxy_priority_server = var.proxy_priority_server
      servers               = concat([for server, config in var.paper_config : server], [for server, config in var.fabric_config : server], [for server, config in var.ftb_config : server])
    })
  }
}

resource "kubernetes_config_map" "ddns" {
  count = var.enable_ddns == true ? 1 : 0
  metadata {
    name      = "ddns-ddclient-configmap"
    namespace = var.server_name
  }
  data = {
    "ddclient.conf" = file("${path.root}/ddclient.conf")
  }
}