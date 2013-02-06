# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see file LICENSE for more info.

package Item;

### BUILT-IN ITEMS ###

### FOOD ###

$ration = Item->new('name' => 'ration',
                    'identity' => 'edible ration',
                    'appearance' => 'food',
                    'color' => 'brown',
                    'weight' => 2,
                    'melee_attacks' => Attack->weapon(-1, Dice->new(1,2,-1), $Adj::flesh, $Adj::crushing),
                   )->implies($Adj::edible);

$pepper = Item->new('name' => 'pepper',
                    'identity' => 'ripe pepper',
                    'appearance' => 'vegetable',
                    'color' => 'red',
                    'weight' => 1,
                    'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2,-1), $Adj::plant, $Adj::crushing) ],
                   )->implies($Adj::edible);

$hot_pepper = Item->new('name' => 'pepper',
                    'identity' => 'hot pepper',
                    'appearance' => 'vegetable',
                    'color' => 'red',
                    'weight' => 1,
                    'on_consume' => <<'END',
                       my ($self, $consumer) = @_;
                       $consumer->{dumb} += ::d(2,3);
                       $consumer->seen($consumer, "<self>'s mouth burns up!");
                       $consumer->review;
END
                    'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2,-1), $Adj::plant, $Adj::crushing), ],
                   )->implies($Adj::edible);

$mundane_mushroom = Item->new('name' => 'mushroom',
                    'identity' => 'mundane mushroom',
                    'appearance' => 'fungus',
                    'color' => 'grey',
                    'weight' => 1,
                    'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2,-1), $Adj::fungus, $Adj::crushing), ],
                   )->implies($Adj::edible);

$poison_mushroom  = Item->new('name' => 'mushroom',
                    'identity' => 'poison mushroom',
                    'appearance' => 'fungus',
                    'color' => 'brown',
                    'weight' => 1,
                    'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2,-1), $Adj::fungus, $Adj::crushing), ],
                    'on_consume' => <<'END',
                         my ($self, $consumer) = @_;
                         $Talent::orange_poison->clone->poison($consumer);
END
                   )->implies($Adj::edible);

$mushroom_of_swiftness = Item->new('name' => 'mushroom',
                    'identity' => 'mushroom of swiftness',
                    'appearance' => 'fungus',
                    'color' => 'grey',
                    'weight' => 1,
                    'on_consume' => <<'END',
                       my ($self, $consumer) = @_;
                       $consumer->{max}{dexterity}++;
                       $consumer->seen($consumer, "<self> feels swifter!");
END
                    'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2,-1), $Adj::magic, $Adj::fungus, $Adj::crushing), ],
                   )->implies($Adj::edible);

$cabbage = Item->new('name' => 'cabbage',
                    'identity' => 'ripe cabbage',
                    'appearance' => 'vegetable',
                    'color' => 'purple',
                    'weight' => 3,
                    'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2,-1), $Adj::plant, $Adj::crushing), ],
                   )->implies($Adj::edible);

$death_cabbage = Item->new('name' => 'cabbage',
                    'identity' => 'death cabbage',
                    'appearance' => 'vegetable',
                    'color' => 'purple',
                    'weight' => 3,
                    'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2,-1), $Adj::plant, $Adj::crushing), ],
                    'on_consume' => <<'END',
                         my ($self, $consumer) = @_;
                         $Talent::death_poison->clone->poison($consumer);
END
                   )->implies($Adj::edible);

$clove_of_garlic    = Item->new('name' => 'clove',
                      'plural' => 'cloves',
                      'identity' => 'clove of garlic',
                      'pluralid' => 'cloves of garlic',
                      'appearance' => 'vegetable',
                      'color' => 'white',
                      'weight' => 1,
                      'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,1), $Adj::garlic, $Adj::crushing), ],
                      'on_consume' => <<'END',
                         my ($self, $consumer) = @_;
                         $consumer->adjust('charisma',0-::d(1,2),$self);
                         $consumer->seen($consumer, "<self>'s breath now reeks of garlic!");
END
                     )->implies($Adj::edible);

$clove_of_ginger    = Item->new('name' => 'clove',
                      'plural' => 'cloves',
                      'identity' => 'clove of ginger',
                      'pluralid' => 'cloves of ginger',
                      'appearance' => 'vegetable',
                      'color' => 'grey',
                      'weight' => 1,
                      'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,1), $Adj::ginger, $Adj::crushing), ],
                     )->implies($Adj::edible);

$sprig_of_mint     = Item->new('name' => 'sprig',
                      'plural' => 'sprigs',
                      'identity' => 'sprig of mint',
                      'pluralid' => 'sprig of mint',
                      'appearance' => 'vegetable',
                      'color' => 'lime',
                      'weight' => 1,
                      'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,1), $Adj::mint, $Adj::crushing), ],
                      'on_consume' => <<'END',
                         my ($self, $consumer) = @_;
                         $consumer->adjust('charisma',+::d(1,2),$self);
                         $consumer->seen($consumer, "<self>'s breath is now fresh and minty.");
END
                     )->implies($Adj::edible);

$belladonna = Item->new('name' => 'stalk',
                      'plural' => 'stalks',
                      'identity' => 'stalk of belladonna',
                      'pluralid' => 'stalks of belladonna',
                      'appearance' => 'stalk',
                      'color' => 'green',
                      'weight' => 1,
                      'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,1), $Adj::belladonna, $Adj::crushing), ],
                      'on_consume' => <<'END',
                         my ($self, $consumer) = @_;
                         # $Talent::belladonna_poison->clone->poison($consumer);
                         # cure lycanthropy;
END
                     )->implies($Adj::edible);

$foxglove = Item->new('name' => 'stalk',
                      'plural' => 'stalks',
                      'identity' => 'stalk of foxglove',
                      'pluralid' => 'stalks of foxglove',
                      'appearance' => 'stalk',
                      'color' => 'green',
                      'weight' => 1,
                      'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,1), $Adj::foxglove, $Adj::crushing), ],
                      'on_consume' => <<'END',
                         my ($self, $consumer) = @_;
                         # $Talent::foxglove_poison->clone->poison($consumer);
                         # cure lycanthropy;
END
                     )->implies($Adj::edible);

# monkshood

$tangerine = Item->new('name' => 'tangerine',
                       'identity' => 'ripe tangerine',
                       'appearance' => 'fruit',
                       'color' => 'yellow',
                       'weight' => 1,
                       'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2,-1), $Adj::plant, $Adj::crushing), ],
                      )->implies($Adj::edible);

$exploding_tangerine = Item->new('name' => 'tangerine',
                       'identity' => 'exploding tangerine',
                       'appearance' => 'fruit',
                       'color' => 'yellow',
                       'weight' => 1,
                       'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2,-1), $Adj::plant, $Adj::crushing), ],
                       'projectile_attacks' => [ Attack->weapon(-1, Dice->new(2,4,1), $Adj::plant, $Adj::explosion), ],
                       'on_consume' => <<'END',
                         my ($self, $consumer) = @_;
                          $consumer->hurt(Attack->weapon(+3, Dice->new(2,4,1), $Adj::plant, $Adj::explosion), $self, 'head');
                          $consumer->seen($self, "<self> nearly got <his> head blown off by <other>!");
END
)->implies($Adj::curse)->implies($Adj::edible);

$berry    = Item->new('name' => 'berry',
                      'plural' => 'berries',
                      'identity' => 'ripe berry',
                      'pluralid' => 'ripe berries',
                      'appearance' => 'fruit',
                      'color' => 'red',
                      'weight' => 1,
                      'food' => 1,
                      'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2,-1), $Adj::plant, $Adj::crushing), ],
                     )->implies($Adj::edible);

$healing_berry = Item->new('name' => 'berry',
                      'plural' => 'berries',
                      'identity' => 'healing berry',
                      'pluralid' => 'healing berries',
                      'appearance' => 'fruit',
                      'color' => 'red',
                      'weight' => 1,
                      'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2,-1), $Adj::magic, $Adj::plant, $Adj::crushing), ],
                      'on_consume' => <<'END',
                         my ($self, $consumer) = @_;
                         $consumer->adjust('constitution',+1,$self);
                         $consumer->seen($consumer, "<self> feels healthier.");
END
                      )->implies($Adj::edible)->implies($Adj::magic);

$spirit_berry = Item->new('name' => 'berry',
                      'plural' => 'berries',
                      'identity' => 'spirit berry',
                      'pluralid' => 'spirit berries',
                      'appearance' => 'fruit',
                      'color' => 'red',
                      'weight' => 1,
                      'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2,-1), $Adj::magic, $Adj::plant, $Adj::crushing), ],
                      'on_consume' => <<'END',
                         my ($self, $consumer) = @_;
                         $consumer->adjust('spirit',+1,$self);
                         $consumer->seen($consumer, "<self> feels spiritually refreshed.");
END
                      )->implies($Adj::edible)->implies($Adj::magic);

$clump_of_grass = Item->new('name' => 'clump of grass',
                       'plural' => 'clumps of grass',
                       'identity' => 'mundane grass',
                       'pluralid' => 'clumps of mundane grass',
                       'appearance' => 'grass',
                       'color' => 'lime',
                       'weight' => 1,
                       'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2,-1), $Adj::plant, $Adj::crushing), ],
                      )->implies($Adj::edible);

$jumpgrass = Item->new('name' => 'clump of grass',
                       'plural' => 'clumps of grass',
                       'identity' => 'jumpgrass',
                       'pluralid' => 'clumps of jumpgrass',
                       'appearance' => 'grass',
                       'color' => 'lime',
                       'weight' => 1,
                       'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2,-1), $Adj::plant, $Adj::crushing), ],
                       )->implies($Adj::edible);

$calook_root = Item->new('name' => 'root',
                         'identity' => 'calook root',
                         'appearance' => 'root',
                         'color' => 'red',
                         'weight' => 4,
                         'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,1), $Adj::plant, $Adj::crushing), ],
                        )->implies($Adj::edible);

$mandrake_root = Item->new('name' => 'root',
                         'identity' => 'mandrake root',
                         'appearance' => 'root',
                         'color' => 'magenta',
                         'weight' => 5,
                         'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,1), $Adj::plant, $Adj::crushing), ],
                        )->implies($Adj::edible);

$golden_honeycomb = Item->new('name' => 'honeycomb',
                         'identity' => 'golden honeycomb',
                         'appearance' => 'honeycomb',
                         'color' => 'red',
                         'weight' => 4,
                         'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,1), $Adj::wax, $Adj::crushing), ],
                        )->implies($Adj::edible);

$royal_jelly = Item->new('name' => 'jelly',
                         'identity' => 'royal jelly',
                         'appearance' => 'jelly',
                         'color' => 'magenta',
                         'weight' => 4,
                         'melee_attacks' => [ Attack->weapon(-2, Dice->new(1,1,-2), $Adj::jelly, $Adj::crushing), ],
                        )->implies($Adj::edible);

### BEVERAGES

sub new_flask
{
  my $contents = shift;
  my $oc = shift;
  my $self   = Item->new('name' => 'flask',
                         'identity' => "flask of $contents",
                         'appearance' => 'bottle',
                         'color' => 'blue',
                         'weight' => 3,
                         'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,1), $Adj::glass, $Adj::crushing), ],
                         'on_consume' => $oc,
                        )->implies($Adj::liquid);
  return $self;
}

sub new_jug
{
  my $contents = shift;
  my $oc = shift;
  my $self   = Item->new('name' => 'jug',
                         'identity' => 'jug of $contents',
                         'appearance' => 'bottle',
                         'color' => 'brown',
                         'weight' => 7,
                         'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2), $Adj::clay, $Adj::crushing), ],
                         'on_consume' => $oc,
                        )->implies($Adj::liquid);
  return $self;
}

$flask_of_brandy = new_flask('brandy', '');
$jug_of_cider    = new_jug('cider', '');

1;
