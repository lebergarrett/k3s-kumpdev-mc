variable "server_name" {
  description = "Name of server/network, used in various locations"
  type        = string
}

variable "vanilla_env_vars" {
  description = "env vars for the vanilla server"
  type        = map(string)
}