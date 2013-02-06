# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see file LICENSE for more info.

### BUILT-IN REGIONS

$::wmap =
[
  ['Marshy Fields',  'Cynhyrdunum',      'Muddy Coast',    'Cod Waters',  'Deep Waters' ],
  ['Fetid Swamp',    'Dark Forest',      'Dry Badlands',   'Rocky Coast', 'Bakers Bay' ],
  ['Barren Expanse', 'Heatherwood',      'Vast Plains',    'Bakersport',  'Bakers Lookout'],
  ['Alkali Flats',   'Chapparal Fields', 'Wooded Steppes', 'Pfefferhorn', 'Rugged Edge'],
];

require "$::universe/Dungeons.pm";
require "$::universe/Cities.pm";

%::reg =
(
  %::dungeons,
  %::cities,
  'Dark Forest' => Region->new('name' => 'Dark Forest',
                    'sizex' => 60,
                    'sizey' => 60,
                    'supplement' => Supplement->new(
                                    'title' => 'Dark Forest',
                                    'media' => 'music/dark_forest',
                                    ),
                    'msg' => "Night falls as the sun sets, and it is now dark.",
                    'outside' => $::sc{dark},
                    # 'border' => $Terrain::dense_forest,
                    'ambient' => $Terrain::forest_floor,
                    'terraind' => Distribution->new(
                            0.002 => $Terrain::forest_floor->enc(
  Encounter->new('actors' => [ $Actor::grizzly_bear ],
                 'message' => 'You spot a grizzly bear!',
                 'bribeable' => {
                    'berry'         => 25,
                    'ripe berry'    => 15,
                    'spirit berry'  => 5,
                    'healing berry' => 2,
                 }),
),
                            0.003 => $Terrain::giant_beehive->to_new('Giant Beehive'),
                            0.006 => $Terrain::concealed_stash,
                            0.012 => $Terrain::freshwater_pool,
                            0.025 => $Terrain::ancient_ruins,
                            0.033 => $Terrain::grassy_flat,
                            0.050 => $Terrain::marsh,
                            0.010 => $Terrain::giant_bluewood,
                            0.020 => $Terrain::whipper_tree,
                            0.200 => $Terrain::clump_of_trees
                           ),
                    'itemd' => Distribution->new(
                            0.0001 => $Item::quarterstaff->make($Adj::wood)->cursed(1),
                            0.0001 => $Item::quarterstaff->make($Adj::wood)->crude,
                            0.0002 => $Item::cloak->make($Adj::fur),
                            0.0002 => $Item::shoes->make($Adj::fur),
                            0.0002 => $Item::gloves->make($Adj::fur),
                            0.0002 => $Item::hat->make($Adj::fur),
                            0.0005 => $Item::exploding_tangerine->bunch(2),
                            0.0005 => $Item::exploding_tangerine->bunch(3),
                            0.0005 => $Item::exploding_tangerine->bunch(4),
                            0.0010 => $Item::healing_berry->bunch(3),
                            0.0010 => $Item::healing_berry->bunch(4),
                            0.0010 => $Item::healing_berry->bunch(5),
                            0.0012 => $Item::spirit_berry->bunch(3),
                            0.0012 => $Item::spirit_berry->bunch(4),
                            0.0012 => $Item::spirit_berry->bunch(5),
                            0.0040 => $Item::tangerine->bunch(2),
                            0.0040 => $Item::tangerine->bunch(3),
                            0.0040 => $Item::tangerine->bunch(4),
                            0.0060 => $Item::berry->bunch(3),
                            0.0060 => $Item::berry->bunch(4),
                            0.0060 => $Item::berry->bunch(5)
                           ),
                    'monsterd' => Distribution->new(
                            0.0005 => $Actor::dryad,
                            0.0006 => $Actor::treant,
                            0.0007 => $Actor::wood_nymph,
                            0.0008 => $Actor::grizzly_bear,
                            0.0009 => $Actor::sylvan_snake,
                            0.0010 => $Actor::wood_sprite,
                            0.0020 => $Actor::blue_spider,
                            0.0025 => $Actor::juggler_snake,
                            0.0042 => $Actor::forest_cat,
                           ),
  ),
  'Heatherwood' => Region->new('name' => 'Heatherwood',
                    'sizex' => 60,
                    'sizey' => 60, 
                    'supplement' => Supplement->new(
                                    'title' => 'Heatherwood',
                                    'media' => 'music/heatherwood',
                                    ),
                    'outside' => $::sc{dark},
                    'ambient' => $Terrain::forest_floor,
                    'genpattern' => 'accretion',
                    'terraind' => Distribution->new(
                            0.050 => $Terrain::grassy_flat,
                            0.050 => $Terrain::marsh,
                            0.100 => $Terrain::gully,
                            0.250 => $Terrain::forest_floor,
                            0.250 => $Terrain::low_hillside,
                            0.250 => $Terrain::clump_of_trees
                           ),
                    'itemd' => Distribution->new(
                            0.0002 => $Item::cloak->make($Adj::fur),
                            0.0002 => $Item::boots->make($Adj::fur),
                            0.0002 => $Item::leggings->make($Adj::fur)->fine,
                            0.0002 => $Item::jacket->make($Adj::fur),
                            0.0002 => $Item::belt->make($Adj::fur),
                            0.0002 => $Item::bracers->make($Adj::fur),
                            0.0002 => $Item::gauntlets->make($Adj::fur),
                            0.0002 => $Item::helmet->make($Adj::wood),
                           ),
                    'monsterd' => Distribution->new(
                            0.0010 => $Actor::blue_spider,
                            0.0025 => $Actor::human->class('cleric',1),
                            0.0010 => $Actor::human->class('cleric',2),
                            0.0005 => $Actor::human->class('cleric',3),
                            0.0050 => $Actor::forest_cat,
                           ),
  ),
  'Vast Plains' => Region->new('name' => 'Vast Plains',
                    'sizex' => 60,
                    'sizey' => 60, 
                    'supplement' => Supplement->new(
                                    'title' => 'Vast Plains',
                                    'media' => 'music/vast_plains',
                                    ),
                    'outside' => $::sc{dark},
                    'ambient' => $Terrain::grassy_flat, # plains
                    'terraind' => Distribution->new(
                            0.002 => $Terrain::descending_staircase->to_new('Dwarkling Hideout'),
                            0.020 => $Terrain::dirt_road,
                            0.030 => $Terrain::gully,
                            0.030 => $Terrain::low_hillside,
                            0.040 => $Terrain::clump_of_trees,
                            0.040 => $Terrain::small_farmhouse,
                            0.090 => $Terrain::fallow_field,
                            0.160 => $Terrain::cultivated_field,
                            0.010 => $Terrain::low_hillside->enc(
  Encounter->new('actors' => [ $Actor::scutter_skunk,
                               $Actor::scutter_skunk,
                               $Actor::scutter_skunk,
                             ],
                 'message' => 'You spot a pack of scutter skunks!',
                )),
                           ),
                    'itemd' => Distribution->new(
                            # flowers, herbs
                            0.0001 => $Item::menhir->magicked(+1),
                            0.0002 => $Item::boulder->fine,
                            0.0012 => $Item::hot_pepper->bunch(2),
                            0.0025 => $Item::pepper->bunch(2),
                            0.0025 => $Item::cabbage,
                            0.0025 => $Item::calook_root,
                            0.0030 => $Item::menhir,
                            0.0035 => $Item::sprig_of_mint,
                            0.0040 => $Item::jumpgrass->bunch(2),
                            0.0040 => $Item::jumpgrass->bunch(3),
                            0.0040 => $Item::jumpgrass->bunch(4),
                            0.0007 => $Item::boulder,
                            0.0012 => $Item::rock,
                            0.0010 => $Item::rock->bunch(2),
                            0.0025 => $Item::stone->bunch(2),
                            0.0025 => $Item::stone->bunch(3),
                            0.0025 => $Item::stone->bunch(4),
                            0.0100 => $Item::clump_of_grass->bunch(2),
                            0.0100 => $Item::clump_of_grass->bunch(3),
                            0.0100 => $Item::clump_of_grass->bunch(4),
                           ),
                    'monsterd' => Distribution->new(
                            0.0006 => $Actor::human->class('farmer',12),
                            0.0007 => $Actor::plains_nymph,
                            0.0008 => $Actor::juggler_snake,
                            0.0009 => $Actor::elf->class('farmer',2),
                            0.0015 => $Actor::human->class('farmer',3),
                            0.0040 => $Actor::scutter_skunk,
                           ),
  ),
  'Fetid Swamp' => Region->new('name' => 'Fetid Swamp',
                    'sizex' => 60,
                    'sizey' => 60, 
                    'supplement' => Supplement->new(
                                    'title' => 'Fetid Swamp',
                                    'media' => 'music/fetid_swamp',
                                    ),
                    'outside' => $::sc{dark},
                    'ambient' => $Terrain::marsh,
                    'genpattern' => 'recursive',
                    'terraind' => Distribution->new(
                            # swampland
                            # quicksand
                            # wetland
                            # pond
                            # mudflat
                            # tall reeds
                            # tall grass
                            0.2 => $Terrain::gully,
                            0.1 => $Terrain::freshwater_pool,
                            0.05 => $Terrain::barren_expanse,
                            0.2 => $Terrain::clump_of_trees,
                           ),
                    'itemd' => Distribution->new(
                            # herbs, lilypads
                            0.0001 => $Item::anklet->make($Adj::garlic)->ofstat('constitution',+1),
                            0.0001 => $Item::bracelet->make($Adj::marble)->ofstat('dexterity',+1),
                            0.0010 => $Item::mushroom_of_swiftness,
                            0.0030 => $Item::rope->camoflaged($Actor::wetland_viper),
                            0.0080 => $Item::clove_of_garlic,
                            0.0150 => $Item::mundane_mushroom,
                            0.0500 => $Item::jumpgrass,
                           ),
                    'monsterd' => Distribution->new(
                            0.0005 => $Actor::demifaery->class('necromancer',21)->strategy('TalentFight'),
                            0.0010 => $Actor::dwarf->class('necromancer',5)->strategy('TalentFlee'),
                            0.0008 => $Actor::swamp_hag,
                            0.0016 => $Actor::wetland_viper,
#                            0.0002 => $Actor::dwarf->ghast,
#                            0.0002 => $Actor::ursati->ghoul,
#                            0.0003 => $Actor::human->zombie,
#                            0.0003 => $Actor::gnome->zombie,
#                            0.0003 => $Actor::elf->zombie,
# purple catfish
# brown eel
                            0.0018 => $Actor::green_alligator,
                            0.0022 => $Actor::pond_spider,
                            0.0028 => $Actor::shadow_owl,
                           ),
                    'unique' =>
                    [
                      $Terrain::descending_staircase->to_new('Grumchik Stronghold'),
                      $Terrain::descending_staircase->to_new('Grumchik Stronghold'),
                      $Terrain::descending_staircase->to_new('Grumchik Stronghold'),
                      $Terrain::descending_staircase->to_new('Grumchik Stronghold'),
                      $Terrain::descending_staircase->to_new('Grumchik Stronghold'),
                      $Terrain::descending_staircase->to_new('Grumchik Stronghold'),
                      $Actor::dwarkling->class('mage',5)->ghost,
                    ],
  ),
  'Rocky Coast' => Region->new('name' => 'Rocky Coast',
                    'sizex' => 60,
                    'sizey' => 60,
                    'music' => 'rocky_coast',
                    'outside' => $::sc{dark},
                    'ambient' => $Terrain::low_hillside,
                    'genpattern' => 'coastline',
                    'coast_dir' => 'N/S',
                    'coast_begin' => 0,
                    'coast_end' => 30,
                    'terraind' => Distribution->new(
                            0.300 => $Terrain::clump_of_trees,
                           ),
                    'terrgrade' => Distribution->new(
                            1.000 => $Terrain::ocean,
                           ),
                    'terrgradw' => Distribution->new(
                            0.150 => $Terrain::clump_of_trees,
                            0.100 => $Terrain::gully,
                            0.050 => $Terrain::grassy_flat,
                            0.010 => $Terrain::grassy_flat->enc(
  Encounter->new('actors' => [ $Actor::human->class('thief',4),
                               $Actor::human->class('thief',3),
                               $Actor::elf->class('thief',3),
                               $Actor::human->class('thief',2),
                               $Actor::gnome->class('thief',2),
                               $Actor::human->class('thief',2),
                               $Actor::human->class('thief',1),
                               $Actor::dwarf->class('thief',1),
                               $Actor::gnome->class('thief',1),
                               $Actor::elf->class('thief',1),
                               $Actor::human->class('thief',1),
                             ],
                 'message' => 'You spot a large band of thieves!',
                 'bribeable' => {
                    'coin'          => 2000,
                    'gold coin'     => 200,
                    'silver coin'   => 800,
                 })),
                           ),
                    'itemd' => Distribution->new(
                            0.0012 => $Item::helmet->make($Adj::bronze),
                           ),
                    'monsterd' => Distribution->new(
                            0.0010 => $Actor::human->class('bard',2),
                            0.0010 => $Actor::elf->class('thief',2),
                            0.0010 => $Actor::gnome->class('cleric',2),
                            0.0010 => $Actor::dwarf->class('soldier',2),
                            0.0010 => $Actor::demifaery->class('mage',2),
                            0.0010 => $Actor::ursati->class('ranger',2),
                           ),
  ),
  'Alkali Flats' => Region->new('name' => 'Alkali Flats',
                    'sizex' => 60,
                    'sizey' => 60,
                    'outside' => $::sc{dark},
                    'ambient' => $Terrain::alkali_flat,
                    'genpattern' => 'accretion',
                    'terraind' => Distribution->new(
                            0.100 => $Terrain::hardpan,
                            0.100 => $Terrain::barren_field,
                            0.180 => $Terrain::sandy_expanse,
                            0.050 => $Terrain::sand_dune,
                            0.050 => $Terrain::gully,
                            0.030 => $Terrain::low_hillside,
                            0.030 => $Terrain::clump_of_trees,
                           ),
                    'itemd' => Distribution->new(
                            0.0012 => $Item::hat->make($Adj::fur),
                           ),
                    'monsterd' => Distribution->new(
                            0.0020 => $Actor::blue_spider,
                           ),
  ),
  'Marshy Fields' => Region->new('name' => 'Marshy Fields',
                    'sizex' => 60,
                    'sizey' => 60,
                    'outside' => $::sc{dark},
                    'ambient' => $Terrain::grassy_flat,
                    'terraind' => Distribution->new(
                            0.230 => $Terrain::clump_of_trees,
                            0.300 => $Terrain::marsh,
                            0.070 => $Terrain::gully,
                            0.080 => $Terrain::low_hillside,
                           ),
                    'itemd' => Distribution->new(
                            0.0012 => $Item::hat->make($Adj::fur),
                           ),
                    'monsterd' => Distribution->new(
                            0.0020 => $Actor::blue_spider,
                           ),
  ),
  'Barren Expanse' => Region->new('name' => 'Barren Expanse',
                    'sizex' => 60,
                    'sizey' => 60,
                    'outside' => $::sc{dark},
                    'ambient' => $Terrain::barren_field,
                    'terraind' => Distribution->new(
                            0.230 => $Terrain::rocky_steppes,
                            0.070 => $Terrain::gully,
                            0.080 => $Terrain::low_hillside,
                           ),
                    'itemd' => Distribution->new(
                            0.0012 => $Item::hat->make($Adj::fur),
                           ),
                    'monsterd' => Distribution->new(
                            0.0020 => $Actor::blue_spider,
                           ),
  ),
  'Chapparal Fields' => Region->new('name' => 'Chapparal Fields',
                    'sizex' => 60,
                    'sizey' => 60,
                    'outside' => $::sc{dark},
                    'ambient' => $Terrain::forest_floor,
                    'terraind' => Distribution->new(
                            0.230 => $Terrain::clump_of_trees
                           ),
                    'itemd' => Distribution->new(
                            0.0012 => $Item::hat->make($Adj::fur),
                           ),
                    'monsterd' => Distribution->new(
                            0.0020 => $Actor::blue_spider,   # lotsa nomads!!!
                           ),
  ),
  'Muddy Coast' => Region->new('name' => 'Muddy Coast',
                    'sizex' => 60,
                    'sizey' => 60,
                    'outside' => $::sc{dark},
                    'ambient' => $Terrain::forest_floor,
                    'terraind' => Distribution->new(
                            0.230 => $Terrain::clump_of_trees
                           ),
                    'itemd' => Distribution->new(
                            0.0012 => $Item::hat->make($Adj::fur),
                           ),
                    'monsterd' => Distribution->new(
                            0.0020 => $Actor::blue_spider,
                           ),
  # should be coastline E/W
  ),
  'Dry Badlands' => Region->new('name' => 'Dry Badlands',
                    'sizex' => 60,
                    'sizey' => 60,
                    'outside' => $::sc{dark},
                    'ambient' => $Terrain::forest_floor,
                    'terraind' => Distribution->new(
                            0.230 => $Terrain::clump_of_trees
                           ),
                    'itemd' => Distribution->new(
                            0.0012 => $Item::hat->make($Adj::fur),
                           ),
                    'monsterd' => Distribution->new(
                            0.0020 => $Actor::blue_spider,
                           ),
  ),
  'Wooded Steppes' => Region->new('name' => 'Wooded Steppes',
                    'sizex' => 60,
                    'sizey' => 60,
                    'outside' => $::sc{dark},
                    'ambient' => $Terrain::forest_floor,
                    'terraind' => Distribution->new(
                            0.230 => $Terrain::clump_of_trees
                           ),
                    'itemd' => Distribution->new(
                            0.0012 => $Item::hat->make($Adj::fur),
                           ),
                    'monsterd' => Distribution->new(
                            0.0020 => $Actor::blue_spider,
                           ),
  ),
  'Pfefferhorn' => Region->new('name' => 'Pfefferhorn',
                    'sizex' => 60,
                    'sizey' => 60,
                    'outside' => $::sc{dark},
                    'ambient' => $Terrain::forest_floor,
                    'terraind' => Distribution->new(
                            0.230 => $Terrain::clump_of_trees
                           ),
                    'itemd' => Distribution->new(
                            0.0012 => $Item::hat->make($Adj::fur),
                           ),
                    'monsterd' => Distribution->new(
                            0.0020 => $Actor::blue_spider,
                           ),
  ),
  'Bakers Lookout' => Region->new('name' => 'Bakers Lookout',
                    'sizex' => 60,
                    'sizey' => 60,
                    'outside' => $::sc{dark},
                    'ambient' => $Terrain::forest_floor,
                    'terraind' => Distribution->new(
                            0.230 => $Terrain::clump_of_trees
                           ),
                    'itemd' => Distribution->new(
                            0.0012 => $Item::hat->make($Adj::fur),
                           ),
                    'monsterd' => Distribution->new(
                            0.0020 => $Actor::blue_spider,
                           ),
  ),
  'Rugged Edge' => Region->new('name' => 'Rugged Edge',
                    'sizex' => 60,
                    'sizey' => 60,
                    'outside' => $::sc{dark},
                    'ambient' => $Terrain::forest_floor,
                    'terraind' => Distribution->new(
                            0.230 => $Terrain::clump_of_trees
                           ),
                    'itemd' => Distribution->new(
                            0.0012 => $Item::hat->make($Adj::fur),
                           ),
                    'monsterd' => Distribution->new(
                            0.0020 => $Actor::blue_spider,
                           ),
  # should be coastline e/w
  ),
  'Bakers Bay' => Region->new('name' => 'Bakers Bay',
                    'sizex' => 60,
                    'sizey' => 60,
                    'outside' => $::sc{dark},
                    'ambient' => $Terrain::ocean,
                    'terraind' => Distribution->new(
                            0.230 => $Terrain::freshwater_pool
                           ),
                    'itemd' => Distribution->new(
                            0.000 => $Item::hat->make($Adj::fur),
                           ),
                    'monsterd' => Distribution->new(
                            0.000 => $Actor::blue_spider,
                           ),
  ),
  'Deep Waters' => Region->new('name' => 'Deep Waters',
                    'sizex' => 60,
                    'sizey' => 60,
                    'outside' => $::sc{dark},
                    'ambient' => $Terrain::ocean,
                    'terraind' => Distribution->new(
                            0.230 => $Terrain::freshwater_pool
                           ),
                    'itemd' => Distribution->new(
                            0.000 => $Item::hat->make($Adj::fur),
                           ),
                    'monsterd' => Distribution->new(
                            0.000 => $Actor::blue_spider,
                           ),
  ),
  'Cod Waters' => Region->new('name' => 'Cod Waters',
                    'sizex' => 60,
                    'sizey' => 60,
                    'outside' => $::sc{dark},
                    'ambient' => $Terrain::ocean,
                    'terraind' => Distribution->new(
                            0.230 => $Terrain::freshwater_pool
                           ),
                    'itemd' => Distribution->new(
                            0.000 => $Item::hat->make($Adj::fur),
                           ),
                    'monsterd' => Distribution->new(
                            0.000 => $Actor::blue_spider,
                           ),
  ),


);

1;
