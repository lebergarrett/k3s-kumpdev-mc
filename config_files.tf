resource "kubernetes_config_map" "paper_config" {
  metadata {
    name      = "paper-configmap"
    namespace = var.server_name
  }
  data = {
    "spigot.yml" = file("${path.root}/templates/spigot.tpl")
  }
}

resource "kubernetes_config_map" "paper_essentials" {
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
  metadata {
    name      = "fabric-servers-configmap"
    namespace = var.server_name
  }
  data = {
    "FabricProxy.toml" = file("${path.root}/templates/FabricProxy.tpl")
  }
}

resource "kubernetes_config_map" "waterfall_proxy" {
  metadata {
    name      = "waterfall-proxy-configmap"
    namespace = var.server_name
  }
  data = {
    "config.yml" = templatefile("${path.root}/templates/waterfall-config.tpl", {
      mc_ops                = var.mc_ops
      proxy_motd            = var.proxy_motd
      proxy_priority_server = var.proxy_priority_server
      servers               = concat([for server, config in var.paper_config : server], [for server, config in var.fabric_config : server])
    })
  }
}

resource "kubernetes_config_map" "ddns" {
  metadata {
    name      = "ddns-ddclient-configmap"
    namespace = var.server_name
  }
  data = {
    "ddclient.conf" = file("${path.root}/ddclient.conf")
  }
}