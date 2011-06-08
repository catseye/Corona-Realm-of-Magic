package Item;

### NATURAL ARMOR

$nonexistant_part = Item->new('name' => 'nonexistant body part',
                       'identity' => 'nonexistant body part',
                       '_defense' => 9999,
                       'body' => 1);

$thick_fur = Item->new('name' => 'fur',
                       'identity' => 'thick fur',
                       '_defense' => 1,
                       'worn_on' => { 'head'      => { 'head'      => 66 },
                                      'shoulders' => { 'shoulders' => 66 },
                                      'arms'      => { 'arms'      => 66 },
                                      'hands'     => { 'hands'     => 66 },
                                      'torso'     => { 'torso'     => 66 },
                                      'waist'     => { 'waist'     => 66 },
                                      'legs'      => { 'legs'      => 66 },
                                      'feet'      => { 'feet'      => 66 },
                                    },
                       'body' => 1)->implies($Adj::fur);

$reptilian_scales = Item->new('name' => 'scales',
                       'identity' => 'reptilian scales',
                       '_defense' => 2,
                       'worn_on' => { 'head'      => { 'head'      => 80 },
                                      'shoulders' => { 'shoulders' => 80 },
                                      'arms'      => { 'arms'      => 80 },
                                      'hands'     => { 'hands'     => 80 },
                                      'torso'     => { 'torso'     => 80 },
                                      'waist'     => { 'waist'     => 80 },
                                      'legs'      => { 'legs'      => 80 },
                                      'feet'      => { 'feet'      => 80 },
                                    },
                       'body' => 1)->implies($Adj::flesh);

$thick_bark = Item->new('name' => 'bark',
                       'identity' => 'thick bark',
                       '_defense' => 3,
                       'worn_on' => { 'head'      => { 'head'      => 85 },
                                      'shoulders' => { 'shoulders' => 85 },
                                      'arms'      => { 'arms'      => 85 },
                                      'hands'     => { 'hands'     => 85 },
                                      'torso'     => { 'torso'     => 85 },
                                      'waist'     => { 'waist'     => 85 },
                                      'legs'      => { 'legs'      => 85 },
                                      'feet'      => { 'feet'      => 85 },
                                    },
                       'body' => 1)->implies($Adj::wood);

$bony_exterior = Item->new('name' => 'bony exterior',
                       'identity' => 'bony exterior',
                       '_defense' => 3,
                       'worn_on' => { 'head'      => { 'head'      => 90 },
                                      'shoulders' => { 'shoulders' => 90 },
                                      'arms'      => { 'arms'      => 90 },
                                      'hands'     => { 'hands'     => 90 },
                                      'torso'     => { 'torso'     => 90 },
                                      'waist'     => { 'waist'     => 90 },
                                      'legs'      => { 'legs'      => 90 },
                                      'feet'      => { 'feet'      => 90 },
                                    },
                       'body' => 1)->implies($Adj::bone);

$chitonous_shell = Item->new('name' => 'hard shell',
                       'identity' => 'chitonous shell',
                       '_defense' => 4,
                       'worn_on' => { 'head'      => { 'head'      => 90 },
                                      'shoulders' => { 'shoulders' => 90 },
                                      'arms'      => { 'arms'      => 90 },
                                      'hands'     => { 'hands'     => 90 },
                                      'torso'     => { 'torso'     => 90 },
                                      'waist'     => { 'waist'     => 90 },
                                      'legs'      => { 'legs'      => 90 },
                                      'feet'      => { 'feet'      => 90 },
                                    },
                       'body' => 1)->implies($Adj::bone);

$skin = Item->new('name' => 'tough skin',
                  'identity' => 'skin',
                  'worn_on'      => { 'head'      => { 'head'      => 100 },
                                      'shoulders' => { 'shoulders' => 100 },
                                      'arms'      => { 'arms'      => 100 },
                                      'hands'     => { 'hands'     => 100 },
                                      'torso'     => { 'torso'     => 100 },
                                      'waist'     => { 'waist'     => 100 },
                                      'legs'      => { 'legs'      => 100 },
                                      'feet'      => { 'feet'      => 100 },
                                    },
                  'body' => 1);  # must 'make' this

1;
