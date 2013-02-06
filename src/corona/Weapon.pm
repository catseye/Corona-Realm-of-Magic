# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see file LICENSE for more info.

package Item;

### ITEMS FOR BODY WEAPONS

$web    = Item->new('name' => 'web',
                    'identity' => 'spiderweb',
                    'appearance' => 'web',
                    'color' => 'grey',
                    'weight' => 2,
                    'melee_attacks' => [ Attack->weapon(0, Dice->new(1,3,-2), $Adj::crushing), ],
                   );

### WEAPONS

$hammer = Item->new('name' => 'hammer',
                    'identity' => 'hammer',
                    'appearance' => 'stick',
                    'color' => 'blue',
                    'weight' => 15,
                    'melee_attacks' => [ Attack->weapon(0, Dice->new(1,5,+1), $Adj::crushing), ],
                   )->implies($Adj::hammer);

$hand_axe    = Item->new('name' => 'axe',
                         'identity' => 'hand axe',
                         'appearance' => 'stick',
                         'color' => 'grey',
                         'weight' => 9,
                         'melee_attacks' => [ Attack->weapon(0, Dice->new(2,3,-1), $Adj::cutting), ],
                         'projectile_attacks' => [ Attack->weapon(-1, Dice->new(1,5), $Adj::cutting), ],
                        )->implies($Adj::axe);

$knife = Item->new('name' => 'knife',
                   'identity' => 'knife',
                   'appearance' => 'sword',
                   'color' => 'sky',
                   'weight' => 3,
                   'melee_attacks' => [ Attack->weapon(0, Dice->new(1,3), $Adj::piercing), ],
                  )->implies($Adj::knife);

$dagger = Item->new('name' => 'dagger',
                    'identity' => 'dagger',
                    'appearance' => 'sword',
                    'color' => 'sky',
                    'weight' => 5,
                    'melee_attacks' => [ Attack->weapon(0, Dice->new(1,4), $Adj::piercing), ],
                   )->implies($Adj::knife);

$short_sword = Item->new('name' => 'short sword',
                         'identity' => 'short sword',
                         'appearance' => 'sword',
                         'color' => 'sky',
                         'weight' => 7,
                         'melee_attacks' => [ Attack->weapon(0, Dice->new(1,5), $Adj::cutting), ],
                         'projectile_attacks' => [ Attack->weapon(-1, Dice->new(1,5,-2), $Adj::cutting), ],
                        )->implies($Adj::sword);

$cutlass       = Item->new('name' => 'cutlass',
                           'identity' => 'mundane cutlass',
                           'appearance' => 'sword',
                           'color' => 'sky',
                           'weight' => 6,
                           'melee_attacks' => [ Attack->weapon(0, Dice->new(1,6), $Adj::cutting), ],
                           'projectile_attacks' => [ Attack->weapon(-1, Dice->new(1,5,-1), $Adj::cutting), ],
                           )->implies($Adj::sword);

$katana = Item->new('name' => 'katana',
                           'identity' => 'mundane katana',
                           'appearance' => 'sword',
                           'color' => 'sky',
                           'weight' => 6,
                           'melee_attacks' => [ Attack->weapon(0, Dice->new(1,7), $Adj::cutting), ],
                           'projectile_attacks' => [ Attack->weapon(-1, Dice->new(1,3), $Adj::cutting), ],
                           )->implies($Adj::sword);

$longsword = Item->new('name' => 'longsword',
                           'identity' => 'mundane longsword',
                           'appearance' => 'sword',
                           'color' => 'sky',
                           'weight' => 11,
                           'melee_attacks' => [ Attack->weapon(0, Dice->new(1,8), $Adj::cutting), ],
                           'projectile_attacks' => [ Attack->weapon(-2, Dice->new(1,8,-2), $Adj::cutting), ],
                           )->implies($Adj::sword);

$broadsword = Item->new('name' => 'broadsword',
                        'identity' => 'mundane broadsword',
                        'appearance' => 'sword',
                        'color' => 'sky',
                        'weight' => 12,
                        'melee_attacks' => [ Attack->weapon(0, Dice->new(2,4), $Adj::cutting), ],
                        'projectile_attacks' => [ Attack->weapon(-2, Dice->new(1,8,-1), $Adj::cutting), ],
                       )->implies($Adj::sword);

$great_sword = Item->new('name' => 'great sword',
                        'identity' => 'mundane great sword',
                        'appearance' => 'sword',
                        'color' => 'sky',
                        'weight' => 18,
                        'worn_on' => { 'lhand' => { 'rhand' => 0, 'lhand' => 0 },
                                       'rhand' => { 'rhand' => 0, 'lhand' => 0 } },
                        'melee_attacks' => [ Attack->weapon(-2, Dice->new(3,3), $Adj::cutting), ],
                        'projectile_attacks' => [ Attack->weapon(-3, Dice->new(1,8), $Adj::cutting), ],
                       )->implies($Adj::two_handed)->implies($Adj::sword);

$quarterstaff =    Item->new('name' => 'quarterstaff',
                           'plural' => 'quarterstaves',
                           'pluralid' => 'mundane quarterstaves',
                           'identity' => 'mundane quarterstaff',
                           'appearance' => 'stick',
                           'color' => 'brown',
                           'weight' => 9,
                           'worn_on' => { 'lhand' => { 'rhand' => 0, 'lhand' => 0 },
                                          'rhand' => { 'rhand' => 0, 'lhand' => 0 } },
                           'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2), $Adj::crushing),
                                                Attack->weapon(-1, Dice->new(1,2), $Adj::crushing), ],
                           'projectile_attacks' => [ Attack->weapon(0, Dice->new(1,4,-1), $Adj::crushing), ],
                          );

$club       =    Item->new('name' => 'club',
                           'identity' => 'mundane club',
                           'appearance' => 'stick',
                           'color' => 'brown',
                           'weight' => 11,
                           'melee_attacks' => [ Attack->weapon(0, Dice->new(1,4,+1), $Adj::crushing), ],
                           'projectile_attacks' => [ Attack->weapon(0, Dice->new(1,2,+1), $Adj::crushing), ],
                          )->implies($Adj::club);

$mace =          Item->new('name' => 'mace',
                           'identity' => 'mundane mace',
                           'appearance' => 'mace',
                           'color' => 'brown',
                           'weight' => 18,
                           'melee_attacks' => [ Attack->weapon(0, Dice->new(2,3), $Adj::crushing), ],
                           'projectile_attacks' => [ Attack->weapon(-2, Dice->new(1,6,-1), $Adj::crushing), ],
                          )->implies($Adj::hammer);

$flail =         Item->new('name' => 'flail',
                           'identity' => 'mundane flail',
                           'appearance' => 'mace',
                           'color' => 'grey',
                           'weight' => 20,
                           'melee_attacks' => [ Attack->weapon(+1, Dice->new(3,2,-1), $Adj::crushing), ],
                           'projectile_attacks' => [ Attack->weapon(-2, Dice->new(2,3,-2), $Adj::crushing), ],
                          )->implies($Adj::flail);

### MISSILE WEAPONS

$arrow =         Item->new('name' => 'arrow',
                           'identity' => 'mundane arrow',
                           'appearance' => 'arrow',
                           'color' => 'brown',
                           'weight' => 3,
                           'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,3,-2), $Adj::piercing), ],
                           'projectile_attacks' => [ Attack->weapon(0, Dice->new(1,1), $Adj::piercing), ],  # NB: this is when thrown by hand!  See bows for scale.
                          )->implies($Adj::arrow);

$short_bow =     Item->new('name' => 'bow',
                           'identity' => 'mundane short bow',
                           'appearance' => 'bow',
                           'color' => 'brown',
                           'weight' => 7,
                           'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,1), $Adj::crushing), ],
                           'missiles' => $Adj::arrow,
                           'missile_damage_scale' => 4,
                           'missile_range_scale' => 3,
                          )->implies($Adj::bow);

$long_bow =      Item->new('name' => 'bow',
                           'identity' => 'mundane long bow',
                           'appearance' => 'bow',
                           'color' => 'brown',
                           'weight' => 15,
                           'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,1), $Adj::crushing), ],
                           'missiles' => $Adj::arrow,
                           'missile_damage_scale' => 4,
                           'missile_range_scale' => 6,
                          )->implies($Adj::bow);

$bolt =          Item->new('name' => 'bolt',
                           'identity' => 'mundane bolt',
                           'appearance' => 'arrow',
                           'color' => 'grey',
                           'weight' => 2,
                           'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,1), $Adj::piercing), ],
                           'projectile_attacks' => [ Attack->weapon(0, Dice->new(1,1), $Adj::piercing), ], # NB: this is when thrown by hand!  See X-bows for scale.
                          )->implies($Adj::bolt);

$crossbow =      Item->new('name' => 'crossbow',
                           'identity' => 'mundane crossbow',
                           'appearance' => 'crossbow',
                           'color' => 'brown',
                           'weight' => 9,
                           'worn_on' => { 'lhand' => { 'rhand' => 0, 'lhand' => 0 },
                                          'rhand' => { 'rhand' => 0, 'lhand' => 0 } },
                           'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2), $Adj::crushing), ],
                           'missiles' => $Adj::bolt,
                           'missile_damage_scale' => 6,
                           'missile_range_scale' => 4,  # should be absolute, not scale
                          )->implies($Adj::crossbow);

# lasso: rope w/dexterity/paralyzation

# bolas

# boomerang

# yo-yo


1;
