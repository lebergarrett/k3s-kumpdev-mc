server_name = "prod-mc-kumpdev"

# Waterfall Proxy Configuration
proxy_motd            = "&2Kumpdev &l&7is a server network powered by Kubernetes!"
proxy_priority_server = "fabric"

# Minecraft Vars
mc_connection_port = "25565"
mc_version         = "1.17.1"
mc_ops             = "Kumpy,Fett32"

paper_config = {
  #  lobby = {
  #    DIFFICULTY                 = "peaceful"
  #    ENFORCE_WHITELIST          = "true"
  #    EULA                       = "true"
  #    LEVEL                      = "LobbyWorld"
  #    MAX_WORLD_SIZE             = "100"
  #    MEMORY                     = "1G"
  #    ONLINE_MODE                = "false"
  #    OVERRIDE_SERVER_PROPERTIES = "true"
  #    PLUGINS_SYNC_UPDATE        = "false"
  #    PVP                        = "false"
  #    SERVER_NAME                = "lobby"
  #    SPAWN_PROTECTION           = "0"
  #  }
  creative = {
    DIFFICULTY                 = "peaceful"
    WHITELIST                  = "Kumpy,Fett32,Free_Autopsy,Baskest,B1ack_Raijin,AlsoKnownAs_,Cailinbrv,Mojo_dodo"
    EULA                       = "true"
    FORCE_GAMEMODE             = "true"
    LEVEL                      = "CreativeWorld"
    MAX_WORLD_SIZE             = "1000"
    MEMORY                     = "1G"
    MODE                       = "creative"
    ONLINE_MODE                = "false"
    OVERRIDE_SERVER_PROPERTIES = "true"
    PLUGINS_SYNC_UPDATE        = "false"
    PVP                        = "false"
    SERVER_NAME                = "creative"
    SPAWN_PROTECTION           = "0"
  }
}

fabric_config = {
  fabric = {
    DIFFICULTY = "hard"
    WHITELIST  = "Kumpy,Fett32,Free_Autopsy,Baskest,B1ack_Raijin,AlsoKnownAs_,Cailinbrv,Mojo_dodo"
    EULA       = "true"
    LEVEL      = "1_11 Kumpback"
    # World size is a radius
    # Pre 1.17 world size was 15000, Increasing to 15500 until 1.18, then will increase to 17000
    MAX_WORLD_SIZE             = "15500"
    MEMORY                     = "4G"
    ONLINE_MODE                = "false"
    OVERRIDE_SERVER_PROPERTIES = "true"
    PLUGINS_SYNC_UPDATE        = "false"
    PVP                        = "true"
    SPAWN_PROTECTION           = "0"
    VIEW_DISTANCE              = "18"
  }
  fabric-creative = {
    DIFFICULTY                 = "peaceful"
    WHITELIST                  = "Kumpy,Fett32,Free_Autopsy,Baskest,B1ack_Raijin,AlsoKnownAs_,Cailinbrv,Mojo_dodo"
    EULA                       = "true"
    FORCE_GAMEMODE             = "true"
    LEVEL                      = "CreativeWorld"
    LEVEL_TYPE                 = "FLAT"
    MAX_WORLD_SIZE             = "1000"
    MEMORY                     = "1G"
    MODE                       = "creative"
    ONLINE_MODE                = "false"
    OVERRIDE_SERVER_PROPERTIES = "true"
    PLUGINS_SYNC_UPDATE        = "false"
    PVP                        = "false"
    SPAWN_PROTECTION           = "0"
  }
}