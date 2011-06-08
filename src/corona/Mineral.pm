package Item;

## STONES

$stone = Item->new('name' => 'stone',
                   'identity' => 'mundane stone',
                   'appearance' => 'tiny',
                   'color' => 'grey',
                   'weight' => 2,
                   'melee_attacks' => [ Attack->weapon(0, Dice->new(1,1), $Adj::stone, $Adj::crushing), ],
                   'projectile_attacks' => [ Attack->weapon(0, Dice->new(1,2), $Adj::stone, $Adj::crushing), ],
                  )->implies($Adj::round);

$rock = Item->new('name' => 'rock',
                   'identity' => 'mundane rock',
                   'appearance' => 'rock',
                   'color' => 'grey',
                   'weight' => 10,
                   'melee_attacks' => [ Attack->weapon(0, Dice->new(1,3), $Adj::stone, $Adj::crushing), ],
                  )->implies($Adj::round);

$boulder = Item->new('name' => 'boulder',
                   'identity' => 'mundane boulder',
                   'appearance' => 'boulder',
                   'color' => 'grey',
                   'weight' => 1000,
                   'melee_attacks' => [ Attack->weapon(0, Dice->new(1,8,+2), $Adj::stone, $Adj::crushing), ],
                   'projectile_attacks' => [ Attack->weapon(+1, Dice->new(2,6), $Adj::stone, $Adj::crushing), ],
                  )->implies($Adj::round);

$menhir = Item->new('name' => 'boulder',
                   'identity' => 'menhir',
                   'appearance' => 'boulder',
                   'color' => 'white',
                   'weight' => 1000,
                   'melee_attacks' => [ Attack->weapon(+1, Dice->new(1,10,+2), $Adj::stone, $Adj::crushing), ],
                   'projectile_attacks' => [ Attack->weapon(+2, Dice->new(2,8,+2), $Adj::stone, $Adj::crushing, $Adj::magic), ],
                  )->implies($Adj::round);

## ASH

$volcanic_ash = Item->new('name' => 'ash',
                   'identity' => 'volcanic ash',
                   'appearance' => 'ash',
                   'color' => 'grey',
                   'weight' => 1,
                   'melee_attacks' => [ Attack->weapon(0, Dice->new(1,10,-9), $Adj::ash, $Adj::crushing), ],
                   'projectile_attacks' => [ Attack->weapon(0, Dice->new(1,1,-1), $Adj::ash, $Adj::crushing), ],
                  );

$brimstone = Item->new('name' => 'crystal',
                   'identity' => 'brimstone',
                   'appearance' => 'crystal',
                   'color' => 'yellow',
                   'weight' => 1,
                   'melee_attacks' => [ Attack->weapon(0, Dice->new(1,1), $Adj::brimstone, $Adj::crushing), ],
                   'projectile_attacks' => [ Attack->weapon(0, Dice->new(1,1), $Adj::brimstone, $Adj::crushing), ],
                  );

$salt  = Item->new('name' => 'crystal',
                   'identity' => 'salt',
                   'appearance' => 'crystal',
                   'color' => 'white',
                   'weight' => 1,
                   'melee_attacks' => [ Attack->weapon(0, Dice->new(1,1), $Adj::salt, $Adj::crushing), ],
                   'projectile_attacks' => [ Attack->weapon(0, Dice->new(1,1), $Adj::salt, $Adj::crushing), ],
                  );

# dust constructor: copper dust, gold dust etc.

1;
