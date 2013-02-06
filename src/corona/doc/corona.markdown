Corona
======

### Realm of Magic

* * * * *

(c)2000 Cat's Eye Technologies. All rights reserved.  
This software is OSI Certified Open Source Software.  
See the file [license.txt](license.txt) for license information.

Documentation
-------------

### Introduction

**Corona: Realm of Magic** is a rogue-like computer role-playing game.

It serves as a platform on which the author can air his opinions about
rogue-like games.

Many games throughout history have inspired and otherwise fed into
**Corona**: the "old-school" games like Wumpus, Colossal
Cave[/Adventure], and Dungeon[/Zork]; the classic roguelikes like Rogue
itself, [Net]Hack, Moria[/Angband], as well as more recent roguelikes
like AlphaMan, ZZT[/Megazeux] and ADOM; commercial CRPG's have some
influence on it as well, from earlier game series like Ultima, Bard's
Tale, and Pool of Radiance, to more recent ones like Final Fantasy,
Dungeon Master [Amiga], and Diablo.

Corona is built on the [CARPE DIEM](../../doc/index.html) game engine.
(In fact CARPE DIEM evolved out of the original Corona.)

### Game Overview

You command a band (or bands) of adventurers who set out to find fame,
fortune, riches, experience, and excitement in a relatively open-ended
fashion.

### The World

**Corona: Realm of Magoc** is set in a large fantasy universe, primarily
on a newly- colonized and largely-unexplored continent where magic
forces abound and various groups vy for power.

Civilization has barely yet gotten a foothold on this world that the
explorers call Aelia, the new world, and the residents call Q'lob
Stehlm, their ancestral homeland.

The larger settlements, like Bakersport and Saiphan, have become walled
cities, keeping the noblemen and women safe from the rampaging hordes of
grotesques and spririts, but leaving the farmers and peasants in the
surrounding countryside without support; only their savvy and pioneer
spirit remain to help protect them.

Meanwhile the nomadic native creatures are adapting to this intrusion,
forming camps and strongholds of their own, as their far-superior
knowledge of the countryside allows them to conceal their machinations
extremely effectively.

* * * * *

### Ability Stats

All creatures, monsters and characters alike, have important attributes
which are generated randomly upon their creation. These attributes are
called *ability stats* and are chosen for human beings as the sum of
three six-sided dice rolls (rolls for other beings are usually based on
this as well, with certain tradeoffs.)

Each creature has a maximum value for each stat, as well as an operating
value. An operating value lower than a maximum value indicates that the
creature has sustained some manner of injury, be it physical, mental, or
spiritual. When allowed to rest, operating stats will tend to heal back
towards (but not beyond) the maximum stat. Operating stats can also be
boosted above the maximum stat temporarily; they will fall back to the
maximum stat in time.

The stats are:

-   STRENGTH. A measure of the raw muscular strength of the creature.
    Extreme pain and weakening agents such as poisons subtract from
    operating strength. An operating strength of zero indicates a
    creature is too weak to move. A negative operating strength will
    kill a creature by means of complete muscular atrophy.
-   CONSTITUTION. A measure of the physical makeup and endurance of the
    creature. Physical damage subtracts from operating constitution. An
    operating constitution of zero indicates a creature is too wounded
    to move. A negative operating constitution will kill a creature by
    means of fatal wounding.
-   DEXTERITY. A measure of the agility and overall swiftness of the
    creature. Constriction and cold attacks subtract from operating
    dexterity. An operating dexterity of zero indicates a creature is
    too constricted or frozen to move. A negative operating dexterity
    will kill a creature by means of strangulation or crushing.
-   INTELLIGENCE. A measure of the overall reasoning capabilities of the
    creature. Psychic attacks and critical head hits subtract from
    operating intelligence. An operating intelligence of zero indicates
    a creature is too senseless or brain-damaged to move. A negative
    operating intelligence will kill a creature by means of brain death.
-   SPIRIT. A measure of the overall spiritual balance of the creature,
    also related to the awareness, alacrity, and ego of the creature in
    general. Casting commonplace magical spells subtract from operating
    spirit. An operating spirit of zero indicates a creature is too
    exhausted or depressed to move. A negative operating spirit may
    subtract from the creature's maximum constitution.
-   CHARISMA. A measure of the likeableness and natural ease with the
    creature interacts with others, also related to the cunning of the
    creature. Peer/community pressure, disfiguring (acid) attacks, and
    acquiring unpleasant scents subtract from operating charisma. An
    operating charisma of zero indicates a creature is too bitter and
    twisted to do anything except inspire fear and loathing on sight. A
    negative operating charisma cannot be achieved.

### Combat System

#### Melee Weapons

A character may only engage in melee with a weapon in their dominant
hand unless they have a talent at two-handed combat. Ambidextrous
characters may change what their dominant hand is at any time by
switching stance. Without a weapon readied in the dominant hand, a
creature will use its body weaponry (which in the case of humanoids
consists by default of a single punch.)

A weapon has one or more attacks. For each attack several values are
associated: the accuracy of the attack (bonus modifier added to the
to-hit roll,) the potental damage (as dice with a bonus modifier,) and
the makeup of the damaging blow in terms of elements, for determining
scaled damage based on resistance.

In addition, the item itself is made of up elements. These elements
determine (upon object creation) various properties of the weapon
itself. These properties include color, density (scale of weight), and
hardness (implemented as resistances on the item itself.)

A reflexive talent of weapon proficiency may be acquired and improved
for each class of weapon (sword, quarterstaff, and so forth.) A
successful use of this talent effectively gives the character a second
to-hit roll.

#### Armour

Armour, which includes clothing, are items which can be wielded on
places other the hands.

Each piece of armour has a coverage value, which is the percent of the
region it is worn on that it protects. It also has a condition value
which describes how damaged it is.

In addition, the item itself is made of up elements. These elements
determine (upon object creation) various properties of the armour
itself. These properties include color, density (scale of weight), and
hardness (implemented as resistances on the item itself.)

Initial condition (durability) is derived from weight (base weight times
density.) Each strike of weapon on armour damages both the weapon and
the armour. Each is subject to resistance from the other based on the
elements in play.

A reflexive talent of armour use may be acquired and improved. for each
class of weapon (sword, quarterstaff, and so forth.) A successful use of
this talent effectively lets the roll on coverage to be taken again.

### Guilds

The residents of Aelia are no strangers to the idea of the division of
labour. Many organizations, both religious and secular in nature,
attract many adventurers who rise up their ranks in their pursuit of
fame, power, and riches. These guilds provide training and standing for
their members, for a fee.

Training involves both physical and personal development, as well as
acquiring and improving talents.

With respect to personal training, each guild is associated with an
ability stat called the prime desired stat. Some guilds also have
another ability stat called the secondary desired stat. As a character
climbs the ranks of a guild, at a rate determined by the guild, they are
offered the opportunity to permanently enhance these ability stats.

With respect to learning talents, each guild protects a set of skills
which it grants to its members as they rise in rank. While the use of
these talents is not restricted to guild members, some are protected by
the guild, such that the costs or chances of non-members acquiring them
are prohibitive. Each talent is only available at a certain guild rank
and above. Once acquired, the talent may also be improved in lieu of
learning a new talent (if one is available.)

#### The Basic Six Adventurer Guilds

-   SOLDIER. Warriors who are used to looking at the world from behind
    the haft of a drawn blade. It's not a pleasant or easy job but
    there's rarely a problem finding work.

    The prime desired stat of the soldier is strength. Soldier talents
    include combat theory, assorted physical conditioning skills, weapon
    and armour familiarity, assorted combat manouevers, and some defense
    and survival techniques.

-   RANGER. Patrolmen who are relied upon to scout and explore the
    wilderness, often on horseback. Esteemed for upholding the "tough
    cookie" image through thick and thin.

    The prime desired stat of the ranger is constitution. Ranger talents
    include wilderness survival, identifying flora and fauna, hunting
    and fishing, trapping and skinning, as well as archery and horseback
    riding.

-   THIEF. Dodgy, nervous individuals who like to think of themselves as
    simply pursuing alternative strategies to making a living.

    The prime desired stat of the thief is dexterity. Thief talents
    include picking pockets, picking locks, detecting and disarming
    traps, moving around unseen and unheard, and surprising unwary
    creatures.

-   MAGE. A student and scientist of magic who seeks naught but to
    unlock the unseen forces of the universe.

    The prime desired stat of the mage is intelligence. Mage talents
    include magic theory plus various spells. The mage guild protects a
    rather broad, general-purpose assortment of spells, rather than any
    specialization. The spell types include attack spells, defense
    spells, transmutation spells, and escape spells, with the occasional
    detection spell and such thrown in for good measure.

-   CLERIC. One of those that believe themselves to be the truly devout.
    Each cleric worships a diety and belongs to a religious
    establishment of fellow worshippers.

    The prime desired stat of the cleric is spirit. Cleric talents
    include various prayers; exactly which ones depends on the diety,
    but the prayers often deal in protection, divination, and healing,
    as well as blessing and cursing items, people, and locations, and
    turning or commanding undead beings.

-   BARD. The entertainer who considers themself an artist with a taste
    for adventure; everyone loves a bard, and bards love to party.

    The prime desired stat of the bard is charisma. The most notable
    bard talent is playing a musical instrument, but dancing and acting
    are also valuable skills, as are more academic studies like music
    theory.

    Due to the magical nature of the world, experienced bards can impart
    spell-like mind-altering effects with their music, such as causing
    sensations of fellowship, enmity, fear, placidity, and drowsiness -
    but these enchanted tunes cannot affect those that cannot hear them.

### The Fifteen Extended Guilds

-   PALADIN. A holy crusader type.

    The prime desired stat of the paladin is spirit, the secondary
    desired stat strength. Prerequisites for entrance to a paladin guild
    are an nth rank attainment as a cleric and an nth rank as a soldier.

    Paladin talents include all cleric and soldier talents, as well as
    some powerful spiritual attack and defense forms at higher ranks.
    Notably they can learn versions of clerical healing prayers with no
    somatic components ('laying on hands'.)

-   DRUID. The holly-harvesting robed lot.

    The prime desired stat of the druid is spirit, the secondary desired
    stat constitution. Prerequisites for entrance to a druidic circle
    are an nth rank attainment as a cleric and an nth rank as a ranger.

    Druid talents include all cleric and ranger talents, as well as
    various druidic studies such as herbalism and geomancy. Druidic
    prayers include communing with plants and animals, and extremely
    powerful druids can control the weather as an awesome attack magic.

-   MONK. Cloistered clerics who devote their lives to upholding their
    faith and protecting their monestary.

    The prime desired stat of the monk is spirit, the secondary desired
    stat dexterity. Prerequisites for entrance to a monk guild are an
    nth rank attainment as a cleric and an nth rank as a thief.

    Monk talents include all cleric and thief talents, as well as
    unarmed combat techniques, identification of flora and fauna,
    herbalism, and wine-making.

-   NECROMANCER. The student of death, both how it can be caused and how
    it can be exploited by harnessing the darker forces of magic.

    The prime desired stat of the necromancer is spirit, the secondary
    desired stat intelligence. Prerequisites for entrance to a
    necromancer guild are an nth rank attainment as a cleric and an nth
    rank as a mage.

    Necromancer talents include all cleric and mage talents, as well as
    the ability to animate corpses into undead beings such as zombies
    and skeletons.

-   PREACHER. The expert in manufacturing consent.

    The prime desired stat of the preacher is spirit, the secondary
    desired stat charisma. Prerequisites for entrance to a preacher
    guild are an nth rank attainment as a cleric and an nth rank as a
    bard.

    Preacher talents include all cleric and bard talents, as well as the
    ability to attract and keep extremely large numbers of followers,
    filling them with zealotry such that they will do almost anything
    the preacher asks.

-   ACROBAT. One of few who perfect their agility to the point where
    they can make breathtaking physical manoeuvers.

    The prime desired stat of the acrobat is dexterity, the secondary
    desired stat charisma. Prerequisites for entrance to an acrobat
    guild are an nth rank attainment as a thief and an nth rank as a
    bard.

    Acrobat talents include all thief and bard talents, as well as
    proficiencies at climbing, jumping, tumbling, and vaulting.

-   ASSASSIN. The expert in the ways of causing death, it's that simple.

    The prime desired stat of the assassin is dexterity, the secondary
    desired stat strength. Prerequisites for entrance to an assassin
    guild are an nth rank attainment as a thief and an nth rank as a
    soldier.

    Assassin talents include all thief and soldier talents, as well as
    proficiencies at dispatching creatures quietly when sleeping or
    unaware, including the identification, use, and eventually
    concoction of poisons (and their application on weapons.)

-   NINJA. Experts in moving about unnoticed and often employed as
    spies, the ninja use subtle magicks to aid in their stealthy
    assaults.

    The prime desired stat of the ninja is dexterity, the secondary
    desired stat intelligence. Prerequisites for entrance to a ninja
    guild are an nth rank attainment as a thief and an nth rank as a
    mage.

    Ninja talents include all thief and mage talents, as well as a
    smattering of other talents drawn from several other guilds, with an
    emphasis on stealth, escape, and diffusing of the situation always.

### Moral Orientations

-   KIND. Creatures who help other creatures in distress.
-   PRAGMATIC. Creatures who do only what needs to be done to survive.
-   CRUEL. Creatures who take advantage of other creatures in distress.

### Ethical Orientations

-   LOYAL. Creatures who obey authority regardless of their own
    interests.
-   DETACHED. Creatures who obey authority when it matches their own
    interests.
-   OPPORTUNISTIC. Creatures who rarely heed the demands of authority.

### Dieties and Karma

-   Nod-Noll (Kind, Loyal.)
-   Gaea (Pragmatic, Loyal.)
-   Hosta (Cruel, Loyal.)
-   Creses (Kind, Detached.)
-   Atom (Pragmatic, Detached.)
-   (Cruel, Detached.)
-   (Kind, Opportunistic.)
-   Horned (Pragmatic, Opportunistic.)
-   (Cruel, Opportunistic.)

* * * * *

### To-do List

-   Heatherwood Abbey
-   Roads, Rivers
-   Cynhyrdunum: Mill
-   Barren Expanse: Abandoned Mines
-   Bakersport: Stables, Palace, Tavern, Carpenter, Tailor, etc.
-   Badlands
-   Desert
-   Saiphan
-   Pyramids
-   etc...

### History

v2000.10.05 - v2000.10.25

-   See history.txt for CARPE DIEM

v2000.10.27

-   added Grumchik Strongholds.

v2000.10.30

-   added Grumchiks, many object factories/transformers.
-   added 'blur self' talent, 'create' and 'summon' talent factories.
-   any spell on any item (scroll of empathy etc.)
-   armour of statistic plus bonus (gloves of strength +1 etc.)
-   souls on items (card capture, animate corpse, and so forth.)
-   card capture spell.

v2000.11.02

-   Items which alter talents when wielded (\$item-\>oftalent.)
-   Items which alter resistances when wielded (\$item-\>oftalent.)
-   gigantic growth spell.
-   resist cold spell (todo: resist x spell constructor)
-   polymorph spell (todo: polymorph into x spell constructor)
-   pull crude clubs & staves from trees, switch on Bakersport gate
-   different kinds of poisons (todo: poisoned item constructor.)

v2000.11.03

-   different kinds of diseases

v2000.11.05

-   bard spells (songof constructor.) Require instrument.
-   shuffled around and finalized the lowercase keymap.

v2000.11.06

-   hot peppers.
-   \$item-\>make(\$adj) constructor.
-   many new types of clothing/armour.
-   rudimentary openable/closeable doors.
-   polymorph into x and resist x spell constructors.
-   magic circles.
-   creatures camoflaged as innocent-looking items.
-   create clouds of x spell constructor (fog cloud, stinking cloud,
    etc.)
-   expanded world map.

v2000.11.10

-   character backgrounds
-   giant beehives and giant honeybees are somewhat more realistic
-   desert-oriented terrain squares

v2000.11.18

-   more terrain, more items in database, not in world yet
-   more spell constructors - touch of x, bolt of x, sphere of x
-   exploding projectile spell, wizard window spell
-   pixie pyrotechnics spell
-   detect x (e.g. magic) (terrain squares/items) spell constructor

v2000.12.04

-   poisoned/diseased terrain square constructor

