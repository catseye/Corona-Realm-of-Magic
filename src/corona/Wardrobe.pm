# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see file LICENSE for more info.

package Item;

require "$::universe/BodyArmour.pm";

### WARDROBE

### NECK

$amulet   = Item->new('name' => 'amulet',
                      'identity' => 'amulet',
                      'appearance' => 'necklace',
                      'color' => 'blue',
                      'weight' => 4,
                      'worn_on' => { 'neck' => { 'neck' => 0 },
                                     'rhand' => { 'rhand' => 0 },
                                     'lhand' => { 'lhand' => 0 } },
                     );

$necklace = Item->new('name' => 'necklace',
                      'identity' => 'necklace',
                      'appearance' => 'necklace',
                      'color' => 'grey',
                      'weight' => 2,
                      'worn_on' => { 'neck' => { 'neck' => 0 },
                                     'rhand' => { 'rhand' => 0 },
                                     'lhand' => { 'lhand' => 0 } },
                     );

$kerchief =    Item->new('name' => 'kerchief',
                         'identity' => 'kerchief',
                         'appearance' => 'cloak',
                         'color' => 'white',
                         'weight' => 3,
                         'worn_on' => { 'neck' => { 'neck' => 0 },
                                        'rhand' => { 'rhand' => 0 },
                                        'lhand' => { 'lhand' => 0 } },
                        );

$wreath   = Item->new('name' => 'wreath',
                      'identity' => 'wreath',
                      'appearance' => 'necklace',
                      'color' => 'green',
                      'weight' => 2,
                      'worn_on' => { 'neck' => { 'neck' => 0 },
                                     'head' => { 'head' => 0 },
                                     'rwrist' => { 'rwrist' => 0 },
                                     'lwrist' => { 'lwrist' => 0 },
                                     'rankle' => { 'rankle' => 0 },
                                     'lankle' => { 'lankle' => 0 },
                                     'rhand' => { 'rhand' => 0 },
                                     'lhand' => { 'lhand' => 0 } },
                     );

$torque   = Item->new('name' => 'torque',
                      'identity' => 'torque',
                      'appearance' => 'helm',
                      'color' => 'yellow',
                      'weight' => 5,
                      'worn_on' => { 'neck' => { 'neck' => 0 },
                                     'head' => { 'head' => 0 },
                                     'rhand' => { 'rhand' => 0 },
                                     'lhand' => { 'lhand' => 0 } },
                     );

### SHOULDERS

$cloak = Item->new('name' => 'cloak',
                   'identity' => 'cloak',
                   'appearance' => 'cloak',
                   'color' => 'grey',
                   'weight' => 5,
                   'worn_on' => { 'shoulders' => { 'shoulders' => 66 },
                                  'rhand' => { 'rhand' => 0 },
                                  'lhand' => { 'lhand' => 0 } },
);

# make should scale these depnding on what they're made of

$cape = Item->new('name' => 'cape',
                  'identity' => 'cape',
                  'appearance' => 'cloak',
                  'color' => 'black',
                  'weight' => 4,
                           'worn_on' => { 'shoulders' => { 'shoulders' => 50 },
                                          'rhand' => { 'rhand' => 0 },
                                          'lhand' => { 'lhand' => 0 } }
);

### LEGS

$leggings = Item->new('name' => 'pair of leggings',
                      'plural' => 'pairs of leggings',
                      'identity' => 'leggings',
                      'pluralid' => 'pairs of leggings',
                      'appearance' => 'leggings',
                      'color' => 'brown',
                      'weight' => 4,
                      'worn_on' => { 'legs' => { 'legs' => 50 },
                                     'rhand' => { 'rhand' => 0 },
                                     'lhand' => { 'lhand' => 0 } }
);

$greaves = Item->new('name' => 'pair of greaves',
                      'plural' => 'pairs of greaves',
                      'identity' => 'leggings',
                      'pluralid' => 'pairs of greaves',
                      'appearance' => 'leggings',
                      'color' => 'brown',
                      'weight' => 6,
                      'worn_on' => { 'legs' => { 'legs' => 66 },
                                     'rhand' => { 'rhand' => 0 },
                                     'lhand' => { 'lhand' => 0 } }
);

### TORSO

$halter = Item->new('name' => 'halter',
                    'identity' => 'halter',
                    'appearance' => 'halter',
                    'color' => 'brown',
                    'weight' => 3,
                        'worn_on' => { 'torso' => { 'torso' => 33 },
                                        'head' => { 'head'  => 10 },
                                       'lhand' => { 'lhand' => 0 },
                                       'rhand' => { 'rhand' => 0 } },
                       );

$sleeved_shirt = Item->new('name' => 'shirt',
                        'identity' => 'sleeved shirt',
                        'appearance' => 'jacket',
                        'color' => 'white',
                        'weight' => 8,
                        'worn_on' => { 'torso' => { 'torso' => 75, 'arms' => 50 },
                                       'lhand' => { 'lhand' => 0 },
                                       'rhand' => { 'rhand' => 0 } },
                       );

$blouse     = Item->new('name' => 'blouse',
                        'identity' => 'blouse',
                        'appearance' => 'jacket',
                        'color' => 'white',
                        'weight' => 5,
                        'worn_on' => { 'torso' => { 'torso' => 66, 'arms' => 33 },
                                       'lhand' => { 'lhand' => 0 },
                                       'rhand' => { 'rhand' => 0 } },
                       );

$jerkin     = Item->new('name' => 'jerkin',
                        'identity' => 'jerkin',
                        'appearance' => 'jacket',
                        'color' => 'brown',
                        'weight' => 10,
                        'worn_on' => { 'torso' => { 'torso' => 50 },
                                       'lhand' => { 'lhand' => 0 },
                                       'rhand' => { 'rhand' => 0 } },
                       );

$jacket     = Item->new('name' => 'jacket',
                        'identity' => 'jacket',
                        'appearance' => 'jacket',
                        'color' => 'brown',
                        'weight' => 15,
                        'worn_on' => { 'torso' => { 'torso' => 75 },
                                       'lhand' => { 'lhand' => 0 },
                                       'rhand' => { 'rhand' => 0 } },
                       );

$rags       = Item->new('name' => 'rags',
                        'identity' => 'rags',
                        'appearance' => 'clothing',
                        'color' => 'brown',
                        'weight' => 75,
                        'worn_on' => { 'torso' => { 'torso' => 50 },
                                       'waist' => { 'waist' => 50 },
                                       'arms'  => { 'arms'  => 50 },
                                       'legs'  => { 'legs'  => 50 },
                                       'lhand' => { 'lhand' => 0 },
                                       'rhand' => { 'rhand' => 0 } },
                       );

### ARNS

$sleeves    = Item->new('name' => 'pair of sleeves',
                        'plural' => 'pairs of sleeves',
                        'identity' => 'pair of sleeves',
                        'pluralid' => 'pairs of sleeves',
                        'appearance' => 'sleeves',
                        'color' => 'brown',
                        'weight' => 4,
                        'worn_on' => { 'arms' => { 'arms' => 50 },
                                       'lhand' => { 'lhand' => 0 },
                                       'rhand' => { 'rhand' => 0 } },
                       );

$bracers    = Item->new('name' => 'pair of bracers',
                        'plural' => 'pairs of bracers',
                        'identity' => 'pair of bracers',
                        'pluralid' => 'pairs of bracers',
                        'appearance' => 'sleeves',
                        'color' => 'grey',
                        'weight' => 8,
                        'worn_on' => { 'arms' => { 'arms' => 66 },
                                       'lhand' => { 'lhand' => 0 },
                                       'rhand' => { 'rhand' => 0 } },
 );

### HANDS

$gloves     = Item->new('name' => 'pair of gloves',
                        'plural' => 'pairs of gloves',
                        'identity' => 'pair of gloves',
                        'pluralid' => 'pairs of gloves',
                        'appearance' => 'gloves',
                        'color' => 'brown',
                        'weight' => 4,
                        'worn_on' => { 'hands' => { 'hands' => 33 },
                                       'lhand' => { 'lhand' => 0 },
                                       'rhand' => { 'rhand' => 0 } },
 );

$gauntlets  = Item->new('name' => 'pair of gauntlets',
                        'plural' => 'pairs of gauntlets',
                        'identity' => 'pair of gauntlets',
                        'pluralid' => 'pairs of gauntlets',
                        'appearance' => 'gloves',
                        'color' => 'brown',
                        'weight' => 6,
                        'worn_on' => { 'hands' => { 'hands' => 66 },
                                       'lhand' => { 'lhand' => 0 },
                                       'rhand' => { 'rhand' => 0 } },
 );


### HEAD

$hat        = Item->new('name' => 'hat',
                        'identity' => 'hat',
                        'appearance' => 'helm',
                        'color' => 'brown',
                        'weight' => 3,
                        'worn_on' => { 'head' => { 'head' => 25 },
                                       'lhand' => { 'lhand' => 0 },
                                       'rhand' => { 'rhand' => 0 } },
 );

$helmet     = Item->new('name' => 'helmet',
                        'identity' => 'helmet',
                        'appearance' => 'helm',
                        'color' => 'sky',
                        'weight' => 15,
                        'worn_on' => { 'head' => { 'head' => 66 },
                                       'lhand' => { 'lhand' => 0 },
                                       'rhand' => { 'rhand' => 0 } },
 );

$helm       = Item->new('name' => 'helm',
                        'identity' => 'helm',
                        'appearance' => 'helm',
                        'color' => 'sky',
                        'weight' => 20,
                        'worn_on' => { 'head' => { 'head' => 85 },
                                       'lhand' => { 'lhand' => 0 },
                                       'rhand' => { 'rhand' => 0 } },
 );

### FEET

$shoes      = Item->new('name' => 'pair of shoes',
                        'pluralid' => 'pairs of shoes',
                        'identity' => 'pair of shoes',
                        'pluralid' => 'pairs of shoes',
                        'appearance' => 'boots',
                        'color' => 'brown',
                        'weight' => 4,
                        'worn_on' => { 'feet' => { 'feet' => 33 },
                                     'rhand' => { 'rhand' => 0 },
                                     'lhand' => { 'lhand' => 0 } },
 );

$boots      = Item->new('name' => 'pair of boots',
                        'pluralid' => 'pairs of boots',
                        'identity' => 'pair of boots',
                        'pluralid' => 'pairs of boots',
                        'appearance' => 'boots',
                        'color' => 'brown',
                        'weight' => 6,
                        'worn_on' => { 'feet' => { 'feet' => 66 },
                                     'rhand' => { 'rhand' => 0 },
                                     'lhand' => { 'lhand' => 0 } },
 );

### WAIST

$loincloth     = Item->new('name' => 'loincloth',
                           'identity' => 'loincloth',
                           'appearance' => 'clothing',
                           'color' => 'brown',
                           'weight' => 2,
                           'worn_on' => { 'waist' => { 'waist' => 25 },
                                          'head' => { 'head'  => 10 },
                                          'lhand' => { 'lhand' => 0 },
                                          'rhand' => { 'rhand' => 0 } },
                          );

$sash          = Item->new('name' => 'sash',
                           'identity' => 'sash',
                           'appearance' => 'belt',
                           'color' => 'red',
                           'weight' => 8,
                           'worn_on' => { 'neck' => { 'neck' => 0 },
                                     'waist' => { 'waist' => 33 },
                                     'rhand' => { 'rhand' => 0 },
                                     'lhand' => { 'lhand' => 0 } },
 );

$belt          = Item->new('name' => 'belt',
                           'identity' => 'belt',
                           'appearance' => 'belt',
                           'color' => 'brown',
                           'weight' => 7,
                           'worn_on' => { 'neck' => { 'neck' => 0 },
                                     'waist' => { 'waist' => 40 },
                                     'rhand' => { 'rhand' => 0 },
                                     'lhand' => { 'lhand' => 0 } },
 );

$girdle        = Item->new('name' => 'girdle',
                           'identity' => 'girdle',
                           'appearance' => 'belt',
                           'color' => 'brown',
                           'weight' => 12,
                           'worn_on' => { 'waist' => { 'waist' => 66 },
                                     'rhand' => { 'rhand' => 0 },
                                     'lhand' => { 'lhand' => 0 } },
 );

$skirt         = Item->new('name' => 'skirt',
                           'identity' => 'skirt',
                           'appearance' => 'belt',
                           'color' => 'brown',
                           'weight' => 6,
                           'worn_on' => { 'waist' => { 'waist' => 50 },
                                     'rhand' => { 'rhand' => 0 },
                                     'lhand' => { 'lhand' => 0 } },
 );

$pantalons  = Item->new('name' => 'pair of pantalons',
                        'pluralid' => 'pairs of pantalons',
                        'identity' => 'pair of pantalons',
                        'pluralid' => 'pairs of pantalons',
                        'appearance' => 'leggings',
                        'color' => 'brown',
                        'weight' => 10,
                        'worn_on' => { 'waist' => { 'waist' => 75, 'legs' => 50 },
                                       'lhand' => { 'lhand' => 0 },
                                       'rhand' => { 'rhand' => 0 } },
                       );

### WRISTS

$bracelet = Item->new('name' => 'bracelet',
                      'identity' => 'bracelet',
                      'appearance' => 'bracelet',
                      'color' => 'yellow',
                      'weight' => 2,
                      'worn_on' => { 'rwrist' => { 'rwrist' => 0 },
                                     'lwrist' => { 'lwrist' => 0 },
                                     'rhand' => { 'rhand' => 0 },
                                     'lhand' => { 'lhand' => 0 } },
                     );

# shield!

### ANKLES

$anklet   = Item->new('name' => 'anklet',
                      'identity' => 'anklet',
                      'appearance' => 'bracelet',
                      'color' => 'yellow',
                      'weight' => 2,
                      'worn_on' => { 'rankle' => { 'rankle' => 0 },
                                     'lankle' => { 'lankle' => 0 },
                                     'rhand' => { 'rhand' => 0 },
                                     'lhand' => { 'lhand' => 0 } },

                     );

$ball_and_chain = Item->new('name' => 'anklet',
                      'identity' => 'ball and chain',
                      'appearance' => 'bracelet',
                      'color' => 'yellow',
                      'curse' => 1,
                      'weight' => 600,
                      'worn_on' => { 'rankle' => { 'rankle' => 0 },
                                     'lankle' => { 'lankle' => 0 },
                                     'rhand' => { 'rhand' => 0 },
                                     'lhand' => { 'lhand' => 0 } },
                     );

### FINGERS

$ring     = Item->new('name' => 'ring',
                      'identity' => 'ring',
                      'appearance' => 'ring',
                      'color' => 'white',
                      'weight' => 1,
                      'worn_on' => { 'rfinger' => { 'rfinger' => 0 },
                                     'lfinger' => { 'lfinger' => 0 },
                                     'rhand' => { 'rhand' => 0 },
                                     'lhand' => { 'lhand' => 0 } },
                     );

1;
