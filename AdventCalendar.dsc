opened:
  type: item
  material: red_wool
  lore:
  - <&c>You've already claimed this.

current:
  type: item
  material: green_wool
  lore:
  - <&a>Click to claim this.

unavailable:
  type: item
  material: yellow_wool
  lore:
  - <&e>You can't claim this yet.

advent_inventory:
  type: inventory
  inventory: chest
  size: 27
  gui: true
  procedural items:
  - define max_days 12
  - define current_day <player.flag[advent_day]||1>
  - define claimed_day <player.flag[claimed_day]||0>

  # Loops to place in all items based on criteria
  - repeat <[max_days]> as:n:
    #If Index Lesser than current_day == claimed
    - if <[n]> < <[current_day]>:
      # Sets Inventory space as [opened] object
      - define item <item[opened]>
    #if Index == current_day: Today
    - else if <[n]> == <[current_day]>:
      # If player has claimed_day flag equal to current day, claimed already
      - if <[n]> == <[claimed_day]>:
        - define item <item[opened]>
      - else:
      # Not claimed
        - define item <item[current]>
    #If Index greater than current_day, Day hasn't happened yet
    - else:
      - define item <item[unavailable]>

    - define days_items_list:->:<[item].with_single[display=<&6>Day <[n]>].with_flag[day:<[n]>]>
  - determine <[days_items_list]>

advent_world:
  type: world
  events:
    on player clicks item_flagged:day in advent_inventory:
    - if <context.item.flag[claimed_day]> == <context.item.flag[advent_day]>:
    # Days prize already claimed
      - narrate "You've already claimed this!"
    - else:
        # Days prize not yet claimed
      - if <context.item.flag[day]> == <context.item.flag[advent_day]>:
        # Correct day to claim prize
        - flag <player> claimed_day:<context.item.flag[day]>
        # ^^ Gives player day_claimed flag not allowing them to claim again.



        # GIVE PLAYERS PRIZES IN HERE :)


        - inventory close
      - else:
        # Incorrect day to claim prize
        - narrate "Can't claim this prize!"

    - narrate "You clicked on the item representing day <context.item.flag[day]>"



# No clue if this works XD
#on_player_joins:
#  type: world
#  events:
#    on player joins:
#      - repeat <context.item.flag[max_days]> as:n:
#        # If day has already passed
#        - if <[n]> < <context.item.flag[current_day]>:
#          - flag <player> claimed_day:<[n]>
#
#        # Todays day
#        - if <context.item.flag[day]> == <context.item.flag[advent_day]>:
#          - flag <player> advent_day:<context.item.flag[current_day]>

