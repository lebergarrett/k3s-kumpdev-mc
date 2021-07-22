############################################################
# +------------------------------------------------------+ #
# |                       Notes                          | #
# +------------------------------------------------------+ #
############################################################

# This is the config file for EssentialsX.
# This config was generated for version 2.18.0.21.

# If you want to use special characters in this document, such as accented letters, you MUST save the file as UTF-8, not ANSI.
# If you receive an error when Essentials loads, ensure that:
#   - No tabs are present: YAML only allows spaces
#   - Indents are correct: YAML hierarchy is based entirely on indentation
#   - You have "escaped" all apostrophes in your text: If you want to write "don't", for example, write "don''t" instead (note the doubled apostrophe)
#   - Text with symbols is enclosed in single or double quotation marks

# If you need help, you can join the EssentialsX community: https://essentialsx.cf/community.html

############################################################
# +------------------------------------------------------+ #
# |                 Essentials (Global)                  | #
# +------------------------------------------------------+ #
############################################################

# A color code between 0-9 or a-f. Set to 'none' to disable.
# In 1.16+ you can use hex color codes here as well. (For example, #613e1d is brown).
ops-name-color: '4'

# The character(s) to prefix all nicknames, so that you know they are not true usernames.
nickname-prefix: '~'

# The maximum length allowed in nicknames. The nickname prefix is included in this.
max-nick-length: 15

# A list of phrases that cannot be used in nicknames. You can include regular expressions here.
# Users with essentials.nick.blacklist.bypass will be able to bypass this filter.
nick-blacklist:
#- Notch
#- '^Dinnerbone'

# When this option is enabled, nickname length checking will exclude color codes in player names.
# ie: "&6Notch" has 7 characters (2 are part of a color code), a length of 5 is used when this option is set to true
ignore-colors-in-max-nick-length: false

# When this option is enabled, display names for hidden users will not be shown. This prevents players from being
# able to see that they are online while vanished.
hide-displayname-in-vanish: true

# Disable this if you have any other plugin, that modifies the displayname of a user.
change-displayname: true

# When this option is enabled, the (tab) player list will be updated with the displayname.
# The value of change-displayname (above) has to be true.
#change-playerlist: true

# When EssentialsChat.jar isn't used, force essentials to add the prefix and suffix from permission plugins to displayname.
# This setting is ignored if EssentialsChat.jar is used, and defaults to 'true'.
# The value of change-displayname (above) has to be true.
# Do not edit this setting unless you know what you are doing!
#add-prefix-suffix: false

# When this option is enabled, player prefixes will be shown in the playerlist.
# This feature only works for Minecraft version 1.8 and higher.
# This value of change-playerlist has to be true
#add-prefix-in-playerlist: true

# When this option is enabled, player suffixes will be shown in the playerlist.
# This feature only works for Minecraft version 1.8 and higher. 
# This value of change-playerlist has to be true
#add-suffix-in-playerlist: true

# If the teleport destination is unsafe, should players be teleported to the nearest safe location?
# If this is set to true, Essentials will attempt to teleport players close to the intended destination.
# If this is set to false, attempted teleports to unsafe locations will be cancelled with a warning.
teleport-safety: true

# This forcefully disables teleport safety checks without a warning if attempting to teleport to unsafe locations.
# teleport-safety and this option need to be set to true to force teleportation to dangerous locations.
force-disable-teleport-safety: false

# If a player is teleporting to an unsafe location in creative, adventure, or god mode; they will not be teleported to a
# safe location. If you'd like players to be teleported to a safe location all of the time, set this option to true.
force-safe-teleport-location: false

# If a player has any passengers, the teleport will fail. Should their passengers be dismounted before they are teleported?
# If this is set to true, Essentials will dismount the player's passengers before teleporting.
# If this is set to false, attempted teleports will be canceled with a warning.
teleport-passenger-dismount: true

# The delay, in seconds, required between /home, /tp, etc.
teleport-cooldown: 0

# The delay, in seconds, before a user actually teleports. If the user moves or gets attacked in this timeframe, the teleport is cancelled.
teleport-delay: 0

# The delay, in seconds, a player can't be attacked by other players after they have been teleported by a command.
# This will also prevent the player attacking other players.
teleport-invulnerability: 4

# Whether to make all teleportations go to the center of the block; where the x and z coordinates decimal become .5
teleport-to-center: true

# The delay, in seconds, required between /heal or /feed attempts.
heal-cooldown: 60

# Do you want to remove potion effects when healing a player?
remove-effects-on-heal: true

# Near Radius
# The default radius with /near
# Used to use chat radius but we are going to make it separate.
near-radius: 200

# What to prevent from /item and /give.
# e.g item-spawn-blacklist: 10,11,46
item-spawn-blacklist:

# Set this to true if you want permission based item spawn rules.
# Note: The blacklist above will be ignored then.
# Example permissions (these go in your permissions manager):
#  - essentials.itemspawn.item-all
#  - essentials.itemspawn.item-[itemname]
#  - essentials.itemspawn.item-[itemid]
#  - essentials.give.item-all
#  - essentials.give.item-[itemname]
#  - essentials.give.item-[itemid]
#  - essentials.unlimited.item-all
#  - essentials.unlimited.item-[itemname]
#  - essentials.unlimited.item-[itemid]
#  - essentials.unlimited.item-bucket # Unlimited liquid placing
#
# For more information, visit http://wiki.ess3.net/wiki/Command_Reference/ICheat#Item.2FGive
permission-based-item-spawn: false

# Mob limit on the /spawnmob command per execution.
spawnmob-limit: 10

# Shall we notify users when using /lightning?
warn-on-smite: true

# Shall we drop items instead of adding to inventory if the target inventory is full?
drop-items-if-full: false

# Essentials Mail Notification
# Should we notify players if they have no new mail?
notify-no-new-mail: true

# Specifies the duration (in seconds) between each time a player is notified of mail they have.
# Useful for servers with a lot of mail traffic.
notify-player-of-mail-cooldown: 60

# The motd and rules are now configured in the files motd.txt and rules.txt.

# When a command conflicts with another plugin, by default, Essentials will try to force the OTHER plugin to take priority.
# Commands in this list, will tell Essentials to 'not give up' the command to other plugins.
# In this state, which plugin 'wins' appears to be almost random.
#
# If you have two plugin with the same command and you wish to force Essentials to take over, you need an alias.
# To force essentials to take 'god' alias 'god' to 'egod'.
# See http://wiki.bukkit.org/Commands.yml#aliases for more information.

overridden-commands:
#  - god
#  - info

# Disabling commands here will prevent Essentials handling the command, this will not affect command conflicts.
# You should not have to disable commands used in other plugins, they will automatically get priority.
# See http://wiki.bukkit.org/Commands.yml#aliases to map commands to other plugins.
disabled-commands:
#  - nick
#  - clear

# These commands will be shown to players with socialSpy enabled.
# You can add commands from other plugins you may want to track or
# remove commands that are used for something you dont want to spy on.
# Set - '*' in order to listen on all possible commands.
socialspy-commands:
  - msg
  - w
  - r
  - mail
  - m
  - t
  - whisper
  - emsg
  - tell
  - er
  - reply
  - ereply
  - email
  - action
  - describe
  - eme
  - eaction
  - edescribe
  - etell
  - ewhisper
  - pm

# Whether the private and public messages from muted players should appear in the social spy.
# If so, they will be differentiated from those sent by normal players.
socialspy-listen-muted-players: true

# The following settings listen for when a player changes worlds.
# If you use another plugin to control speed and flight, you should change these to false.

# When a player changes world, should EssentialsX reset their flight?
# This will disable flight if the player does not have essentials.fly.
world-change-fly-reset: true

# When a player changes world, should we reset their speed according to their permissions?
# This resets the player's speed to the default if they don't have essentials.speed.
# If the player doesn't have essentials.speed.bypass, this resets their speed to the maximum specified above.
world-change-speed-reset: true

# Mute Commands
# These commands will be disabled when a player is muted.
# Use '*' to disable every command.
# Essentials already disabled Essentials messaging commands by default.
# It only cares about the root command, not args after that (it sees /f chat the same as /f)
mute-commands:
  - f
  - kittycannon
 # - '*'

# If you do not wish to use a permission system, you can define a list of 'player perms' below.
# This list has no effect if you are using a supported permissions system.
# If you are using an unsupported permissions system, simply delete this section.
# Whitelist the commands and permissions you wish to give players by default (everything else is op only).
# These are the permissions without the "essentials." part.
#
# To enable this feature, please set use-bukkit-permissions to false.
player-commands:
  - afk
  - afk.auto
  - back
  - back.ondeath
  - balance
  - balance.others
  - balancetop
  - build
  - chat.color
  - chat.format
  - chat.shout
  - chat.question
  - clearinventory
  - compass
  - depth
  - delhome
  - getpos
  - geoip.show
  - help
  - helpop
  - home
  - home.others
  - ignore
  - info
  - itemdb
  - kit
  - kits.tools
  - list
  - mail
  - mail.send
  - me
  - motd
  - msg
  - msg.color
  - nick
  - near
  - pay
  - ping
  - protect
  - r
  - rules
  - realname
  - seen
  - sell
  - sethome
  - setxmpp
  - signs.create.protection
  - signs.create.trade
  - signs.break.protection
  - signs.break.trade
  - signs.use.balance
  - signs.use.buy
  - signs.use.disposal
  - signs.use.enchant
  - signs.use.free
  - signs.use.gamemode
  - signs.use.heal
  - signs.use.info
  - signs.use.kit
  - signs.use.mail
  - signs.use.protection
  - signs.use.repair
  - signs.use.sell
  - signs.use.time
  - signs.use.trade
  - signs.use.warp
  - signs.use.weather
  - spawn
  - suicide
  - time
  - tpa
  - tpaccept
  - tpahere
  - tpdeny
  - warp
  - warp.list
  - world
  - worth
  - xmpp

# Use this option to force superperms-based permissions handler regardless of detected installed perms plugin.
# This is useful if you want superperms-based permissions (with wildcards) for custom permissions plugins.
# If you wish to use EssentialsX's built-in permissions using the `player-commands` section above, set this to false.
# Default is true.
use-bukkit-permissions: true

# When this option is enabled, one-time use kits (ie. delay < 0) will be
# removed from the /kit list when a player can no longer use it
skip-used-one-time-kits-from-kit-list: false

# Determines the functionality of the /createkit command.
# If this is true, /createkit will give the user a link with the kit code.
# If this is false, /createkit will add the kit to the kits.yml config file directly.
#
pastebin-createkit: false

# Essentials Sign Control
# See http://wiki.ess3.net/wiki/Sign_Tutorial for instructions on how to use these.
# To enable signs, remove # symbol. To disable all signs, comment/remove each sign.
# Essentials colored sign support will be enabled when any sign types are enabled.
# Color is not an actual sign, it's for enabling using color codes on signs, when the correct permissions are given.

enabledSigns:
  #- color
  #- balance
  #- buy
  #- sell
  #- trade
  #- free
  #- disposal
  #- warp
  #- kit
  #- mail
  #- enchant
  #- gamemode
  #- heal
  #- info
  #- spawnmob
  #- repair
  #- time
  #- weather

# How many times per second can Essentials signs be interacted with per player.
# Values should be between 1-20, 20 being virtually no lag protection.
# Lower numbers will reduce the possibility of lag, but may annoy players.
sign-use-per-second: 4

# Allow item IDs on pre-existing signs on 1.13 and above.
# You cannot use item IDs on new signs, but this will allow players to interact with signs that
# were placed before 1.13.
allow-old-id-signs: false

# List of sign names Essentials should not protect. This feature is especially useful when
# another plugin provides a sign that EssentialsX provides, but Essentials overrides.
# For example, if a plugin provides a [kit] sign, and you wish to use theirs instead of
# Essentials's, then simply add kit below and Essentials will not protect it.
#
# See https://github.com/drtshock/Essentials/pull/699 for more information.
unprotected-sign-names:
  #- kit

# Backup runs a custom batch/bash command at a specified interval.
# The server will save the world before executing the backup command, and disable
# saving during the backup to prevent world corruption or other conflicts.
# Backups can also be triggered manually with /backup.
backup:
  # Interval in minutes.
  interval: 30
  # If true, the backup task will run even if there are no players online.
  always-run: false
  # Unless you add a valid backup command or script here, this feature will be useless.
  # Use 'save-all' to simply force regular world saving without backup.
  # The example command below utilizes rdiff-backup: https://rdiff-backup.net/
  #command: 'rdiff-backup World1 backups/World1'

# Set this true to enable permission per warp.
per-warp-permission: false

# Sort output of /list command by groups.
# You can hide and merge the groups displayed in /list by defining the desired behaviour here.
# Detailed instructions and examples can be found on the wiki: http://wiki.ess3.net/wiki/List
list:
    # To merge groups, list the groups you wish to merge
    #Staff: owner admin moderator
    Admins: owner admin
    # To limit groups, set a max user limit
    #builder: 20
    # To hide groups, set the group as hidden
    #default: hidden
    # Uncomment the line below to simply list all players with no grouping
    #Players: '*'

# Displays real names in /list next to players who are using a nickname.
real-names-on-list: false

# More output to the console.
debug: false

# Set the locale for all messages.
# If you don't set this, the default locale of the server will be used.
# For example, to set language to English, set locale to en, to use the file "messages_en.properties".
# Don't forget to remove the # in front of the line.
# For more information, visit http://wiki.ess3.net/wiki/Locale
#locale: en

# Turn off god mode when people leave the server.
remove-god-on-disconnect: false

# Auto-AFK
# After this timeout in seconds, the user will be set as AFK.
# This feature requires the player to have essentials.afk.auto node.
# Set to -1 for no timeout.
auto-afk: 300

# Auto-AFK Kick
# After this timeout in seconds, the user will be kicked from the server.
# essentials.afk.kickexempt node overrides this feature.
# Set to -1 for no timeout.
auto-afk-kick: -1

# Set this to true, if you want to freeze the player, if the player is AFK.
# Other players or monsters can't push the player out of AFK mode then.
# This will also enable temporary god mode for the AFK player.
# The player has to use the command /afk to leave the AFK mode.
freeze-afk-players: false

# When the player is AFK, should he be able to pickup items?
# Enable this, when you don't want people idling in mob traps.
disable-item-pickup-while-afk: false

# This setting controls if a player is marked as active on interaction.
# When this setting is false, the player would need to manually un-AFK using the /afk command.
cancel-afk-on-interact: true

# Should we automatically remove afk status when a player moves?
# Player will be removed from AFK on chat/command regardless of this setting.
# Disable this to reduce server lag.
cancel-afk-on-move: true

# Should AFK players be ignored when other players are trying to sleep?
# When this setting is false, players won't be able to skip the night if some players are AFK.
# Users with the permission node essentials.sleepingignored will always be ignored.
sleep-ignores-afk-players: true

# Set the player's list name when they are AFK. This is none by default which specifies that Essentials 
# should not interfere with the AFK player's list name.
# You may use color codes, use {USERNAME} the player's name or {PLAYER} for the player's displayname.
afk-list-name: "none"

# When a player enters or exits AFK mode, should the AFK notification be broadcast
# to the entire server, or just to the player?
# When this setting is false, only the player will be notified upon changing their AFK state.
broadcast-afk-message: true

# You can disable the death messages of Minecraft here.
death-messages: true

# How should essentials handle players with the essentials.keepinv permission who have items with
# curse of vanishing when they die?
# You can set this to "keep" (to keep the item), "drop" (to drop the item), or "delete" (to delete the item).
# Defaults to "keep"
vanishing-items-policy: keep

# How should essentials handle players with the essentials.keepinv permission who have items with
# curse of binding when they die?
# You can set this to "keep" (to keep the item), "drop" (to drop the item), or "delete" (to delete the item).
# Defaults to "keep"
binding-items-policy: keep

# When players die, should they receive the coordinates they died at?
send-info-after-death: false

# Should players with permissions be able to join and part silently?
# You can control this with essentials.silentjoin and essentials.silentquit permissions if it is enabled.
# In addition, people with essentials.silentjoin.vanish will be vanished on join.
allow-silent-join-quit: false

# You can set custom join and quit messages here. Set this to "none" to use the default Minecraft message,
# or set this to "" to hide the message entirely.
# You may use color codes, {USERNAME} for the player's name, and {PLAYER} for the player's displayname.
custom-join-message: "none"
custom-quit-message: "none"

# You can disable join and quit messages when the player count reaches a certain limit.
# When the player count is below this number, join/quit messages will always be shown.
# Set this to -1 to always show join and quit messages regardless of player count.
hide-join-quit-messages-above: -1

# Add worlds to this list, if you want to automatically disable god mode there.
no-god-in-worlds:
#  - world_nether

# Set to true to enable per-world permissions for teleporting between worlds with essentials commands.
# This applies to /world, /back, /tp[a|o][here|all], but not warps.
# Give someone permission to teleport to a world with essentials.worlds.<worldname>
# This does not affect the /home command, there is a separate toggle below for this.
world-teleport-permissions: false

# The number of items given if the quantity parameter is left out in /item or /give.
# If this number is below 1, the maximum stack size size is given. If over-sized stacks.
# are not enabled, any number higher than the maximum stack size results in more than one stack.
default-stack-size: -1

# Over-sized stacks are stacks that ignore the normal max stack size.
# They can be obtained using /give and /item, if the player has essentials.oversizedstacks permission.
# How many items should be in an over-sized stack?
oversized-stacksize: 64

# Allow repair of enchanted weapons and armor.
# If you set this to false, you can still allow it for certain players using the permission.
# essentials.repair.enchanted
repair-enchanted: true

# Allow 'unsafe' enchantments in kits and item spawning.
# Warning: Mixing and overleveling some enchantments can cause issues with clients, servers and plugins.
unsafe-enchantments: false

#Do you want Essentials to keep track of previous location for /back in the teleport listener?
#If you set this to true any plugin that uses teleport will have the previous location registered.
register-back-in-listener: false

#Delay to wait before people can cause attack damage after logging in.
login-attack-delay: 5

#Set the max fly speed, values range from 0.1 to 1.0
max-fly-speed: 0.8

#Set the max walk speed, values range from 0.1 to 1.0
max-walk-speed: 0.8

#Set the maximum amount of mail that can be sent within a minute.
mails-per-minute: 1000

# Set the maximum time /mute can be used for in seconds.
# Set to -1 to disable, and essentials.mute.unlimited can be used to override.
max-mute-time: -1

# Set the maximum time /tempban can be used for in seconds.
# Set to -1 to disable, and essentials.tempban.unlimited can be used to override.
max-tempban-time: -1

# Changes the default /reply functionality. This can be changed on a per-player basis using /rtoggle.
# If true, /r goes to the person you messaged last, otherwise the first person that messaged you.
# If false, /r goes to the last person that messaged you.
last-message-reply-recipient: true

# If last-message-reply-recipient is enabled for a particular player,
# this specifies the duration, in seconds, that would need to elapse for the
# reply-recipient to update when receiving a message.
# Default is 180 (3 minutes)
last-message-reply-recipient-timeout: 180

# Toggles whether or not left clicking mobs with a milk bucket turns them into a baby.
milk-bucket-easter-egg: true

# Toggles whether or not the fly status message should be sent to players on join
send-fly-enable-on-join: true

# Set to true to enable per-world permissions for setting time for individual worlds with essentials commands.
# This applies to /time, /day, /eday, /night, /enight, /etime.
# Give someone permission to teleport to a world with essentials.time.world.<worldname>.
world-time-permissions: false

# Specify cooldown for both Essentials commands and external commands as well.
# All commands do not start with a Forward Slash (/). Instead of /msg, write msg
#
# Wildcards are supported. E.g.
# - '*i*': 50
# adds a 50 second cooldown to all commands that include the letter i
#
# EssentialsX supports regex by starting the command with a caret ^
# For example, to target commands starting with ban and not banip the following would be used:
#  '^ban([^ip])( .*)?': 60 # 60 seconds /ban cooldown.
# Note: If you have a command that starts with ^, then you can escape it using backslash (\). e.g. \^command: 123
command-cooldowns:
#  feed: 100 # 100 second cooldown on /feed command
#  '*': 5 # 5 Second cooldown on all commands

# Whether command cooldowns should be persistent past server shutdowns
command-cooldown-persistence: true

# Whether NPC balances should be listed in balance ranking features such as /balancetop.
# NPC balances can include features like factions from FactionsUUID plugin.
npcs-in-balance-ranking: false

# Allow bulk buying and selling signs when the player is sneaking.
# This is useful when a sign sells or buys one item at a time and the player wants to sell a bunch at once.
allow-bulk-buy-sell: true

# Allow selling of items with custom names with the /sell command.
# This may be useful to prevent players accidentally selling named items.
allow-selling-named-items: false

# Delay for the MOTD display for players on join, in milliseconds.
# This has no effect if the MOTD command or permission are disabled.
delay-motd: 0

# A list of commands that should have their complementary confirm commands enabled by default.
# This is empty by default, for the latest list of valid commands see the latest source config.yml.
default-enabled-confirm-commands:
#- pay
#- clearinventory

# Whether or not to teleport a player back to their previous position after they have been freed from jail.
teleport-back-when-freed-from-jail: true

# Set the timeout, in seconds for players to accept a tpa before the request is cancelled.
# Set to 0 for no timeout.
tpa-accept-cancellation: 120

# Allow players to set hats by clicking on their helmet slot.
allow-direct-hat: true

# Allow in-game players to specify a world when running /broadcastworld.
# If false, running /broadcastworld in-game will always send a message to the player's current world.
# This doesn't affect running the command from the console, where a world is always required.
allow-world-in-broadcastworld: true

# Consider water blocks as "safe," therefore allowing players to teleport
# using commands such as /home or /spawn to a location that is occupied
# by water blocks
is-water-safe: false

# Should the usermap try to sanitise usernames before saving them?
# You should only change this to false if you use Minecraft China.
safe-usermap-names: true

# Should Essentials output logs when a command block executes a command?
# Example: CommandBlock at <x>,<y>,<z> issued server command: /<command>
log-command-block-commands: true

# Set the maximum speed for projectiles spawned with /fireball.
max-projectile-speed: 8

############################################################
# +------------------------------------------------------+ #
# |                        Homes                         | #
# +------------------------------------------------------+ #
############################################################

# Allows people to set their bed during the day.
# This setting has no effect in Minecraft 1.15+, as Minecraft will always allow the player to set their bed location during the day.
update-bed-at-daytime: true

# Set to true to enable per-world permissions for using homes to teleport between worlds.
# This applies to the /home command only.
# Give someone permission to teleport to a world with essentials.worlds.<worldname>
world-home-permissions: false

# Allow players to have multiple homes.
# Players need essentials.sethome.multiple before they can have more than 1 home.
# You can set the default number of multiple homes using the 'default' rank below.
# To remove the home limit entirely, give people 'essentials.sethome.multiple.unlimited'.
# To grant different home amounts to different people, you need to define a 'home-rank' below.
# Create the 'home-rank' below, and give the matching permission: essentials.sethome.multiple.<home-rank>
# For more information, visit http://wiki.ess3.net/wiki/Multihome
sethome-multiple:
  default: 3
  vip: 5
  staff: 10

# In this example someone with 'essentials.sethome.multiple' and 'essentials.sethome.multiple.vip' will have 5 homes.
# Remember, they MUST have both permission nodes in order to be able to set multiple homes.

# Controls whether players need the permission "essentials.home.compass" in order to point
# the player's compass at their first home.
#
# Leaving this as false will retain Essentials' original behaviour, which is to always
# change the compass' direction to point towards their first home.
compass-towards-home-perm: false

# If no home is set, would you like to send the player to spawn?
# If set to false, players will not be teleported when they run /home without setting a home first.
spawn-if-no-home: true

# Should players be asked to provide confirmation for homes which they attempt to overwrite?
confirm-home-overwrite: false

############################################################
# +------------------------------------------------------+ #
# |                       Economy                        | #
# +------------------------------------------------------+ #
############################################################

# For more information, visit http://wiki.ess3.net/wiki/Essentials_Economy

# You can control the values of items that are sold to the server by using the /setworth command.

# Defines the balance with which new players begin. Defaults to 0.
starting-balance: 0

# Defines the cost to use the given commands PER USE.
# Some commands like /repair have sub-costs, check the wiki for more information.
command-costs:
  # /example costs $1000 PER USE
  #example: 1000
  # /kit tools costs $1500 PER USE
  #kit-tools: 1500

# Set this to a currency symbol you want to use.
# Remember, if you want to use special characters in this document, 
# such as accented letters, you MUST save the file as UTF-8, not ANSI.
currency-symbol: '$'

# Enable this to make the currency symbol appear at the end of the amount rather than at the start.
# For example, the euro symbol typically appears after the current amount.
currency-symbol-suffix: false

# Set the maximum amount of money a player can have.
# The amount is always limited to 10 trillion because of the limitations of a java double.
max-money: 10000000000000

# Set the minimum amount of money a player can have (must be above the negative of max-money).
# Setting this to 0, will disable overdrafts/loans completely.  Users need 'essentials.eco.loan' perm to go below 0.
min-money: -10000

# Enable this to log all interactions with trade/buy/sell signs and sell command.
economy-log-enabled: false

# Enable this to also log all transactions from other plugins through Vault.
# This can cause the economy log to fill up quickly so should only be enabled for testing purposes!
economy-log-update-enabled: false

# Minimum acceptable amount to be used in /pay.
minimum-pay-amount: 0.001

# Enable this to block users who try to /pay another user which ignore them.
pay-excludes-ignore-list: false

# The format of currency, excluding symbols. See currency-symbol-format-locale for symbol configuration.
#
# "#,##0.00" is how the majority of countries display currency.
#currency-format: "#,##0.00"

# Format currency symbols. Some locales use , and . interchangeably.
# Some formats do not display properly in-game due to faulty Minecraft font rendering.
#
# For 1.234,50 use de-DE
# For 1,234.50 use en-US
# For 1'234,50 use fr-ch
#currency-symbol-format-locale: en-US

############################################################
# +------------------------------------------------------+ #
# |                         Help                         | #
# +------------------------------------------------------+ #
############################################################

# Show other plugins commands in help.
non-ess-in-help: true

# Hide plugins which do not give a permission.
# You can override a true value here for a single plugin by adding a permission to a user/group.
# The individual permission is: essentials.help.<plugin>, anyone with essentials.* or '*' will see all help regardless.
# You can use negative permissions to remove access to just a single plugins help if the following is enabled.
hide-permissionless-help: true

############################################################
# +------------------------------------------------------+ #
# |                   EssentialsX Chat                   | #
# +------------------------------------------------------+ #
############################################################

# You need to install EssentialsX Chat for this section to work.
# See https://essentialsx.cf/wiki/Module-Breakdown.html for more information.

chat:

  # If EssentialsX Chat is installed, this will define how far a player's voice travels, in blocks. Set to 0 to make all chat global.
  # Note that users with the "essentials.chat.spy" permission will hear everything, regardless of this setting.
  # Users with essentials.chat.shout can override this by prefixing their message with an exclamation mark (!)
  # Users with essentials.chat.question can override this by prefixing their message with a question mark (?)
  # You can add command costs for shout/question by adding chat-shout and chat-question to the command costs section.
  radius: 0

  # Chat formatting can be done in two ways, you can either define a standard format for all chat.
  # Or you can give a group specific chat format, to give some extra variation.
  # For more information of chat formatting, check out the wiki: http://wiki.ess3.net/wiki/Chat_Formatting

  format: '<{DISPLAYNAME}> {MESSAGE}'
  #format: '&7[{GROUP}]&r {DISPLAYNAME}&7:&r {MESSAGE}'
  #format: '&7{PREFIX}&r {DISPLAYNAME}&r &7{SUFFIX}&r: {MESSAGE}'

  group-formats:
  #  default: '{WORLDNAME} {DISPLAYNAME}&7:&r {MESSAGE}'
  #  admins: '{WORLDNAME} &c[{GROUP}]&r {DISPLAYNAME}&7:&c {MESSAGE}'

  # If you are using group formats make sure to remove the '#' to allow the setting to be read.
  # Note: Group names are case-sensitive so you must match them up with your permission plugin.
  
  # You can use permissions to control whether players can use formatting codes in their chat messages.
  # See https://essentialsx.cf/wiki/Color-Permissions.html for more information.

############################################################
# +------------------------------------------------------+ #
# |                 EssentialsX Protect                  | #
# +------------------------------------------------------+ #
############################################################

# You need to install EssentialsX Protect for this section to work.
# See https://essentialsx.cf/wiki/Module-Breakdown.html for more information.

protect:

  # General physics/behavior modifications. Set these to true to disable behaviours.
  prevent:
    lava-flow: false
    water-flow: false
    water-bucket-flow: false
    fire-spread: true
    lava-fire-spread: true
    lava-itemdamage: false
    flint-fire: false
    lightning-fire-spread: true
    portal-creation: false
    tnt-explosion: false
    tnt-playerdamage: false
    tnt-itemdamage: false
    tnt-minecart-explosion: false
    tnt-minecart-playerdamage: false
    tnt-minecart-itemdamage: false
    fireball-explosion: false
    fireball-fire: false
    fireball-playerdamage: false
    fireball-itemdamage: false
    witherskull-explosion: false
    witherskull-playerdamage: false
    witherskull-itemdamage: false
    wither-spawnexplosion: false
    wither-blockreplace: false
    creeper-explosion: false
    creeper-playerdamage: false
    creeper-itemdamage: false
    creeper-blockdamage: false
    ender-crystal-explosion: false
    enderdragon-blockdamage: true
    enderman-pickup: false
    villager-death: false
    bed-explosion: false
    respawn-anchor-explosion: false
    # Monsters won't follow players.
    # permission essentials.protect.entitytarget.bypass disables this.
    entitytarget: false
    # Prevents zombies from breaking down doors
    zombie-door-break: false
    # Prevents Ravagers from stealing blocks
    ravager-thief: false
    # Prevents sheep from turning grass to dirt
    sheep-eat-grass: false
    # Prevent certain transformations.
    transformation:
      # Prevent creepers becoming charged when struck by lightning.
      charged-creeper: false
      # Prevent villagers becoming zombie villagers.
      zombie-villager: false
      # Prevent zombie villagers being cured.
      villager: false
      # Prevent villagers becoming witches when struck by lightning.
      witch: false
      # Prevent pigs becoming zombie pigmen when struck by lightning.
      zombie-pigman: false
      # Prevent zombies turning into drowneds, and husks turning into zombies.
      drowned: false
      # Prevent mooshrooms changing colour when struck by lightning.
      mooshroom: false
    # Prevent the spawning of creatures. If a creature is missing, you can add it following the format below.
    spawn:
      creeper: false
      skeleton: false
      spider: false
      giant: false
      zombie: false
      slime: false
      ghast: false
      pig_zombie: false
      enderman: false
      cave_spider: false
      silverfish: false
      blaze: false
      magma_cube: false
      ender_dragon: false
      pig: false
      sheep: false
      cow: false
      chicken: false
      squid: false
      wolf: false
      mushroom_cow: false
      snowman: false
      ocelot: false
      iron_golem: false
      villager: false
      wither: false
      bat: false
      witch: false
      horse: false
      phantom: false

  # Maximum height the creeper should explode. -1 allows them to explode everywhere.
  # Set prevent.creeper-explosion to true, if you want to disable creeper explosions.
  creeper:
    max-height: -1

  # Disable various default physics and behaviors.
  disable:
    # Should fall damage be disabled?
    fall: false

    # Users with the essentials.protect.pvp permission will still be able to attack each other if this is set to true.
    # They will be unable to attack users without that same permission node.
    pvp: false

    # Should drowning damage be disabled?
    # (Split into two behaviors; generally, you want both set to the same value.)
    drown: false
    suffocate: false

    # Should damage via lava be disabled?  Items that fall into lava will still burn to a crisp. ;)
    lavadmg: false

    # Should arrow damage be disabled?
    projectiles: false

    # This will disable damage from touching cacti.
    contactdmg: false

    # Burn, baby, burn!  Should fire damage be disabled?
    firedmg: false

    # Should the damage after hit by a lightning be disabled?
    lightning: false

    # Should Wither damage be disabled?
    wither: false

    # Disable weather options?
    weather:
      storm: false
      thunder: false
      lightning: false

############################################################
# +------------------------------------------------------+ #
# |                EssentialsX AntiBuild                 | #
# +------------------------------------------------------+ #
############################################################

  # You need to install EssentialsX AntiBuild for this section to work.
  # See https://essentialsx.cf/wiki/Module-Breakdown.html and http://wiki.ess3.net/wiki/AntiBuild for more information.

    # Should people without the essentials.build permission be allowed to build?
    # Set true to disable building for those people.
    # Setting to false means EssentialsAntiBuild will never prevent you from building.
    build: true

    # Should people without the essentials.build permission be allowed to use items?
    # Set true to disable using for those people.
    # Setting to false means EssentialsAntiBuild will never prevent you from using items.
    use: true

    # Should we warn people when they are not allowed to build?
    warn-on-build-disallow: true

  # For which block types would you like to be alerted?
  # You can find a list of items at https://hub.spigotmc.org/javadocs/spigot/org/bukkit/Material.html.
  alert:
    on-placement: LAVA,TNT,LAVA_BUCKET
    on-use: LAVA_BUCKET
    on-break:

  blacklist:

    # Which blocks should people be prevented from placing?
    placement: LAVA,TNT,LAVA_BUCKET

    # Which items should people be prevented from using?
    usage: LAVA_BUCKET

    # Which blocks should people be prevented from breaking?
    break:

    # Which blocks should not be pushed by pistons?
    piston:

    # Which blocks should not be dispensed by dispensers
    dispenser:

############################################################
# +------------------------------------------------------+ #
# |            EssentialsX Spawn + New Players           | #
# +------------------------------------------------------+ #
############################################################

# You need to install EssentialsX Spawn for this section to work.
# See https://essentialsx.cf/wiki/Module-Breakdown.html for more information.

newbies:
  # Should we announce to the server when someone logs in for the first time?
  # If so, use this format, replacing {DISPLAYNAME} with the player name.
  # If not, set to ''
  #announce-format: ''
  announce-format: '&dWelcome {DISPLAYNAME}&d to the server!'

  # When we spawn for the first time, which spawnpoint do we use?
  # Set to "none" if you want to use the spawn point of the world.
  spawnpoint: newbies

  # Do we want to give users anything on first join? Set to '' to disable
  # This kit will be given regardless of cost and permissions, and will not trigger the kit delay.
  kit: ''

# What priority should we use for handling respawns?
# Set this to none, if you want vanilla respawning behaviour.
# Set this to lowest, if you want Multiverse to handle the respawning.
# Set this to high, if you want EssentialsSpawn to handle the respawning.
# Set this to highest, if you want to force EssentialsSpawn to handle the respawning.
respawn-listener-priority: high

# What priority should we use for handling spawning on joining the server?
# See respawn-listener-priority for possible values.
# Note: changing this may impact or break spawn-on-join functionality.
spawn-join-listener-priority: high

# When users die, should they respawn at their first home or bed, instead of the spawnpoint?
respawn-at-home: true

# When users die, should EssentialsSpawn respect users' respawn anchors?
respawn-at-anchor: false

# Teleport all joining players to the spawnpoint
spawn-on-join: false
# The following value of `guests` states that all players in group `guests` will be teleported to spawn when joining.
#spawn-on-join: guests
# The following list value states that all players in group `guests` and `admin` are to be teleported to spawn when joining. 
#spawn-on-join:
#- guests
#- admin

# End of file <-- No seriously, you're done with configuration.
