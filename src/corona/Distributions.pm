# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see file LICENSE for more info.

package Distribution;

### DISTRIBUTIONS ###

$even_sex   = Distribution->new(0.50 => 'Male', 0.50 => 'Female');
$hive_sex   = Distribution->new(0.25 => 'Male', 0.75 => 'Female');

$humanoid_hand_dominance = Distribution->new(0.60 => 'rhand',
                                        0.35 => 'lhand',
                                        0.05 => 'ambi');

$humanoid_hair_type = Distribution->new(
                                         0.10 => 'balding',
                                         0.10 => 'greasy',
                                         0.15 => 'frazzled',
                                         0.15 => 'curly',
                                         0.25 => 'wavy',
                                         0.25 => 'straight',
                                       );
$humanoid_hair_color  = Distribution->new(
                                           0.10 => 'blonde',
                                           0.15 => 'red',
                                           0.20 => 'auburn',
                                           0.25 => 'black',
                                           0.30 => 'brown',
                                         );

$humanoid_eye_type = Distribution->new(
                                        0.1 => 'piercing',
                                        0.1 => 'glassy',
                                        0.1 => 'squinting',
                                        0.1 => 'soft',
                                        0.1 => 'cold',
                                        0.1 => 'icy',
                                        0.1 => 'serious',
                                        0.1 => 'shifty',
                                        0.1 => 'laughing',
                                        0.1 => 'warm',
                                      );
$humanoid_eye_color  = Distribution->new(
                                          0.10 => 'grey',
                                          0.15 => 'blue',
                                          0.20 => 'almond',
                                          0.25 => 'green',
                                          0.30 => 'brown',
                                        );

$humanoid_skin_type = Distribution->new(
                                         0.05 => 'oily',
                                         0.10 => 'fine',
                                         0.15 => 'blotchy',
                                         0.20 => 'fair',
                                         0.25 => 'smooth',
                                         0.25 => 'rough',
                                       );
$humanoid_skin_color = Distribution->new(
                                          0.20 => 'brown',
                                          0.20 => 'grey',
                                          0.20 => 'pink',
                                          0.20 => 'yellow',
                                          0.20 => 'red',
                                        );


### BODY PART ATTACK DISTRIBUTIONS ###

%bp =
(
  'dumb_biped' => Distribution->new(0.35 => 'torso',
                                    0.15 => 'arms',
                                    0.10 => 'shoulders',
                                    0.10 => 'head',
                                    0.10 => 'legs',
                                    0.10 => 'hands',
                                    0.05 => 'waist',
                                    0.05 => 'feet'),

  'smart_biped' => Distribution->new(0.30 => 'head',
                                     0.15 => 'torso',
                                     0.10 => 'waist',
                                     0.10 => 'legs',
                                     0.10 => 'hands',
                                     0.10 => 'feet',
                                     0.07 => 'shoulders',
                                     0.08 => 'arms'),

  'random'      => Distribution->new(0.125 => 'torso',
                                     0.125 => 'legs',
                                     0.125 => 'shoulders',
                                     0.125 => 'arms',
                                     0.125 => 'waist',
                                     0.125 => 'hands',
                                     0.125 => 'head',
                                     0.125 => 'feet'),

  'pouncer'      => Distribution->new(0.25 => 'torso',
                                      0.20 => 'hands',
                                      0.15 => 'head',
                                      0.10 => 'shoulders',
                                      0.10 => 'waist',
                                      0.08 => 'arms',
                                      0.07 => 'legs',
                                      0.05 => 'feet'),

  'creepy_crawly' => Distribution->new(0.60 => 'feet',
                                       0.15 => 'legs',
                                       0.15 => 'hands',
                                       0.10 => 'arms'),

  'small_winged' => Distribution->new(0.35 => 'head',
                                      0.15 => 'shoulders',
                                      0.25 => 'arms',
                                      0.25 => 'hands'),
);

1;
