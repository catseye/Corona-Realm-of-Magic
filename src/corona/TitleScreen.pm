$game_version = "v2000.12.04";

Supplement->new(
                 'title' => 'Corona: Realm of Magic',
                 'media' => 'music/corona_theme',
               )->browse;

::color('yellow','black');
::center_text(4,"C O R O N A");
::color('brown','black');
::center_text(5,"-----------");
::color('sky','black');
::center_text(8,"Realm of Magic");
::color('blue','black');
::center_text(9,$game_version);
::color('red','black');
::center_text(19,"Use numeric keypad to navigate. Make sure NUM LOCK is ON!");
::center_text(21,"(c)2000 Cat's Eye Technologies.  All rights reserved.");
::center_text(22,"This software is OSI Certified Open Source Software.");
::center_text(23,"See the file doc/license.txt for license information.");
::color('grey','black');

sub gen_bio
{
  my $self = shift;
  $self->{character_bio} =
  {
    'mother' => Distribution->new(0.20 => 'farmer',
                                  0.20 => 'merchant',
                                  0.20 => 'peasant',
                                  0.12 => 'carpenter',
                                  0.04 => 'smith',
                                  0.04 => 'soldier',
                                  0.04 => 'mage',
                                  0.04 => 'bard',
                                  0.04 => 'thief',
                                  0.04 => 'ranger',
                                  0.04 => 'necromancer')->pick,
    'father' => Distribution->new(0.20 => 'farmer',
                                  0.10 => 'merchant',
                                  0.10 => 'smith',
                                  0.20 => 'peasant',
                                  0.15 => 'soldier',
                                  0.05 => 'ranger',
                                  0.04 => 'druid',
                                  0.04 => 'cleric',
                                  0.04 => 'monk',
                                  0.04 => 'ninja',
                                  0.04 => 'mage')->pick,
    'childhood' => Distribution->new(0.20 => 'traumatic',
                                  0.20 => 'accelerated',
                                  0.20 => 'mischievious',
                                  0.20 => 'nurturing',
                                  0.20 => 'sheltered')->pick,
    'adolescence' => Distribution->new(0.20 => 'rebellious',
                                  0.20 => 'lazy',
                                  0.20 => 'idealistic',
                                  0.20 => 'violent',
                                  0.20 => 'troublesome')->pick,
  };
  my $off = $self->{sex} eq 'Male' ? 'son' : 'daughter';
  if ($self->{character_bio}{father} eq 'farmer' or $self->{character_bio}{mother} eq 'farmer')
  {
    $self->{character_bio}{father} = 'farmer';
    $self->{character_bio}{mother} = 'farmer';
  }
  if ($self->{character_bio}{father} eq 'peasant' or $self->{character_bio}{mother} eq 'peasant')
  {
    if (::d(1,20) < 13)
    {
      $self->{character_bio}{father} = 'peasant';
      $self->{character_bio}{mother} = 'peasant';
    }
  }
  if ($self->{race} eq 'Demifaery')
  {
    $self->{character_bio}{father} =
                Distribution->new(0.35 => 'faery',
                                  0.30 => 'sprite',
                                  0.20 => 'pixie',
                                  0.15 => 'atomie')->pick;
  }
  ::gotoxy(2, 18);
  ::display ::fitpad("You are the $off of a $self->{character_bio}{father} and a $self->{character_bio}{mother}.", $::pref{map_width}-2);
  ::gotoxy(2, 19);
  ::display ::fitpad("You had a $self->{character_bio}{childhood} childhood and a $self->{character_bio}{adolescence} adolescence.", $::pref{map_width}-2);
}

sub outfit
{
  my $leader = shift;
  my $start = 'Dark Forest';

  $leader->take($Item::torch->clone->identify);

  my @parents = ($leader->{character_bio}{father}, $leader->{character_bio}{mother});
  my $p;
  foreach $p (@parents)
  {
    if ($p eq 'necromancer')
    {
      # money, weapon, ring. magic theory.
      $leader->take($Item::coin->make($Adj::silver)->bunch(::d(1,4)+15)->clone->identify);
      $leader->take($Item::quarterstaff->make($Adj::wood)->clone->identify);
      $leader->put_on($Item::ring->ofstat('dexterity',+1)->clone->identify, 'rfinger', 1);
      $leader->learn(Talent::magic_theory('general'), ::d(1,6)+1);
    }
    if ($p eq 'mage')
    {
      # money, scroll, clothes. magic theory.
      $leader->take($Item::coin->make($Adj::silver)->bunch(::d(6,4)+1)->clone->identify);
      $leader->take($Item::blank_scroll->enchant($Talent::exploding_projectile)->clone->identify);
      if ($leader->{sex} eq 'Female')
      {
        $leader->put_on($Item::skirt->make($Adj::canvas)->clone->identify, 'waist', 1);
      } else
      {
        $leader->put_on($Item::girdle->make($Adj::canvas)->clone->identify, 'waist', 1);
      }
      $leader->learn(Talent::magic_theory('general'), ::d(2,6)+1);
    }
# cleric?
    if ($p eq 'druid')
    {
      # money, weapon, food. identify food
      $leader->take($Item::coin->make($Adj::silver)->bunch(::d(2,6,+3))->clone->identify);
      $leader->take($Item::quarterstaff->make($Adj::wood)->clone->identify);
      $leader->take($Item::berry->bunch(::d(4,4))->clone->identify);
      $leader->learn($Talent::identify_food, ::d(1,6));
    }
    if ($p eq 'ranger')
    {
      # range-weapon, ammo, food. identify food
      $leader->take($Item::short_bow->make($Adj::wood)->clone->identify);
      $leader->take($Item::arrow->make($Adj::bronze)->bunch(::d(4,3))->clone->identify);
      $leader->take($Item::ration->clone->identify);
      $leader->learn(Talent::armour_proficiency('head'), ::d(1,6)+1);
    }
    if ($p eq 'merchant')
    {
      # money, clothes, booze. starts in bakersport
      $leader->take($Item::coin->make($Adj::silver)->bunch(::d(10,4,+4))->clone->identify);
      $leader->take($Item::flask_of_brandy->clone->identify);
      if ($leader->{sex} eq 'Female')
      {
        $leader->put_on($Item::sleeved_shirt->make($Adj::silk)->clone->identify, 'torso', 1);
        $leader->put_on($Item::skirt->make($Adj::silk)->clone->identify, 'waist', 1);
      } else
      {
        $leader->put_on($Item::jerkin->make($Adj::silk)->clone->identify, 'torso', 1);
        $leader->put_on($Item::pantalons->make($Adj::silk)->clone->identify, 'waist', 1);
      }
      $start = 'Bakersport';
    }
    if ($p eq 'soldier')
    {
      # money, weapon, clothes. weapon proficiency.
      $leader->take($Item::coin->make($Adj::silver)->bunch(::d(3,4,+2))->clone->identify);
      $leader->take($Item::dagger->make($Adj::copper)->clone->identify);
      $leader->put_on($Item::girdle->make($Adj::leather)->clone->identify, 'waist', 1);
      $leader->learn(Talent::weapon_proficiency($Item::dagger), ::d(2,4));
    }
    if ($p eq 'bard')
    {
      # money, instrument, booze. song.
      $leader->take($Item::coin->make($Adj::silver)->bunch(::d(1,6))->clone->identify);
      $leader->take($Item::flute->make($Adj::wood)->clone->identify);
      $leader->take($Item::flask_of_brandy->clone->identify);
      $leader->learn(Talent::songof($Talent::charm, $Adj::flute), ::d(1,4));
    }
    if ($p eq 'thief')
    {
      # money, weapon, booze. pick pockets.
      $leader->take($Item::coin->make($Adj::silver)->bunch(::d(1,30))->clone->identify);
      $leader->take($Item::knife->make($Adj::bronze)->clone->identify);
      $leader->take($Item::flask_of_brandy->clone->identify);
    }
    if ($p eq 'farmer')
    {
      # money, clothes, food. identify food
      $leader->take($Item::coin->make($Adj::silver)->bunch(::d(1,8,+3))->clone->identify);
      $leader->take($Item::cabbage->bunch(::d(1,3,+1))->clone->identify);
      $leader->learn($Talent::identify_food, ::d(2,4));
      if ($leader->{sex} eq 'Female')
      {
        $leader->put_on($Item::halter->make($Adj::canvas)->clone->identify, 'torso', 1);
      }
      $leader->put_on($Item::pantalons->make($Adj::canvas)->clone->identify, 'waist', 1);
    }
# smith?
# carpenter?
    if ($p eq 'peasant')
    {
      # ammo. go without food, identify food, detect edible.
      $leader->take($Item::rock->bunch(::d(1,4))->clone->identify);
      #$leader->learn($Talent::go_without_food, ::d(5,6));
      $leader->learn($Talent::identify_food, ::d(3,6));
      $leader->learn(Talent::detect($Adj::edible), ::d(1,6));
    }
    if ($p eq 'sprite')
    {
      if ($leader->{sex} eq 'Female')
      {
        $leader->learn($Talent::lightning_bolt, ::d(2,4));
      } else
      {
        $leader->learn(Talent::create($Terrain::clump_of_trees), ::d(2,4));
      }
    }
    if ($p eq 'atomie')
    {
      if ($leader->{sex} eq 'Female')
      {
        $leader->learn($Talent::exploding_projectile, ::d(2,4));
      } else
      {
        $leader->learn($Talent::wizard_window, ::d(2,4));
      }
    }
    if ($p eq 'pixie')
    {
      if ($leader->{sex} eq 'Female')
      {
        $leader->learn($Talent::pixie_pyrotechnics, ::d(2,4));
      } else
      {
        $leader->learn($Talent::wizard_window, ::d(2,4));  # invisibility
      }
    }
    if ($p eq 'faery')
    {
      if ($leader->{sex} eq 'Female')
      {
        $leader->learn(Talent::touch($Adj::electricity, Dice->new(1,3)), ::d(2,4));
      } else
      {
        $leader->learn(Talent::detect($Adj::magic), ::d(2,4));
      }
    }
  }

  if ($leader->{sex} eq 'Female' and not defined $leader->{torso})
  {
    $leader->put_on($Item::halter->make($Adj::fur)->clone->identify, 'torso', 1);
  }
  if (not defined $leader->{waist})
  {
    $leader->put_on($Item::loincloth->make($Adj::fur)->clone->identify, 'waist', 1);
  }

    # $leader->take($Item::wand->enchant($Talent::lightning_bolt, 3)->clone->identify);
    # $leader->take($Item::wand->enchant($Talent::charm, 5)->clone->identify);
    # $leader->take($Item::wand->enchant($Talent::card_capture, 8)->clone->identify);
    # $leader->take($Item::blank_scroll->enchant($Talent::magic_mapping)->bunch(3)->clone->identify);
    # $leader->take($Item::blank_scroll->enchant($Talent::gigantic_growth)->bunch(5)->clone->identify);
    # $leader->take($Item::blank_scroll->enchant(Talent::resist($Adj::fire, Dice->new(5,5)))->bunch(4)->clone->identify);
    # $leader->take($Item::blank_scroll->enchant(Talent::resist($Adj::cold, Dice->new(5,5)))->bunch(4)->clone->identify);
    # $leader->take($Item::blank_scroll->enchant(Talent::bolt($Adj::fire, Dice->new(2,4,+1)))->bunch(4)->clone->identify);
    # $leader->take($Item::blank_scroll->enchant($Talent::wizard_window)->bunch(4)->clone->identify);
    # $leader->take($Item::blank_scroll->enchant($Talent::exploding_projectile)->bunch(4)->clone->identify);

    # $leader->take($Item::blank_scroll->enchant($Talent::pixie_pyrotechnics)->bunch(4)->clone->identify);
    # $leader->take($Item::blank_scroll->enchant(Talent::detect($Adj::magic))->bunch(8)->clone->identify);
    # $leader->take($Item::blank_scroll->enchant(Talent::detect($Adj::metal))->bunch(8)->clone->identify);
    # $leader->take($Item::blank_scroll->enchant(Talent::detect($Adj::obstacle))->bunch(8)->clone->identify);
    # $leader->take($Item::blank_scroll->enchant(Talent::detect($Adj::water))->bunch(8)->clone->identify);

    # $leader->take($Item::blank_scroll->enchant(Talent::polymorph($Actor::forest_cat, Dice->new(6,6)))->bunch(4)->clone->identify);
    # $leader->take($Item::blank_scroll->enchant(Talent::polymorph($Actor::green_alligator, Dice->new(6,6)))->bunch(4)->clone->identify);
    # $leader->take($Item::mundane_mushroom->enchant(Talent::cure('confused'))->clone->identify);
    # $leader->take($Item::poison_mushroom->clone);
    # $leader->take($Item::death_cabbage->clone);
    # $leader->take($Item::wand->enchant(Talent::create_cloud($Terrain::fog), 8)->clone->identify);

    # $leader->take($Item::blank_card->capture($Actor::wood_sprite));
    # $leader->take($Item::spirit_berry->bunch(2000)->clone->identify);

    # $leader->take($Item::cape->make($Adj::silk)->ofstat('dexterity',+5)->oftalent('$Talent::laugh_of_insanity', +12));
    # $leader->take($Item::ring->ofresist('crushing',+1.00)->ofresist('cutting',+1.00)->ofresist('piercing',+1.00));

    # $leader->take($Item::sleeved_shirt->make($Adj::silk)->ofstat('charisma',+1));
    # $leader->take($Item::sleeved_shirt->make($Adj::wood)->ofstat('constitution',+1));
    # $leader->take($Item::sleeved_shirt->make($Adj::granite)->ofstat('dexterity',-3));
    # $leader->take($Item::sleeved_shirt->make($Adj::clay)->ofstat('dexterity',-1));

    # $leader->take($Item::flute->make($Adj::silver)->oftalent('Talent::songof($Talent::charm,$Adj::flute)', +15)->clone);
    # $leader->take($Item::flute->make($Adj::gold)->clone->identify);

  # $::leader->{experience} += 100000;

  $::reg{$start}->enter($leader);
}

1;
