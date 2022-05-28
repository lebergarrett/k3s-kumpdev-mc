resource "kubernetes_config_map" "ddns" {
  count = var.enable_ddns == true ? 1 : 0
  metadata {
    name      = "ddns-ddclient-configmap"
    namespace = var.namespace
  }
  data = {
    "ddclient.conf" = file("${path.root}/ddclient.conf")
  }
}

resource "kubernetes_config_map" "whitelist" {
  metadata {
    name      = "whitelist-configmap"
    namespace = var.namespace
  }
  data = {
    "whitelist.json" = file("${path.root}/templates/whitelist.tpl")
  }
}

resource "kubernetes_config_map" "spigot" {
  count = length(var.paper_config) > 0 ? 1 : 0
  metadata {
    name      = "spigot-configmap"
    namespace = var.namespace
  }
  data = {
    "spigot.yml" = templatefile("${path.root}/templates/spigot.tpl", {
      proxy_type = var.proxy_type
    })
  }
}

resource "kubernetes_config_map" "paper" {
  count = length(var.paper_config) > 0 ? 1 : 0
  metadata {
    name      = "paper-configmap"
    namespace = var.namespace
  }
  data = {
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
    namespace = var.namespace
  }
  data = {
    "config.yml" = file("${path.root}/templates/essentials-config.tpl")
  }
}

resource "kubernetes_config_map" "paper_luckperms" {
  for_each = var.paper_config
  metadata {
    name      = "${each.key}-luckperms-configmap"
    namespace = var.namespace
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

resource "kubernetes_config_map" "fabricproxy" {
  count = length(var.fabric_config) > 0 ? 1 : 0
  metadata {
    name      = "fabricproxy-configmap"
    namespace = var.namespace
  }
  data = {
    "FabricProxy.toml" = templatefile("${path.root}/templates/FabricProxy.tpl", {
      forwarding_secret = var.proxy_type == "VELOCITY" ? random_password.velocity_secret[0].result : ""
      proxy_type        = var.proxy_type
    })
  }
}

resource "kubernetes_config_map" "fabricproxy_lite" {
  count = length(var.fabric_config) > 0 ? 1 : 0
  metadata {
    name      = "fabricproxy-lite-configmap"
    namespace = var.namespace
  }
  data = {
    "FabricProxy-Lite.toml" = templatefile("${path.root}/templates/FabricProxy-Lite.tpl", {
      forwarding_secret = var.proxy_type == "VELOCITY" ? random_password.velocity_secret[0].result : ""
      proxy_type        = var.proxy_type
    })
  }
}

resource "random_password" "velocity_secret" {
  count  = local.server_count > 1 && var.proxy_type == "VELOCITY" ? 1 : 0
  length = 16
}

resource "kubernetes_config_map" "velocity_proxy" {
  count = local.server_count > 1 && var.proxy_type == "VELOCITY" ? 1 : 0
  metadata {
    name      = "velocity-proxy-configmap"
    namespace = var.namespace
  }
  data = {
    "velocity.toml" = templatefile("${path.root}/templates/velocity.tpl", {
      forwarding_secret = random_password.velocity_secret[0].result
      proxy_motd        = var.proxy_motd
      servers           = concat([for server, config in var.paper_config : server], [for server, config in var.fabric_config : server], [for server, config in var.curseforge_config : server])
    })
  }
}

resource "kubernetes_config_map" "bungee_waterfall_proxy" {
  count = local.server_count > 1 && var.proxy_type == "WATERFALL" ? 1 : 0
  metadata {
    name      = "bungee-waterfall-proxy-configmap"
    namespace = var.namespace
  }
  data = {
    "config.yml" = templatefile("${path.root}/templates/bungee-waterfall-config.tpl", {
      mc_ops                = var.mc_ops
      proxy_motd            = var.proxy_motd
      proxy_priority_server = var.proxy_priority_server
      servers               = concat([for server, config in var.paper_config : server], [for server, config in var.fabric_config : server], [for server, config in var.curseforge_config : server])
    })
  }
}
