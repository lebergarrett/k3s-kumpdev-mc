# This is the main configuration file for Paper.
# As you can see, there's tons to configure. Some options may impact gameplay, so use
# with caution, and make sure you know what each option does before configuring.
#
# If you need help with the configuration or have any questions related to Paper,
# join us in our Discord or IRC channel.
#
# Discord: https://discord.gg/papermc
# IRC: #paper @ irc.esper.net ( https://webchat.esper.net/?channels=paper )
# Website: https://papermc.io/
# Docs: https://paper.readthedocs.org/

use-display-name-in-quit-message: false
verbose: false
config-version: 21
timings:
  url: https://timings.aikar.co/
  enabled: true
  verbose: true
  server-name-privacy: false
  hidden-config-entries:
  - database
  - settings.bungeecord-addresses
  - settings.velocity-support.secret
  history-interval: 300
  history-length: 3600
  server-name: Unknown Server
settings:
  log-named-entity-deaths: true
  fix-entity-position-desync: true
  save-empty-scoreboard-teams: false
  chunk-tasks-per-tick: 1000
  player-auto-save-rate: -1
  max-player-auto-save-per-tick: -1
  region-file-cache-size: 256
  incoming-packet-spam-threshold: 300
  max-joins-per-tick: 3
  track-plugin-scoreboards: false
  suggest-player-names-when-null-tab-completions: true
  enable-player-collisions: true
  use-alternative-luck-formula: false
  console-has-all-permissions: false
  bungee-online-mode: ${proxy_type == "WATERFALL" || proxy_type == "BUNGEECORD" ? true : false}
  load-permissions-yml-before-plugins: true
  unsupported-settings:
    allow-permanent-block-break-exploits: false
    allow-piston-duplication: false
    allow-headless-pistons: false
    allow-permanent-block-break-exploits-readme: This setting controls if players
      should be able to break bedrock, end portals and other intended to be permanent
      blocks.
    allow-piston-duplication-readme: This setting controls if player should be able
      to use TNT duplication, but this also allows duplicating carpet, rails and potentially
      other items
    allow-headless-pistons-readme: This setting controls if players should be able
      to create headless pistons.
  async-chunks:
    threads: -1
  watchdog:
    early-warning-every: 5000
    early-warning-delay: 10000
  spam-limiter:
    recipe-spam-increment: 1
    recipe-spam-limit: 20
    tab-spam-increment: 1
    tab-spam-limit: 500
  book-size:
    page-max: 2560
    total-multiplier: 0.98
  velocity-support:
    enabled: ${proxy_type == "VELOCITY" ? true : false}
    online-mode: true
    secret: '${proxy_type == "VELOCITY" ? forwarding_secret : ""}'
  console:
    enable-brigadier-highlighting: true
    enable-brigadier-completions: true
  loggers:
    deobfuscate-stacktraces: true
  item-validation:
    display-name: 8192
    loc-name: 8192
    lore-line: 8192
    book:
      title: 8192
      author: 8192
      page: 16384
  use-display-name-in-quit-message: false
messages:
  no-permission: '&cI''m sorry, but you do not have permission to perform this command.
    Please contact the server administrators if you believe that this is in error.'
  kick:
    authentication-servers-down: ''
    connection-throttle: Connection throttled! Please wait before reconnecting.
    flying-player: Flying is not enabled on this server
    flying-vehicle: Flying is not enabled on this server
world-settings:
  default:
    ender-dragons-death-always-places-dragon-egg: false
    allow-using-signs-inside-spawn-protection: false
    update-pathfinding-on-block-update: true
    fix-wither-targeting-bug: false
    allow-player-cramming-damage: false
    seed-based-feature-search-loads-chunks: true
    fix-items-merging-through-walls: false
    only-players-collide: false
    allow-vehicle-collisions: true
    show-sign-click-command-failure-msgs-to-player: false
    max-leash-distance: 10.0
    map-item-frame-cursor-limit: 128
    portal-search-vanilla-dimension-scaling: true
    fix-climbing-bypassing-cramming-rule: false
    parrots-are-unaffected-by-player-movement: false
    use-faster-eigencraft-redstone: false
    keep-spawn-loaded: true
    disable-thunder: false
    skeleton-horse-thunder-spawn-chance: 0.01
    disable-ice-and-snow: false
    grass-spread-tick-rate: 1
    water-over-lava-flow-speed: 5
    nether-ceiling-void-damage-height: 0
    allow-non-player-entities-on-scoreboards: false
    portal-search-radius: 128
    portal-create-radius: 16
    seed-based-feature-search: true
    disable-explosion-knockback: false
    keep-spawn-loaded-range: 10
    container-update-tick-rate: 1
    armor-stands-do-collision-entity-lookups: true
    prevent-tnt-from-moving-in-water: false
    zombies-target-turtle-eggs: true
    per-player-mob-spawns: false
    armor-stands-tick: true
    iron-golems-can-spawn-in-air: false
    zombie-villager-infection-chance: -1.0
    all-chunks-are-slime-chunks: false
    entities-target-with-follow-range: false
    spawner-nerfed-mobs-should-jump: false
    non-player-arrow-despawn-rate: -1
    creative-arrow-despawn-rate: -1
    delay-chunk-unloads-by: 10s
    mob-spawner-tick-rate: 1
    filter-nbt-data-from-spawn-eggs-and-related: true
    max-entity-collisions: 8
    disable-creeper-lingering-effect: false
    duplicate-uuid-resolver: saferegen
    duplicate-uuid-saferegen-delete-range: 32
    baby-zombie-movement-modifier: 0.5
    optimize-explosions: false
    fixed-chunk-inhabited-time: -1
    use-vanilla-world-scoreboard-name-coloring: false
    remove-corrupt-tile-entities: false
    experience-merge-max-value: -1
    prevent-moving-into-unloaded-chunks: false
    count-all-mobs-for-spawning: false
    should-remove-dragon: false
    falling-block-height-nerf: 0
    tnt-entity-height-nerf: 0
    auto-save-interval: -1
    enable-treasure-maps: true
    treasure-maps-return-already-discovered: false
    light-queue-size: 20
    disable-teleportation-suffocation-check: false
    phantoms-do-not-spawn-on-creative-players: true
    phantoms-only-attack-insomniacs: true
    max-auto-save-chunks-per-tick: 24
    game-mechanics:
      disable-mob-spawner-spawn-egg-transformation: false
      fix-curing-zombie-villager-discount-exploit: true
      nerf-pigmen-from-nether-portals: false
      disable-end-credits: false
      disable-player-crits: false
      disable-sprint-interruption-on-attack: false
      shield-blocking-delay: 5
      disable-chest-cat-detection: false
      disable-unloaded-chunk-enderpearl-exploit: true
      disable-relative-projectile-velocity: false
      disable-pillager-patrols: false
      scan-for-legacy-ender-dragon: true
      pillager-patrols:
        spawn-chance: 0.2
        spawn-delay:
          per-player: false
          ticks: 12000
        start:
          per-player: false
          day: 5
    anti-xray:
      max-block-height: 64
      use-permission: false
      enabled: false
      engine-mode: 1
      max-chunk-section-index: 3
      update-radius: 2
      lava-obscures: false
      hidden-blocks:
      - gold_ore
      - iron_ore
      - coal_ore
      - lapis_ore
      - mossy_cobblestone
      - obsidian
      - chest
      - diamond_ore
      - redstone_ore
      - clay
      - emerald_ore
      - ender_chest
      replacement-blocks:
      - stone
      - oak_planks
    viewdistances:
      no-tick-view-distance: -1
    wandering-trader:
      spawn-minute-length: 1200
      spawn-day-length: 24000
      spawn-chance-failure-increment: 25
      spawn-chance-min: 25
      spawn-chance-max: 75
    squid-spawn-height:
      maximum: 0.0
    frosted-ice:
      enabled: true
      delay:
        min: 20
        max: 40
    lootables:
      auto-replenish: false
      restrict-player-reloot: true
      reset-seed-on-fill: true
      max-refills: -1
      refresh-min: 12h
      refresh-max: 2d
    alt-item-despawn-rate:
      enabled: false
      items:
        COBBLESTONE: 300
    hopper:
      cooldown-when-full: true
      disable-move-event: false
    max-growth-height:
      cactus: 3
      reeds: 3
      bamboo:
        max: 16
        min: 11
    fishing-time-range:
      MinimumTicks: 100
      MaximumTicks: 600
    despawn-ranges:
      soft: 32
      hard: 128
    generator-settings:
      flat-bedrock: false
    lightning-strike-distance-limit:
      sound: -1
      impact-sound: -1
      flash: -1
    mobs-can-always-pick-up-loot:
      zombies: false
      skeletons: false
    door-breaking-difficulty:
      zombie:
      - HARD
      vindicator:
      - NORMAL
      - HARD
    entity-per-chunk-save-limit:
      fireball: -1
      small_fireball: -1
      experience_orb: -1
      snowball: -1
      ender_pearl: -1
      arrow: -1
    mob-effects:
      undead-immune-to-certain-effects: true
      spiders-immune-to-poison-effect: true
      immune-to-wither-effect:
        wither: true
        wither-skeleton: true
    spawn-limits:
      monsters: -1
      animals: -1
      water-animals: -1
      water-ambient: -1
      ambient: -1
    tick-rates:
      sensor:
        villager:
          secondarypoisensor: 40
      behavior:
        villager:
          validatenearbypoi: -1
    unsupported-settings:
      fix-invulnerable-end-crystal-exploit: true