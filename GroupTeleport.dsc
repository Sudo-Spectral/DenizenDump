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
        # Lists all valid cuboid locations
        1: <util.notes[cuboids]>
    script:
        # Checks command provided had correct amount of arguements to be valid
        - if <context.args.size> == 2:
            # Defines the cuboids and catches if they are incorrectly named
            - define notableA <cuboid[<context.args.get[1]>].if_null[null]>
            - define notableB <cuboid[<context.args.get[2]>].if_null[null]>
            # If first location is invalid
            - if <[notableA]> == null:
                # If both locations are invalid
                - if <[notableB]> == null:
                    - narrate "Neither location exist!"
                # If only first location is invalid
                - else:
                    - narrate "Your first location doesn't exist!"
            # If first location is valid
            - else:
                - if <[notableB]> == null:
                    # If second location is invalid
                    - narrate "Your second location doesn't exist!"
                # If both locations are valid and the command is properly syntaxed
                - else:
                    # Teleports all players within arg1 to arg2 cuboids centre
                    - teleport <[notableA].players> <[notableB].center>
                    - narrate 'Players teleported'
        # Provided too many or too few arguements
        - else:
            - narrate 'Incorrect amount of arguements!'
