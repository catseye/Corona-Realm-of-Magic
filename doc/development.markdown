Development Notes
=================

### CARPE DIEM v2000.12.04

* * * * *

Caveats
-------

### Known Bugs

Loading a saved game does not restore the entire game, only the Region
that the leader is currently in.

### Gotchas

Is not really a game yet. Things may seem too hard, or too easy.
Keybindings may seem awkward and are subject to change.

Certainly storing the data for all Regions in Perl's perception of the
'core' will stress virtual memory to inhuman extremes.

Loading and saving the game are **slow** and produce **huge** saved-game
files! Plus there are bugs involved with loading a game.

Mixing spells can result in unpredictable effects, such as permanency of
a spell effect.

Travelling from one region to another, especially one filled with a
large amount of unpassable Terrain (such as ocean,) can cause the
character so travelling to become 'lost at sea.'

### Operating Systems

-   Windows 98 and ActivePerl 5.6

    Arrow keys do not navigate.

    carpe.pl seems to run somewhat more quickly and smoothly when
    started from the command line (start an MS-DOS prompt, then type
    'perl carpe.pl') instead of when double-clicking 'carpe.pl'. Almost
    surely a Windows/ActivePerl memory/console/performance setting
    thing.

-   FreeBSD (4.0-RELEASE) and Perl 5.005:

    Using a Video BIOS subsystem which uses a custom font on boot (such
    as for displaying an "Energy Star compliant" logo) under FreeBSD may
    make some on-screen characters look strange while playing the game,
    because AFAICT FreeBSD doesn't reset the textmode font to the OEM
    one.

    The keystroke \^M cannot be bound (always results in \^J.) This
    might or might not apply under Linux and SCO as well.

To-Do List
----------

1.  Reflex skills at thrown/fired weapons, shield use.
2.  Armour and weapons should occasionally be damaged.
3.  Implement the actions 'sleep', 'climb', 'run', 'yell'.
4.  Physical makeup in one list of adjectivals (for example 'Flesh'),
    damage type in another, seperate list of adjs (e.g. 'crushing'.)
5.  All attacks of items should be used/compared (look for:
    {melee\_attacks}[0].) (two down)
6.  Encumbrance. Should not be able to haul a dozen boulders around
    unless strength is near 40.
7.  Freshness of carcasses and other food. Food preservation.
8.  Split party. Join (merge) parties.
9.  Journal-keeping (quests & other important info) and view.
10. Food, water, starvation, dehydration.
11. Dieties, virtues, vows.
12. Vehicular actors (horses, ships.)
13. Load/Save World/Saveable object definately needs to be correctly
    implemented.

History
-------

v2000.10.05

-   first public release

v2000.10.08

-   7-bit ASCII set completed,
-   16 colour display under ANSI,
-   Resistances to forces (slightly wrong, but there.)
-   Regions created on-the-fly.

v2000.10.10

-   Default boilerplate for naming characters, parties.
-   Regions border one another.
-   Only able to see creatures nearby, not anywhere.
-   Able to see nearby creatures attacking one another.
-   Charm spell, adds monsters to your party
-   How closely party members follow the leader depends on the leader's
    charisma
-   Moved many world-dependent definitions into world/

v2000.10.12

-   Added Region generation style capability.
-   Generation styles 'random', 'accretion', and 'recursive'.
-   Fixed bug in Vandalize.
-   Allows vandalizing whatever message you wish.
-   Message on hitting edge of world (for now.)
-   Food is identified upon consume.
-   Equipment is identified upon wield.
-   Item or Talent may be purveyor of hurt(), in which case there is no
    strength bonus (wand of lightning.)
-   Letter shortcuts on menus.
-   Handles ANSI arrow keys. Double-click Escape to cancel menu.

v2000.10.15

-   Double-click Escape to bring up game menu (consistency.)
-   Support for other-than-numberpad direction-pads (Rogue.)
-   Adapted hmaon's AngRogue module into Angband\_Roguelike keymap.
-   Added escape key, long form (type "\\move northwest" to try.)
-   Added mostly-accurate keymaps for Rogue, Hack, and Larn.
-   Arguments to actions - 'Move' menu now works (whee.)
-   Ability to review previous 20-odd messages (usually bound to \^P.)
-   Version synchronization in configuration file.
-   Help screen prettied up ("\* = unimplemented" now implemented.)
-   Rudimentary support for supplementary materials.
-   Support for each Region having it's own background music.

v2000.10.16

-   Fixed bugs under cygwin w.r.t. Win32 modules and POSIX (I hope.)
-   Added 'canned' (pre-designed) region generation (Bakersport.)
-   Cleaned up character display, esp. colors, esp. in Equipment
-   Many body parts for wielded items (wear loincloth on head.)
-   Nonweapon items (such as berries) can be used as weapons.
-   Cleaned up Encounter code (no goto's) - might not crash under Perl
    5.00x

v2000.10.20

-   Added dynamic dungeon creation (Giant Beehives, Dwarkling Hideouts.)
-   Monsters can be unilaterally hostile towards the player's party.
-   Extracted common code of Item, Terrain, Actor to Physical
    superclass.
-   Migrated away from AUTOLOAD routines for sake of performance.
-   Almost all world-definitions in world/ subdirectory.
-   Re-aranged and extended Corona keymap.
-   Actor incapacitated when any stat drops to 0.
-   Message noting items on ground is not repeated during combat.
-   Meaningful color used in character status display.
-   Slightly more realistic experience reward (sum-of-stats.)

v2000.10.24

-   'Attack' and 'Bash' unified.
-   Each Terrain element is aware of it's coordinates and Region.
-   Preferences configurable by menus: wield, actor, bump.
-   Split engine (CARPE DIEM) from game universe (Corona.)
-   Character now has lit seeing range of four squares.
-   Speeded up Region generation (Terrain is cloned on-demand)
-   Extended command introducer in keymap, ':' for ADOM.
-   Fixed bugs which looked beyond edge of map: fleeing or following the
    leader, and searching.
-   Talents are compared by name in Actor-\>has(talent).
-   Key re-assignment while in game ("\\bind M move north" to try.)
-   'impression' view added, used in 'look' at creature.
-   Ability to switch party leader (TAB key.)

v2000.10.25

-   Seperated CARPE DIEM documentation from Corona documentation.
-   Moved title screen and initial equipment from engine to game.
-   Moved specific Encounter definitions from engine to game.
-   Moved list of allowed PC races from engine to game.
-   Different races have different randomly-generated names.
-   Made delayed-usage talents safer under older Perl (5.005.)
-   Made menu hackably configurable (menu/Corona.pm).
-   Added ANSI arrow keys as fallback move commands.
-   States 'blind deaf dumb confused paralyzed placid' reported.
-   Bugs in armour fixed.
-   Statistics now kept on average attack and defense scores.
-   Incapacitation by stat reaching zero now works as expected.

v2000.10.27

-   Name creature now implemented, gives generic Actors proper names.
-   Added 'dungeon' (rougelike) region generation.
-   Added 'primate', 'bovine', 'porcine' symbols.
-   Throw item implemented. Arbitrary (crosshairs) aiming.
-   Range determined by stength vs logarithmic weight.
-   Item's projectile damage seperate from default damage.
-   Missiles bump off of obstacles and injure actors.
-   Exploding missiles disappear after landing.
-   Aerodynamics simulated with 'aeroweight' (may be higher or lower.)
-   Fast, medium, or slow missile animation option.
-   Establishing eval'ed on\_xxx event methods: on\_move, on\_consume,
    etc.
-   Bugs with searching fixed. %hidden hash replaced by on\_reveal
    event.
-   Slightly optimized Distribution objects (sorted upon creation.)
-   Line-of-sight calculations for lighted actors.

v2000.10.30

-   Added dominant hand (right, left, ambidextrous) for humanoids.
-   Displays character's appearance and dominant hand on roll screen.
-   Player Character races described in roll screen.
-   Cleaned up healing code. All stats heal now, faster when resting.
-   Cleaned up guild interface - single method class('class',level).
-   Cleaned up talent code. No effect hash, instead on\_perform event.
-   Object factory for scrolls etc (\$item-\>enchant(\$talent).)
-   Object factory for talents (Talent-\>create(\$terrain).)
-   Object factory for magicked, finely crafted, cursed weapons.
-   Charges on magical items such as wands is now tracked.
-   Blindness (and insufficient light) now prevents: redrawing other
    actors, noting items and obstacles, looking around, reading and
    examining items.
-   Added proficiency levels on talents, fixed learn method.
-   Added lesson points, improving talents through practice.
-   Added capturing souls in items.
-   Fixed bug in message-displaying, now word wraps long messages.
-   Actors only displayed when in line of sight of leader.
-   Confused actors move randomly. Blind NPC's act confused.
-   Confusion prevents reading items. Dumbness prevents reading scrolls.
-   Dumbness prevents using talents with verbal components.

v2000.11.02

-   Added ::script routine for executing scripts in many languages.
-   General-purpose Fuse objects. Set up things to happen later.
-   Material components for talents, which may or may not be consumed.
-   \$physical-\>seen() now uses format string (w/accusative etc.)
    Correct definate/indefinate articles/counts now.
-   Missile weapons as ammunition (arrow-\>bow, bolt-\>X-bow, etc.)
    Launcher affects range and damage (not accuracy yet.)
-   When dropping items, asks for how many to drop. Deprecates 'halve'.
-   Help screen prettied up - better coloring and mnemonics.
-   'yank' now referred to as 'pull'. on\_pull event implemented.
-   Different kinds of poisons and diseases with different effects.
-   HTMLized documentation, added Object Model Reference document.

v2000.11.03

-   Added 'current' fuse method for Fuses object, modified in scripts.
-   Added diseases which pass information back to the current fuse.
-   Fixed bug w.r.t. combining items (needs to be looked at again)
-   Fixed bug in drop (how many.)
-   Fixed bug in posions (etc) which cause constitution to drop below
    zero; this actually results in death now, not just infinite
    incapacitation.
-   Fixed bugs w.r.t. bashing and vandalizing terrain in the dark.
-   Fixed bug allowing characters to jump out of bounds, beyond map.
-   Fixed bug in line-of-sight determination for hostile Actors.
-   Cleaned up \$actor-\>death now displays messages, dispenses
    experience, etc.
-   Moved 'hitbonus', 'on\_strike', 'on\_struck' to Physical object
    superclass.
-   Moved 'los' to Physical object. Cleaned up 'los' and 'seen'.
-   Moved supplementary materials to game universe, not game engine.

v2000.11.05

-   Added 'wield by item' option.
-   Wielded items can now cover many body parts, for two-handed weapons
    and jackets with sleeves.
-   Fixed bugs with removing talents under older (5.00x) Perl.
-   Added 'Please wait' message before loading game module.
-   Implemented 'interact' and 'trade\_places' actions.
-   Not-quite implemented 'sleep' and 'destroy\_item' actions.
-   Fixed bugs with line-of-sight for Items and Talents.
-   Apropos messages when wielding and taking off items.
-   Rudimentary support for adjusting both screen size and map size.

v2000.11.06

-   Adjectivals (Adj superclass of Physical and Force classes.)
-   Routine to 'prep' newly created Actors, sexualizing them, putting
    their main weapon in their dominant hand, and adjusting for any
    magical benefits conferred from wielded items/armour.
-   New on\_open event allows opening and closing of doors and static
    containers like chests.
-   New on\_enter and on\_exit events on Terrain elements.
-   New on\_pickup event on Items allows for various boobytraps.
-   Added 'coastline' Region generation algorithm.
-   Terrain objects now support opacity (0% = fully transparent.)
-   'make' constructor uses Adjectival table to determine new defense
    value, weight, durability etc for Items.
-   Fixed bugs in: Fuses object, Party view, Enter action, carcass
    creation, initial belongings of Actors.

v2000.11.10

-   Physical objects handle composition (via condition, durability, hurt
    method.)
-   Composition is expressed as a list of Adjectivals (which may imply
    other Adjectivals.)
-   Attack object. Support for multiple attacks (which cease if the
    defender is killed), attacks which can only be attempted if n
    previous attacks succeeded, attacks which automatically succeed if n
    previous attacks succeeded, on\_strike event handler, individual
    identity (cloned) on attacks.
-   \$actor-\>choose\_item takes a list of Adjectival objects as an
    'OR'ed filter.
-   Magic, cursed, written, edible, liquid, type of instrument, and type
    of missile ammunition, are all Adjectivals.
-   \$actor-\>learn improves, degrades, and removes Talents, as well as
    acquiring them.
-   Ambidextrous characters are able to switch stance (switch\_stance
    action).
-   Report of Items seen on Terrain square now in single message.
-   Full or short body part menu in wield. Body parts always have same
    letters in full menu. Short menu only shows body parts which are
    vacant.
-   Implemented 'push' and 'destroy\_item' actions.
-   Resistances can be specified with Adjectivals.
-   \$physical-\>alter\_resistances does for Resistances what learn does
    for Talents.
-   Cleaned up message display (erased when no messages pending that
    turn.)
-   Actors can dodge missiles (5%/DEX point, sliding, no automatic
    successes.)
-   The make() constructor, now located in the Physical class, bestows
    resistances from Adjectivals.
-   Smarter NPC's don't attack each other when blocked from their
    target.
-   Reworked supplementary materials interface, uses web browser and
    connects to IP network to retrieve multimedia objects (images,
    music, etc.)
-   Supplementary materials, keymap, and location of web browser are
    preferences, not configuration options.
-   Ability to save preferences to user prefs file added.
-   New action 'repeat\_action' (bound to '.' in the Corona keymap)
    repeats an action until the leader notices something new.
-   Added sentinel to detect when 100 moves have passed with no user
    input, pops up a menu to ask what to do (needed to handle otherwise
    infinite loops caused by repeat.)
-   Explosion, fire, cold damage etc, are not subject to strength bonus,
    only crushing, cutting, and piercing (kinetic attacks).
-   Character background influences initial equipment, belongings,
    talents, and start location.
-   Added Curses display abstraction, requires Curses for Perl module be
    installed.
-   Clear to EOL and refresh display interfaces in virtual console.
-   Created SemiOEM symbolset for SCO Unix and Curses (can't display
    ASCII \< 32.)

v2000.11.12

-   Fixed bugs in automatically creating two-way portals back from
    newly-created dungeons.
-   Fixed bugs in tombstone-drawing routine and Win32 clreol routine.
-   Encounter -\> Buy Services. Added support for guilds and training.
-   Encounter -\> Sell Items. Encounter -\> Bribe.
-   Fixed fleeing encounter, getting away, getting initiative if
    situation decays into combat.
-   Encounter -\> Negotiate logic for individual creatures.
-   Monogrammed items which are forced to always show up with a given
    letter in menus.
-   Menu object w/erase background, etc which supports the above.
-   Boolean passed to 'put\_on' that redirects to 'take' if Actor
    already has one on.
-   Improved reviewing previous messages. Added Messages view. View
    meta-action takes arguments.
-   Fixed small bugs in help screen and cloning items.
-   Better redirection of actions (esp. move -\> interact and bash) on
    bump.

v2000.11.19

-   Added color to Curses display abstraction, made initial setup easier
    (default abstraction is Curses if it's installed.)
-   Fixed bugs in redirection of 'move' w.r.t. travelling from Region to
    Region.
-   Added 'freeze channels' to Fuses so that magic can progress in
    orderly fashion.
-   Hostile creatures and party members now pursue their targets/leaders
    from Region to Region.
-   Implemented View Guilds, shows ranking attained in each guild.
-   \$physical-\>throw routine supplies animation for both weapons and
    spells.
-   NPC's fall asleep, wake up, and do not move when sleeping.
-   Improved armour system for realism (coverage factors.)

v2000.12.04

-   Allowed for recharging talents (creature "once per day" type
    talents, magic artefacts)
-   Diseased and poisoned terrain floors are now a constructor.
-   Terrain squares use adjectivals for composition. 'water' field on
    Terrain objects replaced with adjectival.
-   Movement through terrain is now relative to actor's aquatic,
    airborne, or ethereal nature.
-   Fixed bugs w.r.t. cloning talents upon Actor prep.
-   on\_consider event on Talent objects allows for smarter choice of
    talents by creatures.
-   Tracking of game time in Party view.
-   Better portrayal of confusion, affects moving, attacking,
    interacting, and looking around more thoroughly.
-   Support for unique Actors, Items, and Terrain squares during Region
    generation.
-   Talents with moves greater than zero (e.g. calisthenics) no longer
    automatically succeed.
-   When a party member dies, it is now removed from the party roster.
-   Absolutely-trapped party members following leader no longer cause
    game to hang.
-   Automatically-created 'dungeon' levels now have more apropos exits
    (not always ascending staircases.)
-   Reflex skills such as proficiency at melee weapons and armour use
    (cover head etc).
-   Fixed bugs in armour coverage roll.
-   Added rudimentary 'Save World' and 'Load World' functionalities.

