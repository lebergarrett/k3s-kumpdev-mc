server_name = "e2e-mc-kumpdev"

# Minecraft Vars
mc_connection_port = "25567"
mc_version         = "1.12.2"
mc_ops             = "Kumpy,Fett32"
image_tag          = "main"

ftb_config = {
  e2e = {
    CF_BASE_DIR      = "/data"
    CF_SERVER_MOD    = "/modpacks/Enigmatica2ExpertServer-1.82a.zip"
    DIFFICULTY       = "normal"
    JVM_DD_OPTS      = "fml.queryResult=confirm"
    MAX_WORLD_SIZE   = "5000"
    MEMORY           = "8G"
    ONLINE_MODE      = "true"
    PVP              = "true"
    SPAWN_PROTECTION = "0"
  }
}