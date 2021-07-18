server_name = "dev-mc-kumpdev"

# Waterfall Proxy Configuration
proxy_motd            = "DEV &2Kumpdev &l&7is a server network powered by Kubernetes!"
proxy_priority_server = "lobby"

# Minecraft Vars
mc_connection_port = "25565"
mc_version         = "1.16.5"
mc_ops             = "Kumpy,Fett32"

paper_config = {
  lobby = {
    SERVER_NAME                = "lobby"
    OVERRIDE_SERVER_PROPERTIES = "true"
    EULA                       = "true"
    ONLINE_MODE                = "false"
    MEMORY                     = "512M"
    USE_AIKAR_FLAGS            = "true"
    DIFFICULTY                 = "peaceful"
    PVP                        = "false"
    LEVEL                      = "LobbyWorld"
    SPAWN_PROTECTION           = "0"
    MAX_WORLD_SIZE             = "100"
    ENFORCE_WHITELIST          = "true"
    PLUGINS_SYNC_UPDATE        = "false"
  }
  creative = {
    OVERRIDE_SERVER_PROPERTIES = "true"
    EULA                       = "true"
    ONLINE_MODE                = "false"
    MEMORY                     = "1G"
    USE_AIKAR_FLAGS            = "true"
    DIFFICULTY                 = "peaceful"
    PVP                        = "false"
    LEVEL                      = "CreativeWorld"
    SPAWN_PROTECTION           = "0"
    MAX_WORLD_SIZE             = "1000"
    FORCE_GAMEMODE             = "true"
    MODE                       = "creative"
    ENFORCE_WHITELIST          = "true"
    PLUGINS_SYNC_UPDATE        = "false"
  }
}

fabric_config = {
  fabric = {
    OVERRIDE_SERVER_PROPERTIES = "true"
    EULA                       = "true"
    ONLINE_MODE                = "false"
    MEMORY                     = "4G"
    USE_AIKAR_FLAGS            = "true"
    DIFFICULTY                 = "hard"
    PVP                        = "true"
    LEVEL                      = "1_11 Kumpback"
    SPAWN_PROTECTION           = "0"
    VIEW_DISTANCE              = "18"
    MAX_WORLD_SIZE             = "15000"
    ENFORCE_WHITELIST          = "true"
    REMOVE_OLD_MODS            = "true"
    PLUGINS_SYNC_UPDATE        = "false"
  }
  fabric-creative = {
    OVERRIDE_SERVER_PROPERTIES = "true"
    EULA                       = "true"
    ONLINE_MODE                = "false"
    MEMORY                     = "1G"
    USE_AIKAR_FLAGS            = "true"
    DIFFICULTY                 = "peaceful"
    PVP                        = "false"
    LEVEL                      = "CreativeWorld"
    LEVEL_TYPE                 = "FLAT"
    SPAWN_PROTECTION           = "0"
    MAX_WORLD_SIZE             = "1000"
    FORCE_GAMEMODE             = "true"
    MODE                       = "creative"
    ENFORCE_WHITELIST          = "true"
    REMOVE_OLD_MODS            = "true"
    PLUGINS_SYNC_UPDATE        = "false"
  }
}