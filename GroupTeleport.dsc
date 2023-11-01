# Command to be run in-game to teleport a group of players in one place to another
teleport_command:
    type: command
    debug: true
    name: groupTP
    aliases:
        - gtp
        - groupteleport
        - teleportgroup
    permission: groupteleport.teleport
    description: Teleports a group of players within a predefined area to another predefined area
    usage: /groupTP (posA) (posB)
    tab completions:
        1: spawn|placeholder|placeholder2
    script:
        - define notableA <[Notable/<context.args.get[1]>]>
        #                                                               what would work here?
        - narrate Group Teleport! <context.args.get[1]> <context.args.get[2]>

on_enter_spawn:
    type: world
    events:
        after player enters Spawn:
            - ratelimit <player> 10s
            - narrate "Welcome <player.name> to spawn!"
        after player exits Spawn:
            # Only allows to run once every 10 seconds
            - ratelimit <player> 10s
            - narrate 'You are leaving spawn now...'


# Should work for any notable but doesn't work...
#on_enter_notable:
#  type: world
#  events:
#    after player enters Notable:
#      - define notable_name <context.location.notable_name>
#      - if <[Notable/<context.location.notable_name>].is_set>:
#        - ratelimit <player> 10s
#        - narrate "Welcome <player.name> to <[Notable/<context.location.notable_name>].notable_name>!"
#


