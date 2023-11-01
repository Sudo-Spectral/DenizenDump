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

  - repeat <[max_days]> as:n:
    #If loop index lesser than current day = alr claimed
    - if <[n]> < <[current_day]>:
      - define item <item[opened]>
    #if equal, current day ADD COOLDOWN FLAG?
    - else if <[n]> == <[current_day]>:
      #- define item <item[current]>
      # If player has claimed_Day flag equal to current day
      - if <[n]> == <[claimed_day]>:
      # Has claimed
        - define item <item[opened]>
        - narrate Claimed!
      - else:
      # Not claimed
        - define item <item[current]>
        - narrate Unclaimed!
    #If the loop index greater, appears unavailable
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





        - inventory close
      - else:
      # Incorrect day to claim prize
        - narrate "WRONG DAY"

    - narrate "You clicked on the item representing day <context.item.flag[day]>"
