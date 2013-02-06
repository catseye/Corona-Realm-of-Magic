# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see file LICENSE for more info.

package Actor;

sub strategy
{
  my $self = shift;
  $self->{combat} = shift;
  return $self;
}

### BUILT-IN ACTORS ###

$human       = Actor->new('name'         => 'human',
'lore' => <<'END',
The most common beings in the newly-colonized areas of
Aelia, humans are also the least specialized and the
most adaptible.
END
'max' => {
                          'strength'     => Dice->new(3,6),
                          'constitution' => Dice->new(3,6),
                          'dexterity'    => Dice->new(3,6),
                          'intelligence' => Dice->new(3,6),
                          'spirit'       => Dice->new(3,6),
                          'charisma'     => Dice->new(3,6),
},
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Human',
                          'appearance'   => 'person',
                          'color'        => 'brown',
                          'hair_type'    => $Distribution::humanoid_hair_type,
                          'hair_color'   => $Distribution::humanoid_hair_color,
                          'eye_type'     => $Distribution::humanoid_eye_type,
                          'eye_color'    => $Distribution::humanoid_eye_color,
                          'skin_type'    => $Distribution::humanoid_skin_type,
                          'skin_color'   => $Distribution::humanoid_skin_color,
                          'domhand'      => $Distribution::humanoid_hand_dominance,
                          'melee_attacks'=> [ $Attack::punch ],
                        );

$dwarf       = Actor->new('name'         => 'dwarf',
'lore' => <<'END',
Stout, bearded beings reknown for their excellent
aptitude for mining, dwarves are not uncommonly seen
in Aelia.
END
'max' => {
                          'strength'     => Dice->new(3,6,+1),
                          'constitution' => Dice->new(3,6,+1),
                          'dexterity'    => Dice->new(3,6,-2),
                          'intelligence' => Dice->new(3,6),
                          'spirit'       => Dice->new(3,6),
                          'charisma'     => Dice->new(3,6),
},
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Dwarf',
                          'appearance'   => 'person',
                          'color'        => 'grey',
                          'hair_type'    => $Distribution::humanoid_hair_type,
                          'hair_color'   => $Distribution::humanoid_hair_color,
                          'eye_type'     => $Distribution::humanoid_eye_type,
                          'eye_color'    => $Distribution::humanoid_eye_color,
                          'skin_type'    => $Distribution::humanoid_skin_type,
                          'skin_color'   => $Distribution::humanoid_skin_color,
                          'domhand'      => $Distribution::humanoid_hand_dominance,
                          'melee_attacks'=> [ $Attack::punch ],
                         );

$elf         = Actor->new('name'         => 'elf',
'lore' => <<'END',
Elves are thin, nimble beings with a reputation for
fine cobbling and woodworking.  Aelia is populated
by many elves.
END
'max' => {
                          'strength'     => Dice->new(3,6,-1),
                          'constitution' => Dice->new(3,6),
                          'dexterity'    => Dice->new(3,6,+1),
                          'intelligence' => Dice->new(3,6),
                          'spirit'       => Dice->new(3,6),
                          'charisma'     => Dice->new(3,6),
},
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Elf',
                          'appearance'   => 'person',
                          'color'        => 'white',
                          'hair_type'    => $Distribution::humanoid_hair_type,
                          'hair_color'   => $Distribution::humanoid_hair_color,
                          'eye_type'     => $Distribution::humanoid_eye_type,
                          'eye_color'    => $Distribution::humanoid_eye_color,
                          'skin_type'    => $Distribution::humanoid_skin_type,
                          'skin_color'   => $Distribution::humanoid_skin_color,
                          'domhand'      => $Distribution::humanoid_hand_dominance,
                          'melee_attacks'=> [ $Attack::punch ],
                         );

$gnome       = Actor->new('name'         => 'gnome',
'lore' => <<'END',
These short, robust beings are accustomed to
dealing with dire situations in harsh environments,
including Aelia.
END
'max' => {
                          'strength'     => Dice->new(3,6,-1),
                          'constitution' => Dice->new(3,6,+1),
                          'dexterity'    => Dice->new(3,6,+1),
                          'intelligence' => Dice->new(3,6,+1),
                          'spirit'       => Dice->new(3,6,-1),
                          'charisma'     => Dice->new(3,6,-1),
},
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Gnome',
                          'appearance'   => 'person',
                          'color'        => 'yellow',
                          'hair_type'    => $Distribution::humanoid_hair_type,
                          'hair_color'   => $Distribution::humanoid_hair_color,
                          'eye_type'     => $Distribution::humanoid_eye_type,
                          'eye_color'    => $Distribution::humanoid_eye_color,
                          'skin_type'    => $Distribution::humanoid_skin_type,
                          'skin_color'   => $Distribution::humanoid_skin_color,
                          'domhand'      => $Distribution::humanoid_hand_dominance,
                          'melee_attacks'=> [ $Attack::punch ],
                         );

$demifaery   = Actor->new('name'         => 'demifaery',
'lore' => <<'END',
When a mischievous faery magically impregnates a
female human or elf, the resulting child is a
demifaery.  Shunned by both the humanoid and faery
communities, demifaeries often appear fairly similar
to humans or elves save for their small stature,
child-like disposition, faint aura, and vestigal
wings.
END
'max' => {
                          'strength'     => Dice->new(2,6),
                          'constitution' => Dice->new(3,6,-2),
                          'dexterity'    => Dice->new(3,6,+1),
                          'intelligence' => Dice->new(3,6),
                          'spirit'       => Dice->new(4,6),
                          'charisma'     => Dice->new(3,6,+1),
},
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Demifaery',
                          'appearance'   => 'fairy',
                          'color'        => 'pink',
                          'hair_type'    => $Distribution::humanoid_hair_type,
                          'hair_color'   => $Distribution::humanoid_hair_color,
                          'eye_type'     => $Distribution::humanoid_eye_type,
                          'eye_color'    => $Distribution::humanoid_eye_color,
                          'skin_type'    => $Distribution::humanoid_skin_type,
                          'skin_color'   => $Distribution::humanoid_skin_color,
                          'domhand'      => $Distribution::humanoid_hand_dominance,
                          'melee_attacks'=> [ $Attack::punch ],
                         );

$ursati      = Actor->new('name'         => 'ursati',
'lore' => <<'END',
The so-called 'Bear People' of the Paspar Mountains
do not often mix with the humanoid inhabitants of
Aelia, and the common view of the Ursati as a
backward xenophobe is an exaggerated one.  Often
more than seven feet tall, covered in long, shaggy
hair, and otherwise resembling a bear as a human
resembles a chimpanzee, their intimidating stature
makes them targets of prejudice.  They are
sophisticated naturalists in their own right.
END
'max' => {
                          'strength'     => Dice->new(4,6),
                          'constitution' => Dice->new(4,6),
                          'dexterity'    => Dice->new(3,6+1),
                          'intelligence' => Dice->new(3,6-1),
                          'spirit'       => Dice->new(2,6),
                          'charisma'     => Dice->new(2,6),
},
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Ursati',
                          'appearance'   => 'ursine',
                          'color'        => 'brown',
                          'hair_type'    => $Distribution::humanoid_hair_type,
                          'hair_color'   => $Distribution::humanoid_hair_color,
                          'eye_type'     => $Distribution::humanoid_eye_type,
                          'eye_color'    => $Distribution::humanoid_eye_color,
                          'skin_type'    => $Distribution::humanoid_skin_type,
                          'skin_color'   => $Distribution::humanoid_skin_color,
                          'domhand'      => $Distribution::humanoid_hand_dominance,
                          'melee_attacks'=> [ $Attack::punch ],
                         );

$::pc_races =
[
  $human, $dwarf, $elf, $gnome, $demifaery, $ursati
];

### FOREST

$wood_sprite = Actor->new('name'         => 'wood sprite',
'max' => {
                          'strength'     => Dice->new(2,6),
                          'constitution' => Dice->new(2,4),
                          'dexterity'    => Dice->new(4,5,+2),
                          'intelligence' => Dice->new(3,6),
                          'spirit'       => Dice->new(4,5,+1),
                          'charisma'     => Dice->new(4,6,+1),
},
                          'nightvision'  => 1,
                          'resists'      => Resistances->new('wood' => 1.00, 'electricity' => 2.00),
                          'sex'          => 'Neuter',
                          'race'         => 'Sprite',
                          'carcass'      => 0,
                          'appearance'   => 'fairy',
                          'color'        => 'yellow',
                          'hair_type'    => 'fine',
                          'hair_color'   => 'streaming',
                          'eye_type'     => 'sparkling',
                          'eye_color'    => 'pink',
                          'skin_type'    => 'shining',
                          'skin_color'   => 'golden',
                          'combat'       => 'TalentFlee',
                          'melee_attacks'=> [ $Attack::punch ],
                          'body_aim'     => 'small_winged',
                          'encounter'    =>
      Encounter->new('actors' => [ $Actor::wood_sprite ],
                     'friendly' => 1,
                     'itemseller' => 1,
                     'serviceseller' => 1,
                     'persistent' => 1,
                     'message' => '"Can I be of some service, traveller?" says a Wood Sprite.',
                     'lore' => '"Watch out for those exploding tangerines!" chuckles the Sprite.',
                    ),
                         )->implies($Adj::airborne);

#$wood_sprite->learn(Talent::train('druid',1), 100)->perceive_value($Item::spirit_berry->bunch(30)->clone->identify);
#$wood_sprite->learn(Talent::train('druid',2), 100)->perceive_value($Item::spirit_berry->bunch(75)->clone->identify);
$wood_sprite->take($Item::healing_berry->bunch(60)->clone->identify->perceive_value($Item::berry->bunch(20)->clone->identify));
$wood_sprite->take($Item::spirit_berry->bunch(80)->clone->identify->perceive_value($Item::berry->bunch(15)->clone->identify));

$dryad       = Actor->new('name'         => 'dryad',
'max' => {
                          'strength'     => Dice->new(3,6),
                          'constitution' => Dice->new(3,6,+2),
                          'dexterity'    => Dice->new(3,6,+2),
                          'intelligence' => Dice->new(3,6),
                          'spirit'       => Dice->new(3,6,+2),
                          'charisma'     => Dice->new(3,6,+2),
},
                          'melee_attacks'=> [ $Attack::punch, $Attack::punch ],
                          'resists'      => Resistances->new('wood' => 1.10),
                          'torso'        => $Item::thick_fur->clone,
                          'arms'         => $Item::thick_fur->clone,
                          'legs'         => $Item::thick_fur->clone,
                          'waist'        => $Item::thick_fur->clone,
                          'sex'          => 'Male',
                          'race'         => 'Dryad',
                          'appearance'   => 'dryad',
                          'color'        => 'brown',
                          'hair_type'    => 'coarse',
                          'hair_color'   => 'brown',
                          'eye_type'     => 'deep',
                          'eye_color'    => 'brown',
                          'skin_type'    => 'pale',
                          'skin_color'   => 'tawny',
                          'body_aim'     => 'smart_biped');

$treant      = Actor->new('name'         => 'treant',
'max' => {
                          'strength'     => Dice->new(3,6,+5),
                          'constitution' => Dice->new(1,8,+17),
                          'dexterity'    => Dice->new(1,3),
                          'intelligence' => Dice->new(3,6,+2),
                          'spirit'       => Dice->new(3,6,+4),
                          'charisma'     => Dice->new(3,5),
},
                          'nightvision'  => 1,
                          'melee_attacks'=> [ $Attack::branch_rake, $Attack::branch_rake, $Attack::branch_rake, $Attack::branch_rake, $Attack::branch_rake ],
                          'resists'      => Resistances->new('crushing' => 0.33),
                          'head'         => $Item::thick_bark->clone,
                          'legs'         => $Item::nonexistant_part,
                          'feet'         => $Item::nonexistant_part,
                          'torso'        => $Item::thick_bark->clone,
                          'arms'         => $Item::thick_bark->clone,
                          'hands'        => $Item::thick_bark->clone,
                          'waist'        => $Item::thick_bark->clone,
                          'sex'          => 'Neuter',
                          'race'         => 'Plant',
                          'appearance'   => 'tree',
                          'color'        => 'green',
                          'hair_type'    => 'leafy',
                          'hair_color'   => 'green',
                          'eye_type'     => 'knotty',
                          'eye_color'    => 'brown',
                          'skin_type'    => 'tough',
                          'skin_color'   => 'bark',
                          'noncombat'    => 'Rest',
                          'body_aim'     => 'random');

$wood_nymph  = Actor->new('name'         => 'wood nymph',
'max' => {
                          'strength'     => Dice->new(3,4,+2),
                          'constitution' => Dice->new(5,5),
                          'dexterity'    => Dice->new(4,5,+3),
                          'intelligence' => Dice->new(3,6,+2),
                          'spirit'       => Dice->new(3,6,+2),
                          'charisma'     => Dice->new(6,6,+2),
},
                          'nightvision'  => 1,
                          'melee_attacks'=> [ $Attack::punch ],
                          'resists'      => Resistances->new('flesh' => 0.80, 'metal' => 0.80, 'wood' => 1.00, 'plant' => 1.00, 'earth' => 0.80),
                          'hair_color'   => 'ultrabeautiful',
                          'eye_color'    => 'ultrabeautiful',
                          'skin_color'   => 'ultrabeautiful',
                          'sex'          => 'Female',
                          'race'         => 'Nymph',
                          'carcass'      => 0,
                          'combat'       => 'TalentFlee',
                          'appearance'   => 'nymph',
                          'color'        => 'lime',
                          'body_aim'     => 'smart_biped');

$wood_nymph->learn(Talent::cause('blind',Dice->new(6,6,+10)), 100);

### PLAINS

$plains_nymph  = Actor->new('name'         => 'plains nymph',
'max' => {
                          'strength'     => Dice->new(3,4),
                          'constitution' => Dice->new(5,5,-1),
                          'dexterity'    => Dice->new(4,5,+5),
                          'intelligence' => Dice->new(3,6,+1),
                          'spirit'       => Dice->new(3,6,+4),
                          'charisma'     => Dice->new(6,6,+2),
},
                          'nightvision'  => 1,
                          'melee_attacks'=> [ $Attack::punch ],
                          'resists'      => Resistances->new('flesh' => 0.80, 'metal' => 0.80, 'wood' => 0.80, 'plant' => 0.80, 'earth' => 1.00),
                          'hair_color'   => 'ultrabeautiful',
                          'eye_color'    => 'ultrabeautiful',
                          'skin_color'   => 'ultrabeautiful',
                          'sex'          => 'Female',
                          'race'         => 'Nymph',
                          'carcass'      => 0,
                          'combat'       => 'TalentFlee',
                          'appearance'   => 'nymph',
                          'color'        => 'yellow',
                          'body_aim'     => 'smart_biped');

$plains_nymph->learn(Talent::cause('blind',Dice->new(6,6,+10)), 100);

### SWAMP

$swamp_hag   = Actor->new('name'         => 'swamp hag',
'max' => {
                          'strength'     => Dice->new(1,6,+7),
                          'constitution' => Dice->new(2,4,+8),
                          'dexterity'    => Dice->new(4,5),
                          'intelligence' => Dice->new(1,6,+10),
                          'spirit'       => Dice->new(2,6,+12),
                          'charisma'     => 1,
},
                          'nightvision'  => 1,
                          'melee_attacks'=> [ $Attack::icy_touch ],
                          'resists'      => Resistances->new('water' => 0.50,'cold' => 0.25),
                          'torso'        => $Item::rags->make($Adj::canvas)->clone,
                          'arms'         => $Item::rags->make($Adj::canvas)->clone,
                          'legs'         => $Item::rags->make($Adj::canvas)->clone,
                          'waist'        => $Item::rags->make($Adj::canvas)->clone,
                          'hair_color'   => 'ultraugly',
                          'eye_color'    => 'ultraugly',
                          'skin_color'   => 'ultraugly',
                          'sex'          => 'Female',
                          'race'         => 'Hag',
                          'carcass'      => 0,
                          'combat'       => 'TalentAttack',
                          'appearance'   => 'hag',
                          'color'        => 'blue',
                          'body_aim'     => 'smart_biped');

require "$::universe/Undead.pm";

### DWARKLING HIDEOUTS

$dwarkling   = Actor->new('name'         => 'dwarkling',
'max' => {
                          'strength'     => Dice->new(2,6),
                          'constitution' => Dice->new(2,6),
                          'dexterity'    => Dice->new(3,6),
                          'intelligence' => Dice->new(2,6),
                          'spirit'       => Dice->new(2,6),
                          'charisma'     => Dice->new(3,6),
},
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Dwarkling',
                          'appearance'   => 'dwark',
                          'color'        => 'green',
                          'hair_type'    => 'mangy',
                          'hair_color'   => 'black',
                          'eye_type'     => 'tiny',
                          'eye_color'    => 'grey',
                          'skin_type'    => 'slimy',
                          'skin_color'   => 'green',
                          'body_aim'     => 'smart_biped',
                          'melee_attacks'=> [ $Attack::punch ],
                         );

$guard_dog     =  Actor->new('name'         => 'guard dog',
'max' => {
                          'strength'     => Dice->new(2,6,-1),
                          'constitution' => Dice->new(2,5,+1),
                          'dexterity'    => Dice->new(2,8),
                          'intelligence' => Dice->new(2,2,+1),
                          'spirit'       => Dice->new(2,3,-1),
                          'charisma'     => Dice->new(2,3),
},
                          'nightvision'  => 1,
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Canine',
                          'melee_attacks'=> [ $Attack::dog_bite ],
                          'appearance'   => 'canine',
                          'color'        => 'brown',
                          'hair_type'    => 'shaggy',
                          'hair_color'   => 'brown',
                          'eye_type'     => 'blood',
                          'eye_color'    => 'red',
                          'skin_type'    => 'rough',
                          'skin_color'   => 'pink',
                          'body_aim'     => 'pouncer');

$grue       =  Actor->new('name'         => 'grue',
'max' => {
                          'strength'     => Dice->new(2,2,+1),
                          'constitution' => Dice->new(2,2),
                          'dexterity'    => Dice->new(1,8,+12),
                          'intelligence' => Dice->new(2,6,+1),
                          'spirit'       => Dice->new(2,4,-1),
                          'charisma'     => Dice->new(2,2,-1),
},
                          'nightvision'  => 1,
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Grue',
                          'carcass'      => 0,
                          'melee_attacks'=> [ $Attack::cat_claw, $Attack::cat_claw ],
                          'appearance'   => 'grue',
                          'color'        => 'black',
                          'hair_color'   => 'no',
                          'eye_type'     => 'tiny',
                          'eye_color'    => 'red',
                          'skin_type'    => 'slick',
                          'skin_color'   => 'black',
                          'body_aim'     => 'dumb_biped');

### GRUMCHIKS

$grumchik    = Actor->new('name'         => 'grumchik',
'max' => {
                          'strength'     => Dice->new(4,4),
                          'constitution' => Dice->new(4,4),
                          'dexterity'    => Dice->new(4,4),
                          'intelligence' => Dice->new(4,4),
                          'spirit'       => Dice->new(4,4),
                          'charisma'     => Dice->new(4,4),
},
                          'nightvision'  => 1,
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Grumchik',
                          'appearance'   => 'grumchik',
                          'color'        => 'blue',
                          'hair_type'    => 'spiky',
                          'hair_color'   => 'black',
                          'eye_type'     => 'beady',
                          'eye_color'    => 'white',
                          'skin_type'    => 'scaly',
                          'skin_color'   => 'black',
                          'body_aim'     => 'smart_biped',
                          'combat'       => 'TalentFight',
                          'melee_attacks'=> [ $Attack::punch, $Attack::punch ],
                         );

$grumchik->learn($Talent::blur_self, 66);

sub miserable
{
  my $self = shift;
  my $z = $self->copy;
  $z->{max} = { %{$self->{max}} };
  $z->{op}  = { %{$self->{op}}  };
  if (ref($z->{max}{spirit}) eq 'Dice')
  {
    $z->{max}{spirit}->improve(-2);
    $z->{max}{charisma}->improve(-1);
  } else
  {
    $z->{max}{spirit} -= 2;
    $z->{max}{charisma} -= 1;
  }
  $z->{name} = "miserable $z->{name}";
  return $z;
}

sub surly
{
  my $self = shift;
  my $z = $self->copy;
  $z->{max} = { %{$self->{max}} };
  $z->{op}  = { %{$self->{op}}  };
  if (ref($z->{max}{charisma}) eq 'Dice')
  {
    $z->{max}{charisma}->improve(-3);
  } else
  {
    $z->{max}{charisma} -= 3;
  }
  $z->{name} = "surly $z->{name}";
  return $z;
}

sub pudgy
{
  my $self = shift;
  my $z = $self->copy;
  $z->{max} = { %{$self->{max}} };
  $z->{op}  = { %{$self->{op}}  };
  if (ref($z->{max}{strength}) eq 'Dice')
  {
    $z->{max}{strength}->improve(-2);
    $z->{max}{dexterity}->improve(-2);
    $z->{max}{constitution}->improve(+1);
  } else
  {
    $z->{max}{strength} -= 2;
    $z->{max}{dexterity} -= 2;
    $z->{max}{constitution} += 1;
  }
  $z->{name} = "pudgy $z->{name}";
  return $z;
}

sub wily
{
  my $self = shift;
  my $z = $self->copy;
  $z->{max} = { %{$self->{max}} };
  $z->{op}  = { %{$self->{op}}  };
  if (ref($z->{max}{spirit}) eq 'Dice')
  {
    $z->{max}{spirit}->improve(-3);
    $z->{max}{strength}->improve(-2);
    $z->{max}{dexterity}->improve(+1);
    $z->{max}{intelligence}->improve(+1);
  } else
  {
    $z->{max}{spirit} -= 3;
    $z->{max}{strength} -= 2;
    $z->{max}{dexterity} += 1;
    $z->{max}{intelligence} += 1;
  }
  $z->{name} = "wily $z->{name}";
  return $z;
}

### TRAIPLES

$traiple     = Actor->new('name'         => 'traiple',
'max' => {
                          'strength'     => Dice->new(3,4),
                          'constitution' => Dice->new(5,4),
                          'dexterity'    => Dice->new(5,4,-1),
                          'intelligence' => Dice->new(3,4),
                          'spirit'       => Dice->new(4,4,+2),
                          'charisma'     => Dice->new(3,8),
},
                          'nightvision'  => 1,
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Traiple',
                          'appearance'   => 'traiple',
                          'color'        => 'yellow',
                          'hair_type'    => 'fluffy',
                          'hair_color'   => 'orange',
                          'eye_type'     => 'wide',
                          'eye_color'    => 'red',
                          'skin_type'    => 'smooth',
                          'skin_color'   => 'yellow',
                          'melee_attacks'=> [ $Attack::bear_claw ],
                          'body_aim'     => 'smart_biped',
                          'combat'       => 'TalentFight',
                          'resists'      => Resistances->new('cutting' => 0.25),
                         );

$traiple->learn(Talent::cause('confused', Dice->new(1,3))->new_recharge(14), 90);

1;
