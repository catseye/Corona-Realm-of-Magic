# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see file LICENSE for more info.

package Actor;

### BAKERSPORT

$ehrla       = Actor->new('name'         => 'Ehrla',
                          'proper'       => 1,
'max' => {
                          'strength'     => Dice->new(18,1),
                          'constitution' => Dice->new(18,1),
                          'dexterity'    => Dice->new(16,1),
                          'intelligence' => Dice->new(11,1),
                          'spirit'       => Dice->new(9,1),
                          'charisma'     => Dice->new(9,1),
},
                          'sex'          => 'Female',
                          'race'         => 'Human',
                          'appearance'   => 'person',
                          'color'        => 'blue',
                          'hair_type'    => 'straight',
                          'hair_color'   => 'black',
                          'eye_type'     => 'cold',
                          'eye_color'    => 'grey',
                          'skin_type'    => 'sooty',
                          'skin_color'   => 'pink',
                          'body_aim'     => 'smart_biped',
                          'combat'       => 'Fight',
                          'domhand'      => 'lhand',
                         )->class('soldier',4)->class('smith',8);

$ehrla->take($Item::broadsword->make($Adj::iron)->bunch(::d(1,6))->perceive_value($Item::coin->make($Adj::silver)->bunch(60)->clone->identify)->identify);
$ehrla->take($Item::longsword->make($Adj::iron)->bunch(::d(1,6))->perceive_value($Item::coin->make($Adj::silver)->bunch(70)->clone->identify)->identify);
$ehrla->take($Item::longsword->make($Adj::iron)->fine->bunch(::d(1,2))->perceive_value($Item::coin->make($Adj::silver)->bunch(140)->clone->identify)->identify);
$ehrla->take($Item::short_sword->make($Adj::iron)->bunch(::d(1,6))->perceive_value($Item::coin->make($Adj::silver)->bunch(40)->clone->identify)->identify);
$ehrla->take($Item::katana->make($Adj::iron)->bunch(::d(1,6))->perceive_value($Item::coin->make($Adj::silver)->bunch(50)->clone->identify)->identify);
$ehrla->take($Item::dagger->make($Adj::iron)->bunch(::d(1,6))->perceive_value($Item::coin->make($Adj::silver)->bunch(25)->clone->identify)->identify);
$ehrla->take($Item::knife->make($Adj::iron)->bunch(::d(1,6))->perceive_value($Item::coin->make($Adj::silver)->bunch(20)->clone->identify)->identify);
$ehrla->take($Item::rod->make($Adj::iron)->crude->bunch(::d(4,4))->perceive_value($Item::coin->make($Adj::silver)->bunch(3)->clone->identify)->identify);
$ehrla->take($Item::hammer->make($Adj::iron)->bunch(::d(1,2))->perceive_value($Item::coin->make($Adj::silver)->bunch(100)->clone->identify)->identify);
$ehrla->take($Item::club->make($Adj::wood)->fine->bunch(::d(1,3))->perceive_value($Item::coin->make($Adj::silver)->bunch(20)->clone->identify)->identify);
$ehrla->take($Item::mace->make($Adj::iron)->bunch(::d(1,3))->perceive_value($Item::coin->make($Adj::silver)->bunch(45)->clone->identify)->identify);
$ehrla->take($Item::flail->make($Adj::iron)->bunch(::d(1,4))->perceive_value($Item::coin->make($Adj::silver)->bunch(55)->clone->identify)->identify);
$ehrla->take($Item::quarterstaff->make($Adj::wood)->bunch(::d(1,3))->perceive_value($Item::coin->make($Adj::silver)->bunch(30)->clone->identify)->identify);
$ehrla->take($Item::quarterstaff->make($Adj::wood)->fine->bunch(::d(1,2))->perceive_value($Item::coin->make($Adj::silver)->bunch(60)->clone->identify)->identify);

$ehrla->learn(Talent::train('smith',1), 100)->perceive_value($Item::coin->make($Adj::silver)->bunch(150)->clone->identify);
$ehrla->learn(Talent::train('smith',2), 100)->perceive_value($Item::coin->make($Adj::silver)->bunch(400)->clone->identify);
$ehrla->learn(Talent::train('smith',3), 100)->perceive_value($Item::coin->make($Adj::silver)->bunch(1000)->clone->identify);
$ehrla->learn(Talent::train('smith',4), 100)->perceive_value($Item::coin->make($Adj::silver)->bunch(2500)->clone->identify);

$bonzi       = Actor->new('name'         => 'Bonzi',
                          'proper'       => 1,
'max' => {
                          'strength'     => Dice->new(11,1),
                          'constitution' => Dice->new(9,1),
                          'dexterity'    => Dice->new(12,1),
                          'intelligence' => Dice->new(14,1),
                          'spirit'       => Dice->new(11,1),
                          'charisma'     => Dice->new(18,1),
},
                          'sex'          => 'Male',
                          'race'         => 'Gnome',
                          'appearance'   => 'person',
                          'color'        => 'grey',
                          'hair_type'    => 'curly',
                          'hair_color'   => 'white',
                          'eye_type'     => 'smiling',
                          'eye_color'    => 'azure',
                          'skin_type'    => 'gnarled',
                          'skin_color'   => 'grey',
                          'body_aim'     => 'smart_biped',
                          'combat'       => 'TalentFight',
                          'domhand'      => 'rhand',
                         )->class('mage',4)->class('merchant',8);

$bonzi->take($Item::blank_manual->enchant($Talent::minor_heal)->bunch(::d(1,2))->perceive_value($Item::coin->make($Adj::gold)->bunch(250)->clone->identify)->identify);
$bonzi->take($Item::blank_manual->enchant($Talent::major_heal)->bunch(::d(1,2))->perceive_value($Item::coin->make($Adj::gold)->bunch(750)->clone->identify)->identify);
$bonzi->take($Item::blank_manual->enchant(Talent::cause('confused',Dice->new(3,6)))->bunch(::d(1,2))->perceive_value($Item::coin->make($Adj::gold)->bunch(300)->clone->identify)->identify);
$bonzi->take($Item::blank_manual->enchant(Talent::cure('confused'))->bunch(::d(1,2))->perceive_value($Item::coin->make($Adj::gold)->bunch(300)->clone->identify)->identify);
$bonzi->take($Item::blank_manual->enchant(Talent::cause('blind',Dice->new(3,6)))->bunch(::d(1,2))->perceive_value($Item::coin->make($Adj::gold)->bunch(300)->clone->identify)->identify);
$bonzi->take($Item::blank_manual->enchant(Talent::cure('blind'))->bunch(::d(1,2))->perceive_value($Item::coin->make($Adj::gold)->bunch(300)->clone->identify)->identify);
$bonzi->take($Item::blank_manual->enchant($Talent::lightning_bolt)->bunch(::d(1,2))->perceive_value($Item::coin->make($Adj::gold)->bunch(500)->clone->identify)->identify);
$bonzi->take($Item::blank_manual->enchant(Talent::summon($Actor::floating_skull, Dice->new(2,3)))->bunch(::d(1,2))->perceive_value($Item::coin->make($Adj::gold)->bunch(750)->clone->identify)->identify);
$bonzi->take($Item::blank_manual->enchant(Talent::create($Terrain::waxwork_wall))->bunch(::d(1,2))->perceive_value($Item::coin->make($Adj::gold)->bunch(500)->clone->identify)->identify);

$bonzi->{waist} = $Item::girdle->make($Adj::meteoric_iron)->ofstat('strength',+7);
$bonzi->{rhand} = $Item::club->make($Adj::lead)->magicked(+4)->ofstat('constitution',+1);
$bonzi->{rfinger} = $Item::ring->make($Adj::copper)->ofstat('constitution',+1);
$bonzi->{feet} = $Item::boots->make($Adj::leather)->ofstat('dexterity',+1);

$bonzi->learn(Talent::train('mage',1), 100)->perceive_value($Item::coin->make($Adj::gold)->bunch(100)->clone->identify);
$bonzi->learn(Talent::train('mage',2), 100)->perceive_value($Item::coin->make($Adj::gold)->bunch(500)->clone->identify);

$eblec       = Actor->new('name'         => 'Eblec',
                          'proper'       => 1,
'max' => {
                          'strength'     => Dice->new(7,1),
                          'constitution' => Dice->new(11,1),
                          'dexterity'    => Dice->new(15,1),
                          'intelligence' => Dice->new(15,1),
                          'spirit'       => Dice->new(15,1),
                          'charisma'     => Dice->new(11,1),
},
                          'sex'          => 'Male',
                          'race'         => 'Elf',
                          'appearance'   => 'person',
                          'color'        => 'white',
                          'hair_type'    => 'frazzled',
                          'hair_color'   => 'blond',
                          'eye_type'     => 'deep',
                          'eye_color'    => 'green',
                          'skin_type'    => 'puffy',
                          'skin_color'   => 'white',
                          'body_aim'     => 'smart_biped',
                          'combat'       => 'TalentFight',
                          'domhand'      => 'rhand',
                         )->class('ranger',4)->class('merchant',8);

$eblec->take($Item::coin->make($Adj::silver)->bunch(::d(30,5))->identify);

$eblec->take($Item::mundane_mushroom->enchant($Talent::minor_heal)->bunch(::d(1,2))->perceive_value($Item::coin->make($Adj::silver)->bunch(150)->clone->identify)->clone->identify);
$eblec->take($Item::mundane_mushroom->enchant(Talent::cure('blind'))->bunch(::d(1,2))->perceive_value($Item::coin->make($Adj::silver)->bunch(250)->clone->identify)->clone->identify);

$eblec->learn(Talent::train('merchant',1), 100)->perceive_value($Item::coin->make($Adj::gold)->bunch(250)->clone->identify);
$eblec->learn(Talent::train('merchant',2), 100)->perceive_value($Item::coin->make($Adj::gold)->bunch(1000)->clone->identify);

# $eblec->take($Item::blank_scroll->enchant(Talent::summon($Actor::green_alligator, Dice->new(1,2,+1)))->bunch(::d(1,2))->perceive_value($Item::coin->make($Adj::silver)->bunch(400)->clone->identify)->clone->identify);
# $eblec->take($Item::blank_card->capture($Actor::grizzly_bear)->perceive_value($Item::coin->make($Adj::silver)->bunch(400)->clone->identify)->identify);
# $eblec->take($Item::blank_card->capture($Actor::elf->class('thief',4)->zombie)->perceive_value($Item::coin->make($Adj::silver)->bunch(400)->clone->identify)->identify);
# $eblec->take($Item::blank_card->capture($Actor::grumchik->wily)->perceive_value($Item::coin->make($Adj::silver)->bunch(200)->clone->identify)->identify);
# $eblec->take($Item::belt->make($Adj::bronze)->ofstat('strength',+1)->bunch(::d(1,2))->perceive_value($Item::coin->make($Adj::silver)->bunch(5000)->clone->identify)->identify);
# $eblec->take($Item::cloak->make($Adj::leather)->ofstat('dexterity',+1)->bunch(::d(1,2))->perceive_value($Item::coin->make($Adj::silver)->bunch(7500)->clone->identify)->identify);

$sirgon      = Actor->new('name'         => 'Sirgon',
                          'proper'       => 1,
'max' => {
                          'strength'     => Dice->new(9,1),
                          'constitution' => Dice->new(9,1),
                          'dexterity'    => Dice->new(12,1),
                          'intelligence' => Dice->new(16,1),
                          'spirit'       => Dice->new(18,1),
                          'charisma'     => Dice->new(10,1),
},
                          'sex'          => 'Male',
                          'race'         => 'Human',
                          'appearance'   => 'person',
                          'color'        => 'lime',
                          'hair_type'    => 'balding',
                          'hair_color'   => 'white',
                          'eye_type'     => 'sad',
                          'eye_color'    => 'grey',
                          'skin_type'    => 'sickly',
                          'skin_color'   => 'green',
                          'body_aim'     => 'smart_biped',
                          'combat'       => 'TalentFight',
                          'domhand'      => 'rhand',
                         )->class('merchant',4)->class('cleric',8);

$sirgon->take($Item::blank_scroll->enchant($Talent::minor_heal)->perceive_value($Item::coin->make($Adj::silver)->bunch(30)->clone->identify)->identify->bunch(::d(2,4)));
$sirgon->take($Item::blank_scroll->enchant($Talent::major_heal)->perceive_value($Item::coin->make($Adj::silver)->bunch(100)->clone->identify)->identify->bunch(::d(2,4)));
$sirgon->take($Item::blank_scroll->enchant(Talent::cure('blind'))->perceive_value($Item::coin->make($Adj::silver)->bunch(200)->clone->identify)->identify->bunch(::d(2,4)));
$sirgon->take($Item::blank_scroll->enchant(Talent::cure('dumb'))->perceive_value($Item::coin->make($Adj::silver)->bunch(200)->clone->identify)->identify->bunch(::d(2,4)));
$sirgon->take($Item::blank_scroll->enchant(Talent::cure('deaf'))->perceive_value($Item::coin->make($Adj::silver)->bunch(250)->clone->identify)->identify->bunch(::d(2,4)));

# blessed armor and weapons

$sirgon->learn(Talent::train('cleric',1), 100)->perceive_value($Item::coin->make($Adj::silver)->bunch(50)->clone->identify);
$sirgon->learn(Talent::train('cleric',2), 100)->perceive_value($Item::coin->make($Adj::silver)->bunch(50)->clone->identify);
$sirgon->learn(Talent::train('cleric',3), 100)->perceive_value($Item::coin->make($Adj::silver)->bunch(50)->clone->identify);
$sirgon->learn(Talent::train('cleric',4), 100)->perceive_value($Item::coin->make($Adj::silver)->bunch(50)->clone->identify);

# $eblec->take($Item::blank_card->capture($Actor::grizzly_bear)->perceive_value($Item::coin->make($Adj::silver)->bunch(400)->clone->identify)->identify);
# $eblec->take($Item::blank_card->capture($Actor::elf->class('thief',4)->zombie)->perceive_value($Item::coin->make($Adj::silver)->bunch(400)->clone->identify)->identify);
# $eblec->take($Item::blank_card->capture($Actor::grumchik->wily)->perceive_value($Item::coin->make($Adj::silver)->bunch(200)->clone->identify)->identify);
# $eblec->take($Item::belt->make($Adj::bronze)->ofstat('strength',+1)->bunch(::d(1,2))->perceive_value($Item::coin->make($Adj::silver)->bunch(5000)->clone->identify)->identify);
# $eblec->take($Item::cloak->make($Adj::leather)->ofstat('dexterity',+1)->bunch(::d(1,2))->perceive_value($Item::coin->make($Adj::silver)->bunch(7500)->clone->identify)->identify);

$boutek      = Actor->new('name'         => 'Boutek',
                          'proper'       => 1,
'max' => {
                          'strength'     => Dice->new(18,1),
                          'constitution' => Dice->new(16,1),
                          'dexterity'    => Dice->new(12,1),
                          'intelligence' => Dice->new(9,1),
                          'spirit'       => Dice->new(9,1),
                          'charisma'     => Dice->new(10,1),
},
                          'sex'          => 'Male',
                          'race'         => 'Dwarf',
                          'appearance'   => 'person',
                          'color'        => 'white',
                          'hair_type'    => 'trimmed',
                          'hair_color'   => 'white',
                          'eye_type'     => 'vacant',
                          'eye_color'    => 'pink',
                          'skin_type'    => 'light',
                          'skin_color'   => 'grey',
                          'body_aim'     => 'smart_biped',
                          'combat'       => 'Fight',
                          'domhand'      => 'rhand',
                         )->class('merchant',4)->class('soldier',8);  # gladiator

$boutek->learn(Talent::train('soldier',1), 100)->perceive_value($Item::coin->make($Adj::silver)->bunch(100)->clone->identify);
$boutek->learn(Talent::train('soldier',2), 100)->perceive_value($Item::coin->make($Adj::silver)->bunch(300)->clone->identify);
$boutek->learn(Talent::train('soldier',3), 100)->perceive_value($Item::coin->make($Adj::silver)->bunch(800)->clone->identify);
$boutek->learn(Talent::train('soldier',4), 100)->perceive_value($Item::coin->make($Adj::silver)->bunch(2000)->clone->identify);

$phaeref     = Actor->new('name'         => 'Phaeref',
                          'proper'       => 1,
'max' => {
                          'strength'     => Dice->new(16,1),
                          'constitution' => Dice->new(17,1),
                          'dexterity'    => Dice->new(13,1),
                          'intelligence' => Dice->new(11,1),
                          'spirit'       => Dice->new(11,1),
                          'charisma'     => Dice->new(6,1),
},
                          'sex'          => 'Female',
                          'race'         => 'Human',
                          'appearance'   => 'person',
                          'color'        => 'grey',
                          'hair_type'    => 'grizzled',
                          'hair_color'   => 'yellow',
                          'eye_type'     => 'icy',
                          'eye_color'    => 'azure',
                          'skin_type'    => 'rough',
                          'skin_color'   => 'brown',
                          'body_aim'     => 'smart_biped',
                          'combat'       => 'Fight',
                          'domhand'      => 'rhand',
                         )->class('merchant',4)->class('soldier',8);  # sailor

$phaeref->take($Item::coin->make($Adj::gold)->bunch(::d(30,30))->perceive_value($Item::coin->make($Adj::silver)->bunch(10)->clone->identify)->identify);
$phaeref->take($Item::coin->make($Adj::silver)->bunch(::d(90,90))->perceive_value($Item::coin->make($Adj::copper)->bunch(10)->clone->identify)->identify);
$phaeref->take($Item::coin->make($Adj::copper)->bunch(::d(90,800))->identify);

# hire boat, etc.

1;
