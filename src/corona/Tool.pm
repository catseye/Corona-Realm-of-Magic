package Item;

### COINAGE

$coin  = Item->new('name' => 'coin',
                   'identity' => 'coin',
                   'appearance' => 'coin',
                   'weight' => 1,
                   'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,1), $Adj::crushing), ],
                  );

### TOOLS

$torch = Item->new('name' => 'torch',
                   'plural' => 'torches',
                   'identity' => 'mundane torch',
                   'pluralid' => 'mundane torches',
                   'appearance' => 'stick',
                   'color' => 'brown',
                   'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,1), $Adj::wood, $Adj::crushing),
                                        $Attack::flame, ],
                   'weight' => 4,
                   'lightsource' => 1,
                  );

$flute = Item->new('name' => 'flute',
                   'identity' => 'flute',
                   'appearance' => 'instrument',
                   'color' => 'grey',
                   'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2), $Adj::crushing), ],
                   'weight' => 3,
                  )->implies($Adj::flute);

$rope  = Item->new('name' => 'rope',
                   'identity' => 'rope',
                   'appearance' => 'stick',  # rope, actually
                   'color' => 'brown',
                   'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,1,-1), $Adj::plant, $Adj::crushing), ],
                   'weight' => 9,
                  );

$holy_water = Item->new('name' => 'water',
                        'identity' => 'holy water',
                        'appearance' => 'flask',
                        'color' => 'grey',
                        'melee_attacks' => [ Attack->weapon(0, Dice->new(1,4), $Adj::blessing, $Adj::water), ],
                        'weight' => 3,
                  )->implies($Adj::blessing);

$holy_symbol = Item->new('name' => 'symbol',
                        'identity' => 'holy symbol',
                        'appearance' => 'stick',
                        'color' => 'white',
                        'melee_attacks' => [ Attack->weapon(0, Dice->new(1,2), $Adj::blessing), ],
                        'weight' => 5,
                  )->implies($Adj::blessing);

### IMPLEMENTS

$scythe =        Item->new('name' => 'scythe',
                           'identity' => 'mundane scythe',
                           'appearance' => 'sword',
                           'color' => 'sky',
                           'weight' => 15,
                           'melee_attacks' => [ Attack->weapon(-2, Dice->new(1,11,-2), $Adj::cutting), ],
                           'projectile_attacks' => [ Attack->weapon(-4, Dice->new(1,5), $Adj::cutting), ],
                          );

$hoe =           Item->new('name' => 'hoe',
                           'identity' => 'mundane hoe',
                           'appearance' => 'stick',
                           'color' => 'brown',
                           'weight' => 7,
                           'melee_attacks' => [ Attack->weapon(0, Dice->new(1,4), $Adj::crushing), ],
                           'projectile_attacks' => [ Attack->weapon(-1, Dice->new(1,4,-1), $Adj::crushing), ],
                          );

$shovel =           Item->new('name' => 'shovel',
                           'identity' => 'mundane shovel',
                           'appearance' => 'stick',
                           'color' => 'brown',
                           'weight' => 7,
                           'melee_attacks' => [ Attack->weapon(-1, Dice->new(2,2), $Adj::crushing), ],  # digging?
                           'projectile_attacks' => [ Attack->weapon(-2, Dice->new(1,4,-1), $Adj::crushing), ],
                          );

# wood axe?

$pick_axe =           Item->new('name' => 'axe',
                           'identity' => 'pick-axe',
                           'appearance' => 'stick',
                           'color' => 'brown',
                           'weight' => 8,
                           'melee_attacks' => [ Attack->weapon(-1, Dice->new(2,2), $Adj::piercing), ],  # digging?
                           'projectile_attacks' => [ Attack->weapon(-2, Dice->new(1,7,-3), $Adj::piercing), ],
                          );

1;
