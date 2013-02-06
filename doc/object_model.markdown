Object Model Reference
======================

### CARPE DIEM v2000.11.10

* * * * *

Introduction
------------

This document aims to be a brief but comprehensive overview and help
guide to the object networks used in the [CARPE
DIEM](http://www.catseye.mb.ca/games/carpe/) roguelike game engine.

It is certainly incomplete and inaccurate in places, but is better than
no documentation at all (knock on wood.) All information contained
herein is subject to change, in terms of interface, naming, and
implementation. Interfaces marked with **(???)** are extremely likely to
change.

Object Framework
----------------

Members on objects are of two basic types: *methods*, which are Perl
functions, and *attributes*, which are mutable data members.

Kinds of methods include: *derivations* which return a value only;
*mutations* which change the state of the object (and which may or may
not return a value); and *constructors*, which return a new object while
not changing the state of the old object (if any.) Constructors which
create a new object based on an old object are sometimes called
*factories*.

Kinds of attributes include *event handlers*, which are like methods in
that they are executable. Names of event handlers always begin with
`on_`, and their data type is always a string (which is usually simply
`eval`uated by Perl's built-in mechanism.)

Part I. Utility Classes
-----------------------

-   **Dice** - objects which can be rolled to yield a random integer
-   **Distribution** - objects which can be picked to yield a random
    object
-   **Fuses** - objects which maintain sequences of arbitrary future
    events

### Dice

-   Dice-\>new(*\$count*, *\$faces*, [*\$bonus*]) \
    Creates and returns a new Dice object with the given attributes.
-   *\$dice*-\>improve(*+\$integer*) **(??? adjust\_plus)** \
    Returns a new Dice object with an altered 'plus' bonus modifier.
    This does not affect the given *\$dice* object.
-   *\$dice*-\>improve\_faces(*\$factor*) **(??? scale\_faces)** \
    Returns a new Dice object with its faces altered by a factor. This
    does not affect the given *\$dice* object.

    Derivations

-   *\$dice*-\>roll \
    Returns a random integer, the range and frequency distribution of
    which is determined by the number of dice, the number of faces on
    each die, and a 'plus' bonus modifier.

    Attributes

-   *\$dice*-\>{count} \
    The number of dice the object represents.
-   *\$dice*-\>{faces} \
    The number of faces represented on each die.
-   *\$dice*-\>{plus} \
    The bonus modifier added to the basic dice roll.

### Distribution

-   Distribution-\>new(*\$probability* =\> *\$object*, ...) \
    Creates and returns a new Distribution object with the given
    probability-to-object associations.

    Derivations

-   *\$distribution*-\>pick \
    Returns a random object, the frequency distribution of which is
    determined by the Distribution object's probability percentages.

    Mutations

-   *\$distribution*-\>scale(*\$factor*) **(??? scale\_probabilities)**
    \
    Alters all of the Distribution object's probability percentages by
    *\$factor*, a rational number.

### Fuses

-   Fuses-\>new() \
    Creates and returns a new, empty Fuses object. Generally speaking,
    only one Fuses object is required for the entire engine.

    Derivations

-   Fuses-\>current() \
    Returns a reference to a hashtable which describes the currently
    expiring fuse; used in scripts set up in fuses to modify the fuse
    for the next pass.

    Mutations

-   *\$fuses*-\>tick \
    Causes all expired fuses to fire, and all non-expired fuses to come
    one time unit closer to firing.
-   *\$fuses*-\>add(*\$script*, *\$fuse\_duration*, *\\@argument*)
    **(??? name)** \
    Adds a new fuse to the Fuses object.

Part II. Multiple Superclasses
------------------------------

-   **Physical** - objects with a physical presence
-   **Cloneable** - objects which can be copied and bred
-   **Saveable** - objects which can be loaded and saved

Constructors

These object classes do not have constructors.

### Physical

-   *\$physical*-\>accusative \
    Returns the appropriate accusative pronoun (him, her, it.)
    Occurances of `<him>` in format strings is replaced by this.
-   *\$physical*-\>possessive \
    Returns the appropriate possessive pronoun (his, her, its.)
    Occurances of `<his>` in format strings is replaced by this.
-   *\$physical*-\>plural **(???)** \
    Returns the plural form of the name of the Physical object in
    question.
-   *\$physical*-\>dist(*\$physical*) \
    Returns the distance between the two Physical objects in question.
-   *\$physical*-\>in\_bounds([*\$x*, *\$y*]) \
    Returns a boolean value indicating whether this Physical object (or
    the given (*x*,*y*) coordinates, if any,) is within the bounds of
    it's Region object indicated in {location}.
-   *\$physical*-\>screenx() | -\>screeny() \
    Returns the *x*- (or *y*-) position on the screen where this
    Physical object would be displayed.

    Mutations

-   *\$physical*-\>display() \
    Redraws the Physical object on the screen if it happens to be in the
    line of sight of the leader.
-   *\$physical*-\>undisplay() \
    Erases the Physical object from the screen.
-   *\$physical*-\>seen(*\$physical*, "message") \
    Broadcasts an action taken by the Physical object to every receiving
    Physical object within line of sight and range.
-   *\$physical*-\>hurt(*\$force*, *\$perpetrator*, *\$body\_part*) \
    Causes the Physical object to take damage. The amount of damage is
    indicated by \$force, and the Actor which is causing the damage
    receives experience points, if any, should the Physical object be
    destroyed.
-   *\$physical*-\>heal(*\$force*, *\$perpetrator*, *\$body\_part*) \
    Opposite of hurt. Not really implemented.

    Attributes

-   *\$physical*-\>{name} \
    String containing the conversational name of the object.
-   *\$physical*-\>{identity} \
    String containing the secret identity of the object.
-   *\$physical*-\>{sex} \
    String containing the sex of the object; must currently be only one
    of: 'Male', 'Female', or 'Neuter'.
-   *\$physical*-\>{proper} \
    Boolean indicating whether the object has a proper name.
-   *\$physical*-\>{damage} \
    A Force object which indicates the potential damage caused to an
    opponent when this Physical object is used as a melee weapon.
-   *\$physical*-\>{projectile} \
    A Force object which indicates the potential damage caused to an
    opponent when this Physical object is used as a thrown (not
    launched) weapon. (Launching weapons use a version of this Force
    modified via \$force-\>{dice}-\>improve\_faces().)
-   *\$item*-\>{hitbonus} **(??? accuracy, Dice)** \
    An integer which indicates the accuracy bonus gained by this
    Physical object (be it an Item or an Actor) in combat (be it melee
    or missile.)
-   *\$physical*-\>{displayed} **(??? \_displayed)** \
    A boolean indicating whether this Physical object is already
    displayed on the screen, altered by the `display` and `undisplay`
    methods.
-   *\$physical*-\>{lightsource} **(??? light\_range, light\_duration)**
    \
    A boolean indicating whether this Physical object acts as a source
    of light.
-   *\$physical*-\>{count} \
    An integer which indicates how many instances of the same Physical
    object represents. For example, a single Physical object can
    represent a group of a dozen arrows, as long as the arrows do not
    differ from each other in any way.
-   *\$physical*-\>{magic} **(??? A:is\_magical)** \
    A boolean which indicates whether this Physical object is magical.
-   *\$physical*-\>{curse} **(??? A:is\_cursed, on\_remove)** \
    A boolean which indicates whether this Physical object is cursed.
-   *\$physical*-\>{lore} **(???)** \
    A string which contains some background information about the
    Physical object.
-   *\$physical*-\>{weight} \
    An integer which indicates how heavy this Physical object is
    (assuming {count} is 1; to get the weight of the entire group
    multiply {count} by {weight}.)
-   *\$physical*-\>{aeroweight} **(??? drag\_coefficient)** \
    An integer which indicates the effective weight of this Physical
    object when it is thrown (tweaked due to aerodynamics, throwing
    motion, etc.)
-   *\$physical*-\>{indestructible} **(??? on\_destroy)** \
    A boolean indicating that the Physical object cannot be destroyed,
    typically found on edge walls in dungeons.
-   *\$physical*-\>{durability} **(??? {max}{constitution})** \
    A boolean indicating how much damage the Physical object can at most
    sustain before it is destroyed.
-   *\$physical*-\>{condition} **(??? {op}{constitution})** \
    A boolean indicating how much damage the Physical object can
    currently sustain before it is destroyed.
-   *\$physical*-\>{resists} \
    A Resistances object, which describes which forces this Physical
    object is resistant or subsceptible to.
-   *\$physical*-\>{location} \
    The Region object where this Physical object is located, if 'on the
    ground' and not being carried by an Actor.
-   *\$physical*-\>{x} | -\>{y} \
    The *x* (or *y*) coordinate of the Physical object, relative to the
    map in the object's {location} Region object.
-   *\$physical*-\>{appearance} \
    A string which exists as a key in the global appearance table
    `%::sc`. Usually a fairly generic name like 'dragon' or 'fruit' will
    be found here.
-   *\$physical*-\>{color} **(??? background, transparent)** \
    A string which exists as a key in the global color table.

Physical Classes
----------------

All of these classes are subclasses of Physical (among other things.) As
such, they inherit the methods and attributes of Physical objects as
described above.

-   **Actor** - objects with agency
-   **Item** - objects which can be carried
-   **Terrain** - objects which be travelled on/around

### Actor

-   undocumented

    Derivations

-   *\$actor*-\>has(*\$object*) \
    Determines whether the Actor object possesses a certain object (an
    Item or a Talent.) Returns said object if it is possessed, or
    `undef` if not. Talents are compared by name. Items are compared by
    full identity. If the Item argument has a {count}, then the Item in
    the Actor's inventory must be at least that {count}.

    Attributes

-   *\$actor*-\>{hair\_type} | -\>{eye\_type} | -\>{skin\_type} \
    Strings containing the short descriptions of the physical attributes
    of this Actor.
-   *\$actor*-\>{hair\_color} | -\>{eye\_color} | -\>{skin\_color} \
    Strings containing the color descriptions of the physical attributes
    of this Actor. These can map to screen colors for player characters.
-   *\$actor*-\>{race} \
    String containing the name of the race of beings to which this Actor
    belongs. Not implemented particularly strongly.
-   *\$actor*-\>{carcass} **(??? on\_death)** \
    Boolean indicating whether this Actor leaves a carcass after it's
    death.

          'lit'            => 0,  # value *derived* from holding light source
          'incapacitated'  => 0,  # value *derived* from operating stats

-   *\$actor*-\>{*effect*} **(???)** \
    Integer indicating how many turns of *effect* are left to apply to
    this Actor. *Effect* may be one of: 'blind', 'deaf', 'dumb',
    'confused', 'paralyzed', 'placid', and 'blurry'.
-   *\$actor*-\>{*bodypart*} \
    Item which is currently being wielded on the given body part.
    *Bodypart* may be one of: 'head', 'neck', 'shoulders', 'arms',
    'rwrist', 'lwrist', 'hands', 'rfinger', 'lfinger', 'rhand', 'lhand',
    'torso', 'waist', 'legs', 'rankle', 'lankle', and 'feet'.
-   *\$actor*-\>{totalhits} \
    Integer measurement of the total number of damaging hits this Actor
    has taken, for statistical purposes.
-   *\$actor*-\>{blockedhits} \
    Integer measurement of the total number of hits this Actor has
    sucessfully blocked, for statistical purposes.
-   *\$actor*-\>{totalswings} \
    Integer measurement of the total number of attacks (hit or miss)
    this Actor has made, for statistical purposes.
-   *\$actor*-\>{damagingswings} \
    Integer measurement of the total number of damaging attacks Actor
    has sucessfully made, for statistical purposes.
-   *\$actor*-\>{party} \
    Party object to which the Actor belongs.
-   *\$actor*-\>{encounter} \
    Encounter object which is started when another Actor interacts with
    this Actor.
-   *\$actor*-\>{target} \
    Actor object which is this current target of this Actor.

          'combat'         => 'Attack',  # some creatures will Flee or Bargain instead
          'noncombat'      => 'Wander',
          'body_aim'       => 'dumb_biped',
          'experience'     => 0,
          'belongings'     => [],
          'talents'        => [],
          'domhand'        => 'rhand',
          'on_move'        => '',

-   *\$actor*-\>{max}{*stat*} \
    Integer maximum stat for this Actor. *Stat* may be one of:
    'strength', 'constitution', 'dexterity', 'intelligence', 'spirit',
    and 'charisma'.
-   *\$actor*-\>{op}{*stat*} \
    Integer operating (current) stat for this Actor. *Stat* may be one
    of: 'strength', 'constitution', 'dexterity', 'intelligence',
    'spirit', and 'charisma'.

    Mutations

-   *\$actor*-\>heal\_all() \
    Sets the operating stats of the Actor to the maximum stats of the
    Actor.
-   *\$actor*-\>remove\_talents() \
    Remove all Talents with a skill level of 0% or less from this Actor.
-   *\$actor*-\>adjust(*\$stat*, *\$delta*) \
    Change an operating stat by a certain amount, possibly killing the
    Actor in the process.
-   others undocumented

    Attributes

-   undocumented

### Item

-   *\$item*-\>bunch(*\$integer*) \
    Returns a new Item object with its {count} set to a specific
    integer. This does not affect the given *\$item* object.

    Derivations

-   *\$item*-\>combinable(*\$item*) \
    Returns a boolean indicating whether the two Item objects are
    identical (and can be combined into a single Item by adding their
    counts together.)

    Mutations

-   *\$item*-\>identify \
    Reveals the secret identity of this Item, setting the conversational
    name of it to the same.
-   *\$item*-\>perceive\_value(*\$item*) \
    Causes this Item object to be perceived to be priced by a certain
    number of other Item objects, by it's owner.
-   *\$item*-\>useup(\$consumer, [\$delta]) **(???)** \
    Causes a certain number of this Item object to be used up in some
    way by an Actor object. Dangerously ambiguous, needs clarification.
-   *\$item*-\>usemissile(\$consumer???) **(???)** \
    Causes one of this Item object to be used up in a missile-weapons
    way by an Actor object. Dangerously ambiguous, needs clarification.
-   *\$item*-\>use(\$actor) \
    Causes this Item object to be used by it's owner. This will activate
    it's {talent}, or the {on\_use} event if the talent is not provided.

    Attributes

-   *\$item*-\>{worn\_on} \
    A dictionary, mapping the body parts that this Item can be worn on
    as clothing or armor, to while body parts they cover when worn. Not
    fully implemented yet.
-   *\$item*-\>{written} **(??? A:is\_readable)** \
    A boolean indicating whether this Item can be read.
-   *\$item*-\>{food} **(??? A:is\_edible | is\_consumable)** \
    A boolean indicating whether this Item can be eaten.
-   *\$item*-\>{beverage} **(??? A:is\_drinkable | is\_consumable)** \
    A boolean indicating whether this Item can be drunk.
-   *\$item*-\>{body} **(??? A:is\_bodily)** \
    A boolean indicating whether this Item is part of its possessor's
    body. If this is the case, it will not be dropped after the Actor's
    death.
-   *\$item*-\>{defense} **(??? worn\_on -\> covers -\> composition)** \
    An integer which indicates the defense capability of this Item when
    worn.
-   *\$item*-\>{charges} **(??? fuel)** \
    An integer which indicates how many charges this Item has left
    (wands and so forth.)
-   *\$item*-\>{talent} **(??? consume\_talent, on\_use etc)** \
    A Talent object which indicates what thing this Item does when used
    or consumed (in the absence of any on\_use or on\_consume event).
-   *\$item*-\>{value} **(??? \_value)** \
    An Item object which indicates what the owner of this Item thinks it
    is worth.
-   *\$item*-\>{soul} \
    An Actor object which represents the essence of a being encapsulated
    in this Item (figurines, pocket-monster cards, genies in lamps,
    etc.)

    Event Handlers

-   *\$item*-\>{on\_wear} \
    This event is triggered when an Actor puts on or takes off this
    Item.
-   *\$item*-\>{on\_consume} \
    This event is triggered when an Actor consumes (eats, drinks,
    applies) this Item.
-   *\$item*-\>{on\_use} \
    This event is triggered when an Actor uses this Item.
-   *\$item*-\>{on\_land} \
    This event is triggered after this Item is thrown or fired.
-   *\$item*-\>{on\_strike} \
    This event is triggered after this Item strikes someting in melee
    combat.
-   *\$item*-\>{on\_struck} \
    This event is triggered after this Item is struck by something.

### Terrain

-   undocumented

Non-Physical Classes
--------------------

-   **Talent** - skills or magic employed by objects
-   **Region** - objects which maintain maps of objects
-   **Encounter** - objects which describe meetings and surprises

### Talent

-   *\$talent*-\>{on\_perform} \
    Script which is called when the Talent object is performed.
-   others undocumented

### Region

-   *\$region*-\>{name} \
    String containing the name of the Region.
-   *\$region*-\>{genpattern} \
    Establishes the logic used to fill out an unfilled Region object
    with random Terrain objects. Allowable genpatterns are:
    -   `random` - noise
    -   `accretion` - natural terrain
    -   `recursive` - unnatural terrain
    -   `canned` - based on provided map
    -   `dungeon` - room-and-hallway excavation
    -   `gradient` - gradient between several different distributions

-   *\$region*-\>{generated} \
    A boolean indicating whether terrain for this Region has been
    generated yet.
-   *\$region*-\>{sizex} | -\>{sizey} \
    Integers indicating how many cells wide/tall this Region is.
-   *\$region*-\>{offsetx} | -\>{offsety} \
    Integers indicating the scrolled position of the map of this Region
    when displayed.
-   *\$region*-\>{worldx} | -\>{worldy} \
    Integer coordinates indicating this Region's position in the world
    map.

          'map'          => [],
          'lit'          => [],
          'actors'       => [],
          '_collmap'     => [],
          'outside'      => $::sc{dark},
          'border'       => undef,
          'ambient'      => undef,
          'terraind'     => undef,
          'terrgradn'    => undef,
          'terrgrads'    => undef,
          'terrgrade'    => undef,
          'terrgradw'    => undef,
          'monsterd'     => undef,
          'itemd'        => undef,
          'music'        => '',
          'msg'          => '',
          'template'     => '',
          'legend'       => '',

-   others undocumented

### Encounter

-   Encounter-\>new() \
    Basic constructor.
-   Encounter-\>auto(*\$actor*) \
    Automatic constructor.

    Mutations

-   *\$encounter*-\>begin() \
    Causes the Encounter to begin, displaying menus with which the user
    can interact with the Actor(s).
-   *\$encounter*-\>attack() \
    Called by begin(), causes the Encounter to degrade into attack.

    Attributes

-   *\$encounter*-\>{actors} \
    A reference to an array of Actor objects who are hosting this
    Encounter. When the Encounter is attached to an Actor in the first
    place, that Actor is automatically injected into this list.
-   *\$encounter*-\>{message} \
    A string displayed upon initiation of the Encounter.
-   *\$encounter*-\>{lore} \
    A string displayed upon friendly communications.
-   *\$encounter*-\>{persistent} \
    A boolean indicating whether the Encounter is persistent. If it is
    not persistent, it is removed after it is activated.
-   *\$encounter*-\>{friendly} \
    A boolean indicating whether the Encounter is friendly.
-   *\$encounter*-\>{itemseller} **(??? on Actor)** \
    A boolean indicating whether the host of the Encounter is willing to
    sell items.
-   *\$encounter*-\>{itembuyer} **(??? on Actor)** \
    A boolean indicating whether the host of the Encounter is willing to
    buy items.
-   *\$encounter*-\>{serviceseller} **(??? on Actor)** \
    A boolean indicating whether the host of the Encounter is willing to
    sell services (Talent applications).
-   *\$encounter*-\>{servicebuyer} **(??? on Actor)** \
    A boolean indicating whether the host of the Encounter is willing to
    buy services.

