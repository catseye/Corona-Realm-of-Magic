# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see file LICENSE for more info.

%::cities =
(
  'Bakersport' => Region->new('name' => 'Bakersport',
                    'sizex' => 60,
                    'sizey' => 60,
                    'outside' => $::sc{dark},
                    'ambient' => $Terrain::grassy_flat,
                    'genpattern' => 'canned',
                    'monsterd' => Distribution->new(
                            0.0010 => $Actor::human->class('merchant',3),
                            0.0010 => $Actor::elf->class('ninja',3),
                            0.0010 => $Actor::gnome->class('mage',6),
                            0.0010 => $Actor::dwarf->class('farmer',4),
                            0.0010 => $Actor::demifaery->class('bard',3),
                            0.0010 => $Actor::ursati->class('soldier',4),
                            0.0010 => $Actor::human->class('soldier',2),
                            0.0010 => $Actor::human->class('cleric',2),
                            0.0010 => $Actor::human->class('mage',2),
                            0.0010 => $Actor::human->class('farmer',2),
                            0.0010 => $Actor::human->class('thief',2),
                            0.0010 => $Actor::human->class('druid',2),
                            0.0010 => $Actor::human->class('necromancer',2),
                            0.0010 => $Actor::human->class('ranger',2),
                            # 0.0010 => $Actor::traiple->wily->hostile,
                           ),
  'template' =>
  [
    '..........................,..~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~',
    '...........................,..~~~~~~~~~~~~~!~!~!~!~~~~~~~~~~',
    '..##### ##### ##### ###### ######~######~~~!~!~!~!K~~#####~~',
    '..#   ###   ###   ###    ### ,  ###    ###=!!!!!!!=###   #~~',
    '..# _........................,,,,,,,,,,,,,,,,,,,,,,_____ #~~',
    '..# _........................,,=== == === == ===== ====_ #~~',
    '..##_........................,,=== == === == ===== ====_##~~',
    '.. #_........................,,=== == === == ===== ====_#~~~',
    '..##_........................,,=== ==________=====  ____##~~',
    '..# _........................,,    ==_= ====_===== =_==_ #~~',
    '..# _........................,,===   _= ====_________==_ #~~',
    '..# _........................,,=== ==_..====.== ====   _ #~~',
    '..##_........................,,....==_.......== ====..=_##~~',
    '.. #_........................,,....==_................._#~~~',
    '..##_........................,,_______................._##~~',
    '..# _........................,,........................_ #~~',
    '..# _........................,,........................_ #~~',
    '..# _........................,,........................_ #~~',
    '..##_........................,,........................_##~~',
    '.. #_________________________,,........................_#~~~',
    '..##,.-------...===.  [[[[[  ,,........................_##~~',
    '..# ,--     --..===.  [[[[[  ,,........................_ #~~',
    '..# ,E-     --..===.[[==C==[[,,........................_ #~~',
    '..# ,E-     --......[[=====[[,,........................_ #~~',
    '..# ,--     --......[[C===C[[,,==.==..................._ #~~',
    '..##,.-------...===.[[=====[[,,=B B=.====..........====_##~~',
    '.. #,...........===.[[==C==[[,,___ ..====.===.====.====_#~~~',
    '..##,===.==.....===.  [[[[[  ,,  _B=.====.===.====.====_##~~',
    '.Z# ,===.==.....===.  [[[[[  ,,  _== 8===.=7=.6===.==5=_ #~~',
    '__U,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,_ #~~',
    '__U,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,_ #~~',
    '..#)===_==.===.==_=== ====   ,,  ==1==..=2=_==3==...=4=_ #.~',
    '..##===_==.===.==_===^====   ,,  =====..===_=====.^.===_##..',
    '.. #===_______________====   ,,..=====..===_=====...===_#...',
    '..##### ##### ##### ######   ,,............_..........._##..',
    '..#   ###   ###   ###    # ^ ,,==.==.==.===_D=.==.==.==_.#..',
    '..# ..... ^     ^     ^  #   ,,=D.=D.D=.===_==.=D.D=.=D_.#..',
    '..# .=== ^^ ===   === ^^ # ^ ,,..____...===_....._....._.#..',
    '..# .===.   =========    #   ,,==_==.==.===_==.==_==.==_.#..',
    '..##.===. ============= ## ^ ,,=D_=D.=D.=D=_D=.D=_D=.D=_##..',
    '.. #..... ============= #    ,,_________________________#...',
    '..##.===. ============= ## ^ ,,=A.=====_==.=A.===.==.=A_##..',
    '..# .===   ===========   #   ,,==.=====_A=.==.=A=.A=.==_.#..',
    '..# .=== ^ =========== ^ # ^ ,,...====A_..............._.#..',
    '..# ....   ===========   #   ,,==.=====_A=.A=.=A=.=A.=A_.#..',
    '..##.===. ============= ## ^ ,,=A.=====_==^==.===.==.==_##..',
    '.. #.===. ============U U,,,,,,__....^^_^^............._#...',
    '..##.===. ============= ##   __==^==^==_A=^==.===.==.==_##..',
    '..# .....   =========    # ^ __A=.A=.=A_==.A=.A==.A=.=A_.#..',
    '..# .=== ^^ ===   === ^^ #   __........________........_.#..',
    '..# .===..^     ^     ^  # ^ __==.A=.=A.=A=.=A_==.==.==_.#..',
    '..##.===.====.====.====.##   __A=.==.==.===.==_A=.A=.=A_##..',
    '.. #.===.====.====.====.#  ^  _..............._........_#...',
    '..##.===.====.====.====.##    _==.==.==.==.==A_==.==.=A_##..',
    '..# .===.====.====.====. # ^  _=A.=A.=A.A=.===_=A.=A.==_.#..',
    '..# .................... #    __________________________.#..',
    '..#   ###   ###   ###    ###  ..###....###...###...###...#..',
    '..##### ##### ##### ###### ###### ###### ##### ##### #####..',
    '............................................................',
    '............................................................',
  ],
  'legend' =>
  {
    ' ' => undef,
    '.' => Distribution->new(0.050 => $Terrain::clump_of_trees),
    '#' => Distribution->new(
                            0.970 => $Terrain::city_wall,
                            0.010 => $Terrain::city_wall->new_inscribe('COLONIST GO HOME'),
                            0.010 => $Terrain::city_wall->new_inscribe('DIE DIE DIE INFIDEL VERMIN SCUM'),
                            0.010 => $Terrain::city_wall->new_inscribe('CURSE YOU ROTTEN INVADERS'),
           ),
    '=' => Distribution->new(
                            0.900 => $Terrain::building_wall,
                            0.020 => $Terrain::building_wall->new_inscribe('SMURJ WAS HERE'),
                            0.020 => $Terrain::building_wall->new_inscribe('LAISSEZ-FAIRE'),
                            0.020 => $Terrain::building_wall->new_inscribe('CHANGE RULES'),
                            0.020 => $Terrain::building_wall->new_inscribe('CARPE DIEM'),
                            0.020 => $Terrain::building_wall->new_inscribe('THE REEVE IS A FINK'),
           ),
    'Z' => $Terrain::wooden_signpost->new_inscribe('Welcome to Bakersport')->new_inscribe('Population 1500'),
    '-' => $Terrain::stonework_wall,
    ',' => $Terrain::cobblestone_road,
    '_' => $Terrain::dirt_road,
    '~' => $Terrain::ocean,
    'U' => $Terrain::stone_archway,
    '^' => $Terrain::clump_of_trees,
    '!' => $Terrain::wooden_docks,
    '[' => $Terrain::marble_steps,
    '&' => $Terrain::closed_wooden_door,
    'O' => $Terrain::magic_circle,

    'A' => $Terrain::wooden_doorway->enc(Encounter->new('actors' => [ $Actor::human ],
                     'friendly' => 1,
                     'persistent' => 1,
                     'message' => '"Could someone help me? My home is infested!"',
                     'lore' => '"It all started a few days ago... whatever\'s happening, it\'s not natural."',
                    ))->to_new('Bakersport Hovel'),
    'B' => $Terrain::stone_archway, # $Terrain::doorway_bazaar,
    'C' => $Terrain::stone_archway->enc(Encounter->new('actors' => [ $Actor::sirgon ],
                     'friendly' => 1,
                     'itemseller' => 1,
                     'serviceseller' => 1,
                     'persistent' => 1,
                     'message' => '"Bless thee, my child," says Sirgon, the priest.',
                     'lore' => '"Evil spirits lurk \'round us still, I\'m afraid."',
                    )),

    'D' => $Terrain::stone_archway, # $Terrain::doorway_domicile,
    'E' => $Terrain::stone_archway->enc(Encounter->new('actors' => [ $Actor::boutek ],
                     'friendly' => 1,
                     'itemseller' => 1,
                     'serviceseller' => 1,
                     'persistent' => 1,
                     'message' => 'Boutek the arena-master smiles, showing off several missing teeth.',
                     'lore' => '"Ticket sales have been good lately; Barkersportians love this gory stuff."',
                    )),
    'K' => $Terrain::wooden_doorway->enc(Encounter->new('actors' => [ $Actor::phaeref ],
                     'friendly' => 1,
                     'itemseller' => 1,
                     'serviceseller' => 1,
                     'itembuyer' => 1,
                     'persistent' => 1,
                     'purchasing' =>
                     {
                       'gold coin'   => $Item::coin->make($Adj::silver)->bunch(10)->clone->identify,
                       'silver coin' => $Item::coin->make($Adj::copper)->bunch(10)->clone->identify,
                     },
                     'message' => 'The grizzled shipyard quartermistress glares at you and asks you what you want.',
                     'lore' => '"There\'s more to this city than meets the eye. Don\'t say you weren\'t warned."',
                    )),

    '1' => $Terrain::wooden_doorway->enc(Encounter->new('actors' => [ $Actor::ehrla ],
                     'friendly' => 1,
                     'itemseller' => 1,
                     'serviceseller' => 1,
                     'persistent' => 1,
                     'message' => 'Ehrla, the weaponsmith, gives you a disinterested nod.',
                     'lore' => '"I\'d watch my back on these streets if I were you."',
                    )),
    '2' => $Terrain::wooden_doorway->enc(Encounter->new('actors' => [ $Actor::bonzi ],
                     'friendly' => 1,
                     'itemseller' => 1,
                     'serviceseller' => 1,
                     'persistent' => 1,
                     'message' => 'Bonzi, the sage, greets you with insincere flattery.',
                     'lore' => '"A little knowledge is a dangerous thing," warns Bonzi.',
                    )),
    '4' => $Terrain::wooden_doorway->enc(Encounter->new('actors' => [ $Actor::eblec ],
                     'friendly' => 1,
                     'itemseller' => 1,
                     'itembuyer' => 1,
                     'serviceseller' => 1,
                     'persistent' => 1,
                     'purchasing' =>
                     {
                       'male giant grasshopper carcass' => $Item::coin->make($Adj::silver)->bunch(2)->clone->identify,
                       'female giant grasshopper carcass' => $Item::coin->make($Adj::silver)->bunch(2)->clone->identify,
#                       'mundane torch' => $Item::coin->make($Adj::silver)->bunch(2)->clone->identify,
                     },
                     'message' => 'Eblec, the alchemist, pretends not to notice you.',
                     'lore' => '"It\'s generally unwise to eat mysterious fungi."',
                    )),
    ')' => $Terrain::building_wall->switch(<<'END'),
{
  my ($puller, $self) = @_;
  if (defined $self->{state} and $self->{state})
  {
    $puller->{location}->relieve($puller->{location}->get_terrain(2,29));
    $puller->{location}->relieve($puller->{location}->get_terrain(2,30));
    $puller->seen($puller, "<self> sees the iron portcullis creakingly lift up.");
  } else
  {
    unshift @{$puller->{location}{map}[2][29]}, $Terrain::iron_portcullis->clone->at($puller->{location},2,29);
    unshift @{$puller->{location}{map}[2][30]}, $Terrain::iron_portcullis->clone->at($puller->{location},2,30);
    $puller->seen($puller, "<self> sees the iron portcullis come crashing down.");
  }
  $puller->{location}->draw_cell(2,29);
  $puller->{location}->draw_cell(2,30);
  $self->{state} = not $self->{state};
}
END
  },
  ),
  'Cynhyrdunum' => Region->new('name' => 'Cynhyrdunum',
                    'sizex' => 60,
                    'sizey' => 60,
                    'outside' => $::sc{dark},
                    'ambient' => $Terrain::low_hillside,
                    'genpattern' => 'canned',
                    'itemd' => Distribution->new(
                            0.01 => $Item::stone,
                            0.01 => $Item::menhir,
                            0.01 => $Item::cabbage->bunch(3),
                           ),
                    'monsterd' => Distribution->new(
                            0.0010 => $Actor::elf->class('merchant',1),
                            0.0013 => $Actor::human->class('cleric',2),
                            0.0030 => $Actor::dwarf->class('farmer',2),
                            0.0033 => $Actor::human->class('farmer',2),
                            0.0015 => $Actor::human->class('druid',2),
                            0.0010 => $Actor::traiple->wily->hostile,
                           ),
  'template' =>
  [
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '............................................................',
    '........          ..........................................',
    '          ______                ............................',
    '__________      _______________  ...........................',
    '            ..      Z ,,!     _  ...........................',
    '......................,,, ==1  _ ...........................',
    '......................... ===  _ ==.........................',
    '......................,,, === _  2=.........................',
    '......................,,!    __  ==.........................',
    '.........................____  _^^ .........................',
    '........................,!.,!  _^^..........................',
    '........................,,.,, _ !,,.........................',
    '............................. _ ^,,.........................',
    '.............................Z _^^..........................',
    '.............................. _ ^..........................',
    '............................. _ ............................',
    '............................. _ ............................',
    '.............................. _ ...........................',
    '.............................. _ ...........................',
    '............................. _ ............................',
    '............................. _ ............................',
    '.............................. _ ...........................',
    '.............................. _ ...........................',
    '............................. _ ............................',
    '............................. _ ............................',
    '.............................. _ ...........................',
    '.............................. _ ...........................',
    '............................. _ ............................',
    '............................. _ ............................',
    '.............................. _ ...........................',
    '.............................. _ ...........................',
    '............................. _ ............................',
    '............................. _ ............................',
    '.............................. _ ...........................',
  ],
  'legend' =>
  {
    ' ' => $Terrain::grassy_flat,
    '.' => Distribution->new(
                            0.300 => $Terrain::grassy_flat,
                            0.200 => $Terrain::clump_of_trees,
                            0.070 => $Terrain::cultivated_field,
                            0.020 => $Terrain::fallow_field,
                            0.010 => $Terrain::low_hillside->enc(
  Encounter->new('actors' => [ $Actor::traiple->wily,
                               $Actor::traiple->wily,
                               $Actor::traiple->wily,
                             ],
                 'message' => 'You spot a band of wily-looking traiples!',
                )),
                    ),
    '#' => undef,
    'Z' => $Terrain::wooden_signpost->new_inscribe('Welcome to Cynhyrdunum')->new_inscribe('Population 83'),
    '=' => $Terrain::building_wall,
    ',' => $Terrain::cultivated_field,
    '_' => $Terrain::dirt_road,
    '~' => $Terrain::low_hillside,
    'U' => $Terrain::stone_archway,
    '^' => $Terrain::clump_of_trees,
    '!' => $Terrain::small_farmhouse,
    '[' => undef,
    '&' => undef,
    'O' => undef,
    'W' => $Terrain::well,

    '1' => $Terrain::wooden_doorway->enc(Encounter->new('actors' => [ $Actor::human->class('merchant',5), $Actor::ursati->class('soldier',3) ],
                     'friendly' => 1,
                     'itemseller' => 1,
                     'serviceseller' => 1,
                     'persistent' => 1,
                     'message' => 'The innkeeper gives you a hearty greeting.',
                     'lore' => '"You travelling adventurer types sure are great for our economy."',
                    )),
    '2' => $Terrain::wooden_doorway->enc(Encounter->new('actors' => [ $Actor::dwarf->class('smith',3) ],
                     'friendly' => 1,
                     'itemseller' => 1,
                     'serviceseller' => 1,
                     'persistent' => 1,
                     'message' => 'The grizzled smith gives you a barely-perceptible nod.',
                     'lore' => 'The smith begins to look uncomfortable when you mention the traiples.',
                    )),
  },
  ),
);

1;
