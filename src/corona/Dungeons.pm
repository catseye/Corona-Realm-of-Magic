# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see file LICENSE for more info.

%::dungeons =
(
  'Giant Beehive' => Region->new('name' => 'Giant Beehive',
                    'sizex' => 20,
                    'sizey' => 20, 
                    'outside' => $::sc{dark},
                    'border' => $Terrain::dense_wax,
                    'ambient' => $Terrain::beehive_tunnel,
                    'terraind' => Distribution->new(
                            0.3333 => $Terrain::waxwork_wall,
                           ),
                    'itemd' => Distribution->new(
                            0.001 => $Item::stone,  # wax covered
                            0.001 => $Item::clump_of_grass,  # wax covered
                            0.010 => $Item::royal_jelly,
                            0.090 => $Item::golden_honeycomb,
                           ),
                    'monsterd' => Distribution->new(
                            0.010 => $Actor::queen_honeybee->hostile,
                            0.250 => $Actor::giant_honeybee->hostile,
                           ),
                    'apropos_exit' => $Terrain::small_hole,
  ),
  'Bakersport Hovel' => Region->new('name' => 'Bakersport Hovel',
                    'sizex' => 10,
                    'sizey' => 10, 
                    'outside' => $::sc{dark},
                    'border' => $Terrain::building_wall,
                    'ambient' => $Terrain::stonework_floor,
                    'terraind' => Distribution->new(
                            0.1 => $Terrain::building_wall,
                           ),
                    'itemd' => Distribution->new(
                            0.010 => $Item::knife->make($Adj::copper)->crude,
# clay pot, bowl, cup, spoon, fork
                           ),
                    'monsterd' => Distribution->new(
                            0.040 => $Actor::giant_grasshopper->hostile,
                           ),
                    'unique' =>
                    [
                      $Actor::human,
                      $Actor::giant_grasshopper->hostile,
                    ],
                    'apropos_exit' => $Terrain::wooden_doorway,
  ),
  'Dwarkling Hideout' => Region->new('name' => 'Dwarkling Hideout',
                    'sizex' => 30,
                    'sizey' => 30, 
                    'supplement' => Supplement->new(
                                    'title' => 'Dwarkling Hideout',
                                    'media' => 'music/fetid_swamp',
                                    ),
                    'outside' => $::sc{dark},
                    'border' => $Terrain::stonework_wall,
                    'ambient' => $Terrain::stonework_floor,
                    'terraind' => Distribution->new(
                            # dirt road
                            0.001 => $Terrain::freshwater_pool,
                            0.004 => $Terrain::descending_staircase->to_new('Dwarkling Hideout'),
                            0.400 => $Terrain::stonework_wall,
                           ),
                    'itemd' => Distribution->new(
                            0.0001 => $Item::wand->make($Adj::wood)->enchant($Talent::lightning_bolt, 3),
                            0.0001 => $Item::blank_scroll->enchant($Talent::empathy),
                            0.0001 => $Item::wand->make($Adj::wood)->enchant($Talent::charm, 3),
                            0.0001 => $Item::wand->make($Adj::iron)->enchant($Talent::card_capture, 3),
                            0.0001 => $Item::blank_scroll->enchant(Talent::create($Terrain::ancient_ruins)),
                            0.0001 => $Item::blank_scroll->enchant($Talent::magic_mapping),
                            0.0001 => $Item::blank_scroll->enchant(Talent::cause('confused',Dice->new(3,6))),
                            0.0001 => $Item::ring->make($Adj::opal)->oftalent('Talent::cure("blind")', +8),
                            0.0001 => $Item::torque->make($Adj::bronze)->oftalent('$Talent::identify_food', +12),
                            0.0001 => $Item::bracers->make($Adj::leather)->ofstat('dexterity',2),
                            0.0001 => $Item::girdle->make($Adj::leather)->ofstat('strength',2),
                            0.0001 => $Item::anklet->make($Adj::silver)->ofstat('intelligence',+1),
                            0.0001 => $Item::bracelet->make($Adj::meteoric_iron)->ofstat('constitution',+1),
                            0.0001 => $Item::bracelet->make($Adj::gold)->ofstat('constitution',-1)->cursed(1),
                            0.0001 => $Item::quarterstaff->make($Adj::wood)->fine,
                            0.0001 => $Item::longsword->make($Adj::iron)->magicked(1),
                            0.0001 => $Item::gloves->make($Adj::leather)->magicked(1),
                            0.0001 => $Item::helmet->make($Adj::iron)->cursed(1),
                            0.0001 => $Item::blank_scroll->enchant(Talent::summon($Actor::sylvan_snake, Dice->new(2,3))),
                            0.0001 => $Item::kerchief->make($Adj::silk)->ofstat('charisma',2),

                            0.0002 => $Item::broadsword->make($Adj::iron),
                            0.0002 => $Item::mace->make($Adj::iron),
                            0.0002 => $Item::quarterstaff->make($Adj::wood),

                            0.0004 => $Item::cloak->make($Adj::leather),
                            0.0004 => $Item::helm->make($Adj::bone)->crude,
                            0.0004 => $Item::sleeves->make($Adj::iron)->crude,    # todo: "chain", "plate", "scale", "ring" Adjs
                            0.0004 => $Item::gloves->make($Adj::fur)->fine,
                            0.0004 => $Item::dagger->make($Adj::copper),

                            0.0005 => $Item::cloak->make($Adj::fur)->fine,
                            0.0005 => $Item::shoes->make($Adj::leather)->fine,
                            0.0005 => $Item::greaves->make($Adj::iron)->crude,

                            0.0040 => $Item::coin->make($Adj::gold)->bunch(7),
                            0.0045 => $Item::coin->make($Adj::gold)->bunch(5),
                            0.0050 => $Item::coin->make($Adj::gold)->bunch(3),
                            0.0055 => $Item::coin->make($Adj::silver)->bunch(13),
                            0.0060 => $Item::coin->make($Adj::silver)->bunch(11),
                            0.0065 => $Item::coin->make($Adj::silver)->bunch(8),

                            0.0100 => $Item::stone->bunch(2),
                            0.0120 => $Item::stone->bunch(3),
                            0.0150 => $Item::stone->bunch(4),

                           ),
                    'monsterd' => Distribution->new(
                            0.0030 => $Actor::grue->hostile,
                            0.0060 => $Actor::guard_dog->hostile,
                            0.0030 => $Actor::dwarkling->class('thief',1)->hostile,
                            0.0030 => $Actor::dwarkling->class('soldier',1)->hostile,
                           ),
  ),
  'Grumchik Stronghold' => Region->new('name' => 'Grumchik Stronghold',
                    'sizex' => 40,
                    'sizey' => 40, 
                    'supplement' => Supplement->new(
                                    'title' => 'Grumchik Stronghold',
                                    'media' => 'music/fetid_swamp',
                                    ),
                    'outside' => $::sc{dark},
                    'border' => $Terrain::bedrock,
                    'ambient' => $Terrain::stonework_floor,
                    'genpattern' => 'dungeon',
                    'terraind' => Distribution->new(
                            0.010 => $Terrain::descending_staircase->to_new('Grumchik Stronghold'),
                            0.050 => $Terrain::bedrock,
                            0.940 => $Terrain::stonework_wall,
                           ),
                    'itemd' => Distribution->new(
                            0.0001 => $Item::wand->make($Adj::silver)->enchant($Talent::lightning_bolt, 8),
                            0.0001 => $Item::blank_scroll->enchant($Talent::magic_mapping),
                            0.0001 => $Item::blank_scroll->enchant(Talent::summon($Actor::floating_skull, Dice->new(2,3))),
                            0.0001 => $Item::blank_scroll->enchant($Talent::lightning_bolt),
                            0.0001 => $Item::blank_scroll->enchant($Talent::minor_heal),
                            0.0001 => $Item::anklet->make($Adj::bone)->ofstat('dexterity',+1),
                            0.0001 => $Item::bracelet->make($Adj::granite)->ofstat('spirit',+1),
                            0.0001 => $Item::sleeves->make($Adj::steel)->cursed(1)->ofstat('strength',-1),
                            0.0001 => $Item::belt->make($Adj::canvas)->ofstat('strength',+1),
                            0.0001 => $Item::hat->make($Adj::fur)->ofstat('intelligence',+1),
                            0.0001 => $Item::cloak->make($Adj::leather)->magicked(+2)->ofstat('dexterity',+1),

                            0.0005 => $Item::broadsword->make($Adj::copper),
                            0.0006 => $Item::mace->make($Adj::steel),
                            0.0008 => $Item::quarterstaff->make($Adj::granite),

                            0.0010 => $Item::coin->make($Adj::gold)->bunch(9),
                            0.0012 => $Item::coin->make($Adj::gold)->bunch(7),
                            0.0014 => $Item::coin->make($Adj::gold)->bunch(3),
                            0.0016 => $Item::coin->make($Adj::silver)->bunch(33),
                            0.0018 => $Item::coin->make($Adj::silver)->bunch(21),
                            0.0020 => $Item::coin->make($Adj::silver)->bunch(12),
                           ),
                    'monsterd' => Distribution->new(
                             0.0025 => $Actor::grumchik->miserable->hostile,
                             0.0025 => $Actor::grumchik->wily->hostile,
                             0.0025 => $Actor::grumchik->surly->hostile,
                             0.0025 => $Actor::grumchik->pudgy->hostile,
                           ),
  ),
);

1;
