# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see file LICENSE for more info.

### UNDEAD

$floating_skull =  Actor->new('name'         => 'floating skull',
'max' => {
                          'strength'     => Dice->new(1,2),
                          'constitution' => Dice->new(1,1),
                          'dexterity'    => Dice->new(3,3,+1),
                          'intelligence' => Dice->new(1,4,+7),
                          'spirit'       => Dice->new(2,8),
                          'charisma'     => Dice->new(2,4,+10),
},
                          'head'         => $Item::bony_exterior->clone,
                          'arms'         => $Item::nonexistant_part,
                          'hands'        => $Item::nonexistant_part,
                          'legs'         => $Item::nonexistant_part,
                          'feet'         => $Item::nonexistant_part,
                          'torso'        => $Item::nonexistant_part,
                          'shoulders'    => $Item::nonexistant_part,
                          'waist'        => $Item::nonexistant_part,
                          'sex'          => $Distribution::even_sex,
                          'race'         => 'Undead',
                          'carcass'      => 0,
                          'combat'       => 'TalentFight',
                          'melee_attacks'=> [ $Attack::skull_ram ],
                          'hitbonus'     => -1,
                          'resists'      => Resistances->new('cold' => 0.90),
                          'appearance'   => 'skeleton',
                          'color'        => 'white',
                          'hair_color'   => 'no',
                          'eye_type'     => 'glowing',
                          'eye_color'    => 'red',
                          'skin_color'   => 'no',
                          'body_aim'     => 'pouncer')->implies($Adj::airborne);

$floating_skull->learn($Talent::laugh_of_insanity, 75);

sub zombie
{
  my $self = shift;
  my $z = $self->copy;
  $z->{max} = { %{$self->{max}} };
  $z->{op}  = { %{$self->{op}}  };
  if (ref($z->{max}{strength}) eq 'Dice')
  {
    $z->{max}{strength}->improve_faces(0.75);
    $z->{max}{constitution}->improve_faces(0.75);
    $z->{max}{dexterity}->improve_faces(0.50);
  } else
  {
    $z->{max}{strength} = int($z->{max}{strength} * 0.75);
    $z->{max}{constitution} = int($z->{max}{constitution} * 0.75);
    $z->{max}{dexterity} = int($z->{max}{dexterity} * 0.50);
  }
  $z->{max}{intelligence} = 1;
  $z->{max}{spirit} = 1;
  $z->{max}{charisma} = 1;

  $z->{resists} = Resistances->new('cold' => 0.50);

  $z->{color} = 'grey';
  $z->{appearance} = 'zombie';
  $z->{name} .= ' zombie';
  $z->{skin_type} = 'rotting';
  $z->{hair_type} = 'moldy';
  $z->{eye_type} = 'cold';
  $z->{eye_color} = 'red';
  return $z;
}

sub skeleton
{
  my $self = shift;
  my $z = $self->copy;
  $z->{max} = { %{$self->{max}} };
  $z->{op}  = { %{$self->{op}}  };
  if (ref($z->{max}{strength}) eq 'Dice')
  {
    $z->{max}{strength}->improve_faces(0.50);
    $z->{max}{constitution}->improve_faces(0.66);
  } else
  {
    $z->{max}{strength} = int($z->{max}{strength} * 0.50);
    $z->{max}{constitution} = int($z->{max}{constitution} * 0.66);
  }
  $z->{max}{intelligence} = 1;
  $z->{max}{spirit} = 1;
  $z->{max}{charisma} = 1;

  $z->{resists} = Resistances->new('cold' => 0.90, 'piercing' => 0.33);
  $z->{melee_attacks} = [ $Attack::bone_punch ];

  $z->{color} = 'white';
  $z->{appearance} = 'skeleton';
  $z->{name} .= ' skeleton';
  $z->{skin_type} = '';
  $z->{skin_color} = 'no';
  $z->{hair_type} = '';
  $z->{hair_color} = 'no';
  $z->{eye_type} = 'empty';
  $z->{eye_color} = 'socketed';
  return $z;
}


sub ghoul
{
  my $self = shift;
  my $z = $self->copy;
  $z->{max} = { %{$self->{max}} };
  $z->{op}  = { %{$self->{op}}  };
  if (ref($z->{max}{strength}) eq 'Dice')
  {
    $z->{max}{strength}->improve_faces(0.75);
    $z->{max}{dexterity}->improve_faces(1.25);
    $z->{max}{intelligence} = Dice->new(1,4);
    $z->{max}{spirit} = Dice->new(1,4);
  } else
  {
    $z->{max}{strength} = int($z->{max}{strength} * 0.75);
    $z->{max}{dexterity} = int($z->{max}{dexterity} * 1.25);
    $z->{max}{intelligence} = ::d(1,4);
    $z->{max}{spirit} = ::d(1,4);
  }

  $z->{max}{charisma} = 1;

  $z->{resists} = Resistances->new('cold' => 0.75, 'cutting' => 0.25, 'piercing' => 0.10);
  $z->{melee_attacks} = [ $Attack::icy_touch ];

  # paralyzation on-hit

  $z->{color} = 'cyan';
  $z->{appearance} = 'zombie';
  $z->{name} .= ' ghoul';
  $z->{skin_type} = 'greasy';
  $z->{skin_color} = 'grey';
  $z->{hair_type} = 'moldy';
  $z->{eye_type} = 'hateful';
  $z->{eye_color} = 'red';
  return $z;
}

sub juju_zombie
{
  my $self = shift;
  my $z = $self->copy;
  $z->{max} = { %{$self->{max}} };
  $z->{op}  = { %{$self->{op}}  };
  if (ref($z->{max}{strength}) eq 'Dice')
  {
    $z->{max}{strength}->improve_faces(1.66);
    $z->{max}{constitution}->improve_faces(1.50);
    $z->{max}{dexterity}->improve_faces(1.33);
    $z->{max}{intelligence} = Dice->new(1,4,+1);
    $z->{max}{spirit} = Dice->new(1,4,+1);
    $z->{max}{charisma} = Dice->new(1,2);
  } else
  {
    $z->{max}{strength} = int($z->{max}{strength} * 1.66);
    $z->{max}{constitution} = int($z->{max}{constitution} * 1.50);
    $z->{max}{dexterity} = int($z->{max}{dexterity} * 1.33);
    $z->{max}{intelligence} = ::d(1,4)+1;
    $z->{max}{spirit} = ::d(1,4)+1;
    $z->{max}{charisma} = ::d(1,2);
  }

  $z->{resists} = Resistances->new('cold' => 0.80, 'cutting' => 0.25, 'piercing' => 0.10);

  $z->{melee_attacks} = [ $Attack::icy_touch ];

  $z->{color} = 'lime';
  $z->{appearance} = 'zombie';
  $z->{name} .= ' juju zombie';
  $z->{skin_type} = 'rotting';
  $z->{skin_color} = 'green';
  $z->{hair_type} = 'moldy';
  $z->{eye_type} = 'hateful';
  $z->{eye_color} = 'red';
  return $z;
}

sub ghast
{
  my $self = shift;
  my $z = $self->copy;
  $z->{max} = { %{$self->{max}} };
  $z->{op}  = { %{$self->{op}}  };
  if (ref($z->{max}{strength}) eq 'Dice')
  {
    $z->{max}{strength}->improve_faces(0.75);
    $z->{max}{dexterity}->improve_faces(1.25);
  } else
  {
    $z->{max}{strength} = int($z->{max}{strength} * 0.75);
    $z->{max}{dexterity} = int($z->{max}{dexterity} * 1.25);
  }

  $z->{max}{charisma} = 1;

  $z->{resists} = Resistances->new('cold' => 1.00, 'metal' => 1.00, 'wood' => 1.00,
                                   'cutting' => 1.00, 'piercing' => 1.00, 'crushing' => 1.00);
  $z->{melee_attacks} = [ $Attack::icy_touch ];

  $z->learn($Talent::laugh_of_insanity, 50);

  $z->{color} = 'cyan';
  $z->{appearance} = 'zombie';
  $z->{name} .= ' ghast';
  $z->{skin_type} = 'translucent';
  $z->{skin_color} = 'cyan';
  $z->{hair_type} = 'moldy';
  $z->{eye_type} = 'bloody';
  $z->{eye_color} = 'red';
  return $z;
}

sub ghost
{
  my $self = shift;
  my $z = $self->copy;
  $z->{max} = { %{$self->{max}} };
  $z->{op}  = { %{$self->{op}}  };

  $z->{max}{strength} = 1;
  $z->{max}{constitution} = 1;

  $z->{resists} = Resistances->new('cold' => 1.00, 'fire' => 1.00, 'metal' => 1.00, 'wood' => 1.00,
                                   'cutting' => 1.00, 'piercing' => 1.00, 'crushing' => 1.00);
  $z->{melee_attacks} = [ $Attack::icy_touch ];
  # fear, paralyzation talents

  $z->{color} = 'white';
  $z->{name} .= ' ghost';
  $z->{skin_type} = '';
  $z->{skin_color} = 'translucent';
  $z->{hair_type} = '';
  $z->{hair_color} = 'streaming';
  $z->{eye_type} = 'distant';
  $z->{eye_color} = 'grey';

  $z->implies($Adj::ethereal);

  return $z;
}

sub spectre
{
  my $self = shift;
  my $z = $self->copy;
  $z->{max} = { %{$self->{max}} };
  $z->{op}  = { %{$self->{op}}  };
  if (ref($z->{max}{strength}) eq 'Dice')
  {
    $z->{max}{spirit}->improve_faces(6);
  } else
  {
    $z->{max}{spirit} = int($z->{max}{spirit} * 6);
  }

  $z->{max}{strength} = 1;
  $z->{max}{constitution} = 1;

  $z->{resists} = Resistances->new('cold' => 1.25, 'fire' => 1.00, 'metal' => 1.00, 'wood' => 1.00,
                                   'cutting' => 1.00, 'piercing' => 1.00, 'crushing' => 1.00);
  $z->{melee_attacks} = [ $Attack::icy_touch, $Attack::icy_touch ];

  $z->{color} = 'black';
  $z->{name} .= ' spectre';
  $z->{skin_type} = '';
  $z->{skin_color} = 'shimmering';
  $z->{hair_type} = '';
  $z->{hair_color} = 'whilring';
  $z->{eye_type} = 'mourning';

  $z->implies($Adj::ethereal);

  return $z;
}

sub lich
{
  my $self = shift;
  my $z = $self->copy;
  $z->{max} = { %{$self->{max}} };
  $z->{op}  = { %{$self->{op}}  };
  if (ref($z->{max}{strength}) eq 'Dice')
  {
    $z->{max}{strength}->improve_faces(0.66);
    $z->{max}{dexterity}->improve_faces(1.25);
    $z->{max}{constitution}->improve_faces(2);
    $z->{max}{intelligence}->improve_faces(1.5);
    $z->{max}{spirit}->improve_faces(3);
  } else
  {
    $z->{max}{strength} = int($z->{max}{strength} * 0.66);
    $z->{max}{dexterity} = int($z->{max}{dexterity} * 1.25);
    $z->{max}{constitution} = int($z->{max}{constitution} * 2);
    $z->{max}{intelligence} = int($z->{max}{intelligence} * 1.5);
    $z->{max}{spirit} = int($z->{max}{spirit} * 3);
  }

  $z->{max}{charisma} = 1;

  $z->{resists} = Resistances->new('cold' => 1.00, 'fire' => 0.90, 'metal' => 0.90, 'wood' => 0.90,
                                   'cutting' => 0.90, 'piercing' => 0.90, 'crushing' => 0.90);
  $z->{melee_attacks} = [ $Attack::icy_touch, $Attack::bone_punch ];

  $z->learn($Talent::laugh_of_insanity, 100);
  # confusion talent
  # drain experience/degrade talent
  # cause disease

  $z->{color} = 'red';
  $z->{appearance} = 'zombie';
  $z->{name} .= ' lich';
  $z->{skin_type} = 'shrivelled';
  $z->{skin_color} = 'grey';
  $z->{hair_type} = 'moldy';
  $z->{eye_type} = 'bloody';
  $z->{eye_color} = 'red';
  return $z;
}

# mummy, vamipre, demons et al

1;
