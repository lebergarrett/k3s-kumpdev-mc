namespace = "prod-mc"

enable_ddns = true

# Proxy Configuration
proxy_type            = "VELOCITY"
proxy_motd            = "&2Kumpdev &l&7is a server network powered by Kubernetes!"
proxy_priority_server = "fabric"

# General Minecraft Vars
mc_version = "1.18.1"
mc_ops     = "Kumpy,Fett32"
image_tag  = "1.18"

paper_config = {
  creative = {
    DIFFICULTY       = "peaceful"
    FORCE_GAMEMODE   = "true"
    LEVEL            = "CreativeWorld"
    MAX_WORLD_SIZE   = "1000"
    MEMORY           = "1G"
    MODE             = "creative"
    ONLINE_MODE      = "false"
    PVP              = "false"
    SERVER_NAME      = "creative"
    SPAWN_PROTECTION = "0"
  }
}

fabric_config = {
  fabric = {
    DIFFICULTY = "hard"
    LEVEL      = "1_11 Kumpback"
    # World size is a radius
    # Pre 1.17 world size was 15000, 
    # 1.17 was 15500
    # 1.18 is 18000
    MAX_WORLD_SIZE   = "18000"
    MEMORY           = "4G"
    ONLINE_MODE      = "false"
    PVP              = "true"
    SPAWN_PROTECTION = "0"
    VIEW_DISTANCE    = "10"
  }
  fabric-creative = {
    DIFFICULTY       = "peaceful"
    FORCE_GAMEMODE   = "true"
    LEVEL            = "CreativeWorld"
    LEVEL_TYPE       = "FLAT"
    MAX_WORLD_SIZE   = "1000"
    MEMORY           = "1G"
    MODE             = "creative"
    ONLINE_MODE      = "false"
    PVP              = "false"
    SPAWN_PROTECTION = "0"
  }
}

curseforge_config = {}
