resource "kubernetes_config_map" "whitelist" {
  metadata {
    name      = "whitelist-configmap"
    namespace = var.server_name
  }
  data = {
    "whitelist.json" = file("${path.root}/templates/whitelist.json")
  }
}


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

resource "kubernetes_config_map" "ftb_servers" {
  metadata {
    name      = "ftb-servers-configmap"
    namespace = var.server_name
  }
  data = {
    "global.conf" = file("${path.root}/templates/sponge-global.tpl")
  }
}

resource "kubernetes_config_map" "velocity_proxy" {
  metadata {
    name      = "velocity-proxy-configmap"
    namespace = var.server_name
  }
  data = {
    "velocity.toml" = templatefile("${path.root}/templates/velocity.tpl", {
      proxy_motd = var.proxy_motd
      servers    = concat([for server, config in var.paper_config : server], [for server, config in var.fabric_config : server], [for server, config in var.ftb_config : server])
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