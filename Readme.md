# myadmin

Adds admin tools, player join rules, curse word detection, chat commands and more to Minetest.


licence - MIT

-------

## Tools

2 tools are included.

`Ultimate Tool` - Removes node right away with no delay and no wear. Items do not go into inventory.<br/>
To get the tool use `/giveme ut`

`Ultimate Tool (Drops)` - Same as `Ultimate Tool` but nodes go into your inventory.<br/>
To get the tool use `/giveme utd`.


## Chats

These are fun little chat commands. They include things like `/afk`, `/back`, `/bbl`, `/happy`, `/sad`, `/mad`.

You can get a full list of the commands by using `/chats`.

## Curse Words

This is a list of words that are banned on the server. These words can be edited in the `settings.txt` file.


## Privs

The privs part is a set of privs for different levels of players.

The levels are
- Super Admin
- Admin
- Moderator
- Helper
- Normal Player
- Punish
- Unpunish
- Silence
- Ghost

To get the available commands use `/myadmin_commands`.<br/>
Super Admin is not in the list because it is reserved for above Admin, not all privs.


## Spawn

Spawn is an easy way to set spawn locations. In the `settings.txt` file you can set the chat command and coordinates for the spawn locations.


## Start

Start is the screen that is shown to new players when they join the server. You can list the rules in `rules.txt`. The player then can agree to the rules or not.<br/>
If the player does not agree to the rules then they will be kicked from the server.


## Extras

Extras are extra neat things that I would like to see on servers. Right now there is only one extra but I plan on adding more.

Set the size of the hotbar with `/setbar`. You can set it to `1` - `16`.


## Names Per IP

This is the `names_per_ip` mod from Krock. It limits the number of accounts that each IP address can have.<br/>
This is set in the `settings.txt`.


## Guest

There is a setting to decide if you want to allow names with `guest` in them.<br/>
This is set in the `settings.txt`.


## Password

A setting in the `settings.txt` allows you to set whether or not you allow empty passwords.<br/>
This can be set in `minetest.conf` file as well.


## Underworld

This might not fit in this mod but I added it here anyway.

This is a teleporter that when set also places a teleporter below at what ever height you set it at.<br/>
Place a teleporter and a form opens. Name the teleporter and set the depth of the other. Click `Set`.<br/>
When you step into the teleporter you will teleport down. After 10 seconds you can use the teleporter again.<br/>

You need the `myadmin_levels_super` priv to place and destroy the teleporters.
