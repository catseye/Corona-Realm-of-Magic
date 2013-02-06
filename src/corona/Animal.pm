# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see file LICENSE for more info.

package Actor;


### BUILT-IN ACTORS ###

$giant_honeybee = Actor->new('name'         => 'giant honeybee',
'max' => {
                          'strength'     => Dice->new(1,2,+1),
                          'constitution' => Dice->new(1,3,+2),
                          'dexterity'    => Dice->new(1,3,+15),
                          'intelligence' => Dice->new(1,1),
                          'spirit'       => Dice->new(1,2,+1),
                          'charisma'     => Dice->new(1,1),
},
                          'arms'         => $Item::nonexistant_part,
                          'hands'        => $Item::nonexistant_part,
                          'sex'          => $Distribution::hive_sex,
                          'race'         => 'Bee',
                          'melee_attacks'=> [ $Attack::bee_sting ],
                          'hitbonus'     => -1,
                          'appearance'   => 'bee',
                          'color'        => 'brown',
                          'hair_type'    => 'fuzzy',
                          'hair_color'   => 'brown',
                          'eye_color'    => 'multifaceted',
                          'skin_type'    => 'puffy',
                          'skin_color'   => 'black',
                          'body_aim'     => 'small_winged');

#$giant_honeybee->take(Distribution->new(
#                      0.050 => $Item::golden_honeycomb->bunch(1),
#                      0.018 => $Item::golden_honeycomb->bunch(2),
#                      0.005 => $Item::royal_jelly->bunch(1),
#                     ));

$giant_honeybee->{belongings} = [ Distribution->new(
                      0.050 => $Item::golden_honeycomb->bunch(1),
                      0.018 => $Item::golden_honeycomb->bunch(2),
                      0.005 => $Item::royal_jelly->bunch(1),
                     )];

$queen_honeybee = Actor->new('name'         => 'queen honeybee',
'max' => {
                          'strength'     => Dice->new(1,2,+2),
                          'constitution' => Dice->new(2,2,+6),
                          'dexterity'    => Dice->new(1,3,+10),
                          'intelligence' => Dice->new(2,2),
                          'spirit'       => Dice->new(2,2,+2),
                          'charisma'     => Dice->new(1,1),
},
                          'arms'         => $Item::nonexistant_part,
                          'hands'        => $Item::nonexistant_part,
                          'sex'          => 'Female',
                          'race'         => 'Bee',
                          'melee_attacks'=> [ $Attack::bee_sting ],
# todo: poison
                          'hitbonus'     => -1,
                          'appearance'   => 'bee',
                          'color'        => 'yellow',
                          'hair_type'    => 'fuzzy',
                          'hair_color'   => 'yellow',
                          'eye_color'    => 'multifaceted',
                          'skin_type'    => 'bloated',
                          'skin_color'   => 'red',
                          'body_aim'     => 'small_winged');

$queen_honeybee->{belongings} = [ Distribution->new(
                      0.300 => $Item::royal_jelly->bunch(4),
                      0.300 => $Item::royal_jelly->bunch(3),
                      0.300 => $Item::royal_jelly->bunch(2),
                      0.100 => $Item::royal_jelly->bunch(1),
                     )];

$giant_grasshopper = Actor->new('name'   => 'giant grasshopper',
'max' => {
                          'strength'     => Dice->new(2,3),
                          'constitution' => Dice->new(2,2,+2),
                          'dexterity'    => Dice->new(1,4,+16),
                          'intelligence' => Dice->new(1,1),
                          'spirit'       => Dice->new(1,2),
                          'charisma'     => Dice->new(1,1),
},
                          'hands'        => $Item::nonexistant_part,
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Grasshopper',
                          'melee_attacks'=> [ $Attack::insect_kick, $Attack::insect_kick ],
                          'appearance'   => 'grasshopper',
                          'color'        => 'green',
                          'hair_color'   => 'no',
                          'eye_color'    => 'multifaceted',
                          'skin_type'    => 'shiny',
                          'skin_color'   => 'green',
                          'body_aim'     => 'pouncer');

$forest_cat =  Actor->new('name'         => 'forest cat',
'max' => {
                          'strength'     => Dice->new(2,3,+1),
                          'constitution' => Dice->new(2,3,+2),
                          'dexterity'    => Dice->new(1,3,+19),
                          'intelligence' => Dice->new(2,2,+2),
                          'spirit'       => Dice->new(2,3),
                          'charisma'     => Dice->new(3,3,+3),
},
                          'nightvision'  => 1,
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Feline',
                          'melee_attacks'=> [ $Attack::cat_bite, $Attack::cat_claw, $Attack::cat_claw ],
                          'hitbonus'     => -1,
                          'appearance'   => 'feline',
                          'color'        => 'brown',
                          'hair_type'    => 'sleek',
                          'hair_color'   => 'beige',
                          'eye_type'     => 'deep',
                          'eye_color'    => Distribution->new(0.60 => 'green', 0.40 => 'brown'),
                          'skin_type'    => 'fair',
                          'skin_color'   => 'grey',
                          'body_aim'     => 'pouncer');

# cat: lick wounds
# cat: tail == waist?  subsceptible?

$grizzly_bear = Actor->new('name'        => 'grizzly bear',
'max' => {
                          'strength'     => Dice->new(4,6,+1),
                          'constitution' => Dice->new(4,5,+2),
                          'dexterity'    => Dice->new(3,5),
                          'intelligence' => Dice->new(2,3,+1),
                          'spirit'       => Dice->new(2,3),
                          'charisma'     => Dice->new(2,3),
},
                          'nightvision'  => 1,
                          'torso'        => $Item::thick_fur->clone,
                          'arms'         => $Item::thick_fur->clone,
                          'legs'         => $Item::thick_fur->clone,
                          'head'         => $Item::thick_fur->clone,
                          'shoulders'    => $Item::thick_fur->clone,
                          'hands'        => $Item::thick_fur->clone,
                          'feet'         => $Item::thick_fur->clone,
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Bear',
                          'melee_attacks'=> [ $Attack::bear_claw, $Attack::bear_claw, $Attack::bear_hug ],
                          'negotiate'    =>
                          {
                            'Neutral'    => 50,
                          },
                          'appearance'   => 'ursine',
                          'color'        => 'brown',
                          'hair_type'    => 'thick',
                          'hair_color'   => 'brown',
                          'eye_type'     => 'piercing',
                          'eye_color'    => 'black',
                          'skin_type'    => 'oily',
                          'skin_color'   => 'grey',
                          'body_aim'     => 'smart_biped');

$sylvan_snake = Actor->new('name'        => 'sylvan snake',
'max' => {
                          'strength'     => Dice->new(2,3,-1),
                          'constitution' => Dice->new(2,3,+1),
                          'dexterity'    => Dice->new(1,6,+13),
                          'intelligence' => Dice->new(2,2),
                          'spirit'       => Dice->new(2,2),
                          'charisma'     => 1,
},
                          'nightvision'  => 1,
                          'torso'        => $Item::reptilian_scales->clone,
                          'head'         => $Item::reptilian_scales->clone,
                          'legs'         => $Item::nonexistant_part,
                          'feet'         => $Item::nonexistant_part,
                          'arms'         => $Item::nonexistant_part,
                          'hands'        => $Item::nonexistant_part,
                          'shoulders'    => $Item::nonexistant_part,
                          'waist'        => $Item::nonexistant_part,
                          'hair_color'   => 'no',
                          'eye_type'     => 'beady',
                          'eye_color'    => 'black',
                          'skin_type'    => 'scaly',
                          'skin_color'   => 'green',
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Snake',
                          'melee_attacks'=> [ $Attack::sylvan_snake_bite ],
                          'hitbonus'     => 0,
                          'appearance'   => 'serpent',
                          'color'        => 'green',
                          'body_aim'     => 'creepy_crawly');

$juggler_snake = Actor->new('name'        => 'juggler snake',
'max' => {
                          'strength'     => Dice->new(1,2),
                          'constitution' => Dice->new(2,3),
                          'dexterity'    => Dice->new(1,6,+9),
                          'intelligence' => Dice->new(1,2,+3),
                          'spirit'       => 1,
                          'charisma'     => Dice->new(1,4,+16),
},
                          'nightvision'  => 1,
                          'legs'         => $Item::nonexistant_part,
                          'feet'         => $Item::nonexistant_part,
                          'arms'         => $Item::nonexistant_part,
                          'hands'        => $Item::nonexistant_part,
                          'shoulders'    => $Item::nonexistant_part,
                          'waist'        => $Item::nonexistant_part,
                          'hair_color'   => 'no',
                          'eye_color'    => 'hypnotizing',
                          'skin_type'    => 'scaly',
                          'skin_color'   => 'red',
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Snake',
                          'melee_attacks'=> [ $Attack::sylvan_snake_bite ],  # not exactly
                          'hitbonus'     => 0,
                          'appearance'   => 'serpent',
                          'color'        => 'red',
                          'body_aim'     => 'creepy_crawly');

# $juggler_snake->learn($Talent::charm);

$blue_spider = Actor->new('name'        => 'blue spider',
'max' => {
                          'strength'     => 1,
                          'constitution' => 1,
                          'dexterity'    => Dice->new(3,3,+18),
                          'intelligence' => 1,
                          'spirit'       => 1,
                          'charisma'     => 1,
},
                          'arms'         => $Item::nonexistant_part,
                          'hands'        => $Item::nonexistant_part,
                          'shoulders'    => $Item::nonexistant_part,
                          'waist'        => $Item::nonexistant_part,
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Arachnid',
                          'melee_attacks'=> [ $Attack::blue_spider_bite ],
# todo: poison
                          'hitbonus'     => -2,
                          'appearance'   => 'spider',
                          'color'        => 'blue',
                          'hair_type'    => 'spiky',
                          'hair_color'   => 'blue',
                          'eye_type'     => 'beady',
                          'eye_color'    => 'black',
                          'skin_type'    => 'mottled',
                          'skin_color'   => 'blue',
                          'body_aim'     => 'creepy_crawly');

### PLAINS

$scutter_skunk =  Actor->new('name'         => 'scutter skunk',
'max' => {
                          'strength'     => Dice->new(2,3,+2),
                          'constitution' => Dice->new(2,5),
                          'dexterity'    => Dice->new(1,3,+15),
                          'intelligence' => Dice->new(2,2,+1),
                          'spirit'       => Dice->new(2,3,-1),
                          'charisma'     => Dice->new(1,2),
},
                          'nightvision'  => 1,
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Feline',  # not exactly
                          'melee_attacks'=> [ $Attack::cat_claw, $Attack::cat_claw ],
                          'hitbonus'     => -1,
                          'negotiate'    =>
                          {
                            'Respectful' => 25,
                          },
                          'appearance'   => 'feline',
                          'color'        => 'white',
                          'hair_type'    => 'striped',
                          'hair_color'   => 'white',
                          'eye_type'     => 'piercing',
                          'eye_color'    => 'red',
                          'skin_type'    => 'gummy',
                          'skin_color'   => 'black',
                          'body_aim'     => 'pouncer');

### SWAMP

$green_alligator = Actor->new('name'        => 'green alligator',
'max' => {
                          'strength'     => Dice->new(3,6,+7),
                          'constitution' => Dice->new(2,10,+10),
                          'dexterity'    => Dice->new(2,3),
                          'intelligence' => Dice->new(1,2,+1),
                          'spirit'       => 1,
                          'charisma'     => Dice->new(2,2),
},
                          'nightvision'  => 1,
                          'torso'        => $Item::reptilian_scales->clone,
                          'arms'         => $Item::nonexistant_part->clone,
                          'legs'         => $Item::reptilian_scales->clone,
                          'head'         => $Item::reptilian_scales->clone,
                          'shoulders'    => $Item::reptilian_scales->clone,
                          'hands'        => $Item::nonexistant_part->clone,
                          'feet'         => $Item::reptilian_scales->clone,
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Reptile',
                          'melee_attacks'=> [ $Attack::gator_grip ],
                          'appearance'   => 'gator',
                          'color'        => 'green',
                          'hair_color'   => 'no',
                          'eye_type'     => 'empty',
                          'eye_color'    => 'yellow',
                          'skin_type'    => 'tough',
                          'skin_color'   => 'green',
                          'body_aim'     => 'creepy_crawly')->implies($Adj::aquatic);

$wetland_viper = Actor->new('name'        => 'wetland viper',
'max' => {
                          'strength'     => Dice->new(1,4),
                          'constitution' => Dice->new(3,3,+3),
                          'dexterity'    => Dice->new(1,2,+16),
                          'intelligence' => Dice->new(1,6),
                          'spirit'       => Dice->new(1,6),
                          'charisma'     => Dice->new(1,6),
},
                          'nightvision'  => 1,
                          'torso'        => $Item::reptilian_scales->clone,
                          'head'         => $Item::reptilian_scales->clone,
                          'legs'         => $Item::nonexistant_part,
                          'feet'         => $Item::nonexistant_part,
                          'arms'         => $Item::nonexistant_part,
                          'hands'        => $Item::nonexistant_part,
                          'shoulders'    => $Item::nonexistant_part,
                          'waist'        => $Item::nonexistant_part,
                          'negotiate'    =>
                          {
                            'Scary'      => 25,
                            'Familiar'   => 25,
                          },
                          'hair_color'   => 'no',
                          'eye_type'     => 'milky',
                          'eye_color'    => 'grey',
                          'skin_type'    => 'scaly',
                          'skin_color'   => 'yellow',
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Snake',
                          'melee_attacks'=> [ $Attack::blue_spider_bite ],
# todo poison
                          'hitbonus'     => 0,
                          'appearance'   => 'serpent',
                          'color'        => 'yellow',
                          'body_aim'     => 'creepy_crawly')->implies($Adj::aquatic);

# purple catfish
# brown eel

$pond_spider = Actor->new('name'        => 'pond spider',
'max' => {
                          'strength'     => Dice->new(1,3),
                          'constitution' => Dice->new(2,3,+1),
                          'dexterity'    => Dice->new(3,3,+10),
                          'intelligence' => Dice->new(1,3),
                          'spirit'       => Dice->new(1,2),
                          'charisma'     => Dice->new(1,2),
},
                          'arms'         => $Item::nonexistant_part,
                          'hands'        => $Item::nonexistant_part,
                          'shoulders'    => $Item::nonexistant_part,
                          'waist'        => $Item::nonexistant_part,
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Arachnid',
                          'melee_attacks'=> [ $Attack::blue_spider_bite ], # not exactly
# todo poison
                          'appearance'   => 'spider',
                          'color'        => 'blue',
                          'hair_type'    => 'spiky',
                          'hair_color'   => 'blue',
                          'eye_type'     => 'beady',
                          'eye_color'    => 'black',
                          'skin_type'    => 'mottled',
                          'skin_color'   => 'blue',
                          'body_aim'     => 'creepy_crawly');

$shadow_owl =  Actor->new('name'         => 'shadow owl',
'max' => {
                          'strength'     => Dice->new(2,2,+2),
                          'constitution' => Dice->new(2,2,+2),
                          'dexterity'    => Dice->new(2,3,+13),
                          'intelligence' => Dice->new(2,3,+2),
                          'spirit'       => Dice->new(2,6),
                          'charisma'     => Dice->new(1,10),
},
                          'nightvision'  => 1,
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Owl',
                          'melee_attacks'=> [ $Attack::talon, $Attack::talon, $Attack::beak ],  # not exactly
                          'appearance'   => 'bird',
                          'color'        => 'grey',
                          'hair_color'   => 'feathers, not',
                          'eye_type'     => 'knowing',
                          'eye_color'    => 'brown',
                          'skin_type'    => 'ashy',
                          'skin_color'   => 'grey',
                          'body_aim'     => 'small_winged')->implies($Adj::airborne);

1;
