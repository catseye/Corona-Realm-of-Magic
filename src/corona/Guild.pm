# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see file LICENSE for more info.

package Actor;

### ACTOR MODS

$::guild =
{
  'soldier' =>
  {
    'prime' => 'strength',
    'basex' => 150,
    'skill' =>
    [
      Talent::weapon_proficiency($Item::dagger), 1, 
      Talent::weapon_proficiency($Item::longsword), 1, 
      Talent::weapon_proficiency($Item::club), 1, 
      Talent::weapon_proficiency($Item::hammer), 1, 
      Talent::weapon_proficiency($Item::hand_axe), 1,
      Talent::armour_proficiency('head'), 1, 
      Talent::armour_proficiency('shoulders'), 1, 
      Talent::armour_proficiency('arms'), 1, 
      Talent::armour_proficiency('hands'), 1, 
      Talent::armour_proficiency('torso'), 1, 
      Talent::armour_proficiency('waist'), 1, 
      Talent::armour_proficiency('legs'), 1, 
      Talent::armour_proficiency('feet'), 1, 
    ],
    'equip' =>
    {
      'rhand' =>
      [
        Distribution->new(0.50 => $Item::longsword->make($Adj::iron),
                          0.50 => $Item::broadsword->make($Adj::iron)), 1,
      ],
      'lhand' =>
      [
        $Item::mundane_torch, 1,
      ],
    }
  },
  'ranger' =>
  {
    'prime' => 'constitution',
    'basex' => 150,
    'skill' =>
    [
      $Talent::identify_food, 1,
      $Talent::calisthenics, 1,
      Talent::armour_proficiency('head'), 1, 
      Talent::weapon_proficiency($Item::short_bow), 1, 
    ],
    'equip' =>
    {
      'rhand' =>
      [
        Distribution->new(0.50 => $Item::short_sword->make($Adj::iron),
                          0.50 => $Item::broadsword->make($Adj::iron)), 1,
      ],
      'lhand' =>
      [
        $Item::mundane_torch, 1,
      ],
    },
  },
  'thief' =>
  {
    'prime' => 'dexterity',
    'basex' => 150,
    'skill' =>
    [
      $Talent::stretching_exercises, 1,
      # $Talent::hide_in_shadows, 1,
      Talent::armour_proficiency('shoulders'), 1, 
      Talent::weapon_proficiency($Item::dagger), 1, 
    ],
    'equip' =>
    {
      'rhand' =>
      [
        Distribution->new(0.50 => $Item::short_sword->make($Adj::iron),
                          0.50 => $Item::dagger->make($Adj::iron)), 1,
      ],
      'lhand' =>
      [
        $Item::mundane_torch, 1,
      ],
    }
  },
  'mage' =>
  {
    'prime' => 'intelligence',
    'basex' => 150,
    'skill' =>
    [
      Talent::magic_theory('sorcery'), 1,

      $Talent::exploding_projectile, 1,
      $Talent::wizard_window, 1,
      $Talent::blur_self, 1,
      Talent::detect($Adj::magic), 1,
      Talent::touch($Adj::cold, Dice->new(1,4,+1)), 1,

      Talent::bolt($Adj::fire, Dice->new(2,4)), 3,

      $Talent::gigantic_growth, 4,

      $Talent::magic_mapping, 9,
    ],
    'equip' =>
    {
      'rhand' =>
      [
        Distribution->new(0.50 => $Item::quarterstaff->make($Adj::wood),
                          0.50 => $Item::knife->make($Adj::iron)), 1,
        Distribution->new(0.50 => $Item::quarterstaff->make($Adj::wood)->magicked(+1),
                          0.50 => $Item::knife->make($Adj::iron)->fine), 2,
      ],
      'lhand' =>
      [
        $Item::mundane_torch, 1,
      ],
    },
  },
  'cleric' =>
  {
    'prime' => 'spirit',
    'basex' => 150,
    'skill' =>
    [
      $Talent::ceremonial_burial, 1,
      $Talent::minor_heal, 1,
       Talent::detect($Adj::water), 1,

      $Talent::consecrate_ground, 2,

      $Talent::major_heal, 3,

      Talent::weapon_proficiency($Item::flail), 4,
      Talent::weapon_proficiency($Item::hammer), 4,

      Talent::cure('blind'), 5,
    ],
    'equip' =>
    {
      'rhand' =>
      [
        Distribution->new(0.50 => $Item::flail,
                          0.50 => $Item::mace), 1,
        Distribution->new(0.50 => $Item::flail->make($Adj::iron)->magicked(+1),
                          0.50 => $Item::mace->make($Adj::iron)->fine), 2,
        Distribution->new(0.50 => $Item::flail->make($Adj::iron)->fine->magicked(+1),
                          0.50 => $Item::mace->make($Adj::iron)->magicked(+2)), 5,
      ],
      'lhand' =>
      [
        $Item::mundane_torch, 1,
      ],
    },
  },
  'bard' =>
  {
    'prime' => 'charisma',
    'basex' => 150,
    'skill' =>
    [
      $Talent::charm, 2,
      # $Talent::play($instrument), 1,
      Talent::armour_proficiency('hands'), 1, 
      Talent::weapon_proficiency($Item::club), 3,
    ],
    'equip' =>
    {
      'rhand' =>
      [
        Distribution->new(0.50 => $Item::club->make($Adj::wood),
                          0.50 => $Item::dagger->make($Adj::iron)), 1,
      ],
      'lhand' =>
      [
        $Item::mundane_torch, 1,
      ],
    },
  },
  ### NPC CLASSES ###
  'smith' =>
  {
    'prime' => 'strength',
    'basex' => 100,
    'skill' =>
    [
      # $Talent::identify_metal, 1,
    ],
    'equip' =>
    {
      'rhand' =>
      [
        Distribution->new(0.50 => $Item::rod->make($Adj::iron)->red_hot,
                          0.50 => $Item::hammer->make($Adj::steel)), 1,
      ],
      'lhand' =>
      [
        $Item::mundane_torch, 1,
      ],
#      'hands' =>
#      [
#        $Item::chain_gloves->make($Adj::copper), 1,
#      ],
    },
  },
  'farmer' =>
  {
    'prime' => 'constitution',
    'basex' => 100,
    'skill' =>
    [
      $Talent::identify_food, 1,
    ],
    'equip' =>
    {
      'rhand' =>
      [
        Distribution->new(0.20 => $Item::quarterstaff->make($Adj::wood)->crude,
                          0.20 => $Item::hoe->make($Adj::copper),
                          0.20 => $Item::shovel->make($Adj::iron),
                          0.20 => $Item::scythe->make($Adj::iron)), 1,
        Distribution->new(0.20 => $Item::quarterstaff->make($Adj::wood),
                          0.20 => $Item::hoe->make($Adj::steel)->magicked(+1),
                          0.20 => $Item::shovel->make($Adj::steel)->fine,
                          0.20 => $Item::scythe->make($Adj::iron)->fine), 4,
      ],
      'lhand' =>
      [
        $Item::mundane_torch, 1,
      ],
    },
  },
  'carpenter' =>
  {
    'prime' => 'dexterity',
    'basex' => 100,
    'skill' =>
    [
      # $Talent::identify_wood, 1,
    ],
    'equip' =>
    {
      'rhand' =>
      [
        Distribution->new(0.50 => $Item::club->make($Adj::wood)->fine,
                          0.50 => $Item::quarterstaff->make($Adj::wood)->fine), 1,
      ],
      'lhand' =>
      [
        $Item::mundane_torch, 1,
      ],
    },
  },
  'sage' =>
  {
    'prime' => 'intelligence',
    'basex' => 100,
    'skill' =>
    [
      # $Talent::lore, 1,
    ],
    'equip' =>
    {
      'rhand' =>
      [
        Distribution->new(0.50 => $Item::knife->make($Adj::copper)->fine,
                          0.50 => $Item::knife->make($Adj::bronze)->fine), 1,
      ],
      'lhand' =>
      [
        $Item::mundane_torch, 1,
      ],
    },
  },
  'sailor' =>
  {
    'prime' => 'spirit',
    'basex' => 100,
    'skill' =>
    [
      # $Talent::sea_legs, 1,
    ],
    'equip' =>
    {
      'rhand' =>
      [
        Distribution->new(0.50 => $Item::katana->make($Adj::bronze),
                          0.50 => $Item::club->make($Adj::wood)), 1,
      ],
      'lhand' =>
      [
        $Item::mundane_torch, 1,
      ],
    },
  },
  'merchant' =>
  {
    'prime' => 'charisma',
    'basex' => 100,
    'skill' =>
    [
      # $Talent::identify_item, 4,
      # $Talent::appraise_gem, 4,
    ],
    'equip' =>
    {
      'rhand' =>
      [
        Distribution->new(0.50 => $Item::dagger->make($Adj::iron)->fine,
                          0.50 => $Item::club->make($Adj::wood)->fine), 1,
        Distribution->new(0.50 => $Item::knife->make($Adj::iron)->magicked(+3),
                          0.50 => $Item::shovel->make($Adj::iron)->fine->magicked(+1)), 4,
      ],
      'lhand' =>
      [
        $Item::mundane_torch, 1,
      ],
    },
  },
  ### COMBINATION CLASSES
  'necromancer' =>
  {
    'prime'  => 'intelligence',
    'second' => 'spirit',
    'basex' => 800,
    'skill' =>
    [
      Talent::summon($Actor::floating_skull, Dice->new(2,3)), 5
    ],
    'equip' =>
    {
      'rhand' =>
      [
        Distribution->new(0.70 => $Item::knife->make($Adj::iron)->fine,
                          0.30 => $Item::dagger->make($Adj::iron)->magicked(+1)), 1,
      ],
      'lhand' =>
      [
        $Item::mundane_torch, 1,
      ],
    },
    'prereq' =>
    {
      'mage'   => 6,
      'cleric' => 4,
    },
  },
  'druid' =>
  {
    'prime'  => 'constitution',
    'second' => 'spirit',
    'basex' => 800,
    'skill'  =>
    [
      $Talent::identify_food, 1,
      $Talent::empathy,       2,
    ],
    'equip' =>
    {
      'rhand' =>
      [
        $Item::mundane_torch, 1,
        Distribution->new(0.70 => $Item::quarterstaff->make($Adj::wood)->fine,
                          0.30 => $Item::club->make($Adj::wood)->fine), 1,   # sickle??
      ],
      'lhand' =>
      [
        $Item::mundane_torch, 1,
      ],
    },
    'prereq' =>
    {
      'ranger' => 6,
      'cleric' => 4,
    },
  },
  'ninja' =>
  {
    'prime'  => 'dexterity',
    'second' => 'intelligence',
    'basex' => 800,
    'skill' =>
    [
      $Talent::identify_food, 1,
    ],
    'equip' =>
    {
      'rhand' =>
      [
        Distribution->new(0.70 => $Item::katana->make($Adj::iron)->magicked(+1),
                          0.30 => $Item::dagger->make($Adj::iron)->fine), 1,
      ],
      'lhand' =>
      [
        $Item::mundane_torch, 1,  # lantern-ring?
      ],
    },
    'prereq' =>
    {
      'thief'  => 6,
      'mage'   => 4,
    },
  },

};

sub class
{
  my $self = shift;
  my $g = shift;
  my $level = shift;
  my $n = $self->copy;

  carp "No such class as $g" if not exists $::guild->{$g};

  $n->{max} = { %{$self->{max}} };
  $n->{op}  = { %{$self->{op}}  };

  $n->{name} .= " $g" if not $n->{proper};
  $n->{standing}{$g} = $level if (not defined $n->{standing}{$g}) or $n->{standing}{$g} < $level;
  if (exists $::guild->{$g}{second})
  {
    $n->{max}{$::guild->{$g}{prime}} = 
      $n->{max}{$::guild->{$g}{prime}}->improve(::d(1,int($level/2)+1));
    $n->{max}{$::guild->{$g}{second}} = 
      $n->{max}{$::guild->{$g}{second}}->improve(::d(1,int($level/2)));
  } else
  {
    $n->{max}{$::guild->{$g}{prime}} = 
      $n->{max}{$::guild->{$g}{prime}}->improve(::d(1,$level));
  }

  my $i=0;
  for ($i=0; $i <= $#{$::guild->{$g}{skill}}; $i += 2)
  {
    my $x = $::guild->{$g}{skill}->[$i];
    my $j = ($level+1)-$::guild->{$g}{skill}->[$i+1];
    $x = $x->pick if ref($x) eq 'Distribution';      # this should happen later
    if (defined $x)
    {
      $n->learn($x, ::d(3*$j,6));
    }
  }

  $n->{belongings} = [];
  my $bp;
  foreach $bp (keys %{$Actor::wtable})
  {
    my $bpk = $Actor::wtable->{$bp}[0];
    next if not exists $::guild->{$g}{equip}{$bpk};
    for ($i=0; $i <= $#{$::guild->{$g}{equip}{$bpk}}; $i += 2)
    {
      my $x = $::guild->{$g}{equip}{$bpk}[$i];
      $n->{$bpk} = $x;
    }
  }

  return $n;
}

1;
