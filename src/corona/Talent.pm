# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see file LICENSE for more info.

package Talent;

require "$::universe/Spell.pm";

### NON-CONSTRUCTOR SPELLS ###

# NOTE NOTE NOTE NOTE NOTE NOTE NOTE
# $self might be an Actor *or* an Item!
# $target could be anything!

### CLERIC

# consecrate ground

$consecrate_ground = Talent->new('name'       => 'consecrate ground',
                                 'type'       => 'prayer',
                                 'verbal'     => 1,
                                 'somatic'    => 1,
                                 'range'      => 1,
                                 'moves'      => 8,
                                 'material'   => '[ $Item::holy_water->identify, $Item::holy_symbol->identify ]',
                                 'consumed'   => '[ $Item::holy_water->identify ]',
                       'on_perform'=> <<'END',
    my ($self, $target, $talent) = @_;
    if (ref($target) eq 'Actor')
    {
      $self->seen($target, "<self> cannot consecrate the ground while <other> is standing on it.");
    } elsif (ref($target) eq 'Terrain')
    {
      if ($target->is($Adj::cursed))
      {
        $self->seen($target, "Some force seems to be interfering, and <self> cannot manage to consecrate <other>.");
      } else
      {
        $target->implies($Adj::blessing);
        $self->seen($target, "<self> consecrates <other>.");
      }
    }
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    # if $caster is carrying a carcass of his own species, 1 , else
    return 0;
END
);

$ceremonial_burial = Talent->new('name'       => 'ceremonial burial',
                                 'type'       => 'prayer',
                                 'verbal'     => 1,
                                 'somatic'    => 1,
                                 'range'      => 0,
                                 'moves'      => 8,
                                 'onitem'     => 1,
                                 'material'   => '[ $Item::holy_water->identify, $Item::holy_symbol->identify, $Item::shovel ]', # blessed shovel?
                                 'consumed'   => '[ $Item::holy_water->identify ]',
                       'on_perform'=> <<'END',
    my ($self, $target, $talent) = @_;
    my $top = $self->{location}->get_top($self->{x},$self->{y});
    if (ref($target->{soul}) ne 'Actor' or $target->{name} !~ /carcass/)
    {
      $self->seen($target, "<self> can't have a funeral for <other>.");
    } elsif(not $top->is($Adj::blessing))
    {
      $self->seen($target, "<self> can only bury <other> in consecrated ground.");
    } elsif ($target->is($Adj::cursed))
    {
      $self->seen($target, "Some force seems to be interfering, and <self> cannot manage to bury <other>.");
    } else
    {
      $self->relieve($target);
      $top->{grafitti} = "Here lies $target->{soul}{name}. ";
      $self->seen($target, "<self> buries <other>.");
    }
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    # if $caster is carrying a carcass of his own species, 1 , else
    return 0;
END
);

# detect creatures

$empathy = Talent->new('name'       => 'empathy',
                       'type'       => 'prayer',
                       'verbal'     => 1,
                       'somatic'    => 1,
                       'range'      => 6,
                       'moves'      => 3,
                       'on_perform'=> <<'END',
    my ($self, $target, $talent) = @_;
    if (ref($target) eq 'Actor') { $target->view('status'); }
    $self->seen($target, "<self> feels what it is like to be <other>.");
    $self->review();
    $self->seen($target, "The empathic connection between <self> and <other> fades.");
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    # if $caster is facing an unknown enemy?
    0;
END
);

$minor_heal = Talent->new('name'       => 'minor heal',
                          'type'       => 'prayer',
                          'verbal'     => 1,
                          'somatic'    => 1,
                          'range'      => 1,
                       'on_perform'=> <<'END',
    my ($self, $target, $talent) = @_;
    if (ref($target) eq 'Actor')
    {
      $target->adjust('constitution',+::d(1,3)+1,$self);
    }
    $self->seen($target, "<self> heals <other>.");
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if ($caster->{op}{constitution} < int($caster->{max}{constitution}/2) or
                 $caster->{op}{constitution} < 2);
    return 0;
END
);

$major_heal = Talent->new('name'       => 'major heal',
                          'type'       => 'prayer',
                          'verbal'     => 1,
                          'somatic'    => 1,
                          'range'      => 1,
                       'on_perform'=> <<'END',
    my ($self, $target, $talent) = @_;
    if (ref($target) eq 'Actor')
    {
      $target->adjust('constitution',+::d(6,3),$self);
    }
    $self->seen($target, "<self> heals <other>.");
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if ($caster->{op}{constitution} < int($caster->{max}{constitution}/3) or
                 $caster->{op}{constitution} < 2);
    return 0;
END
);

# spirit hammer

### MAGE

$magic_mapping = Talent->new('name'       => 'magic mapping',
                             'type'       => 'spell',
                             'verbal'     => 1,
                             'somatic'    => 1,
                             'material'   => '[ $Item::iron_rod->crude->identify, $Item::clove_of_garlic->bunch(4)->identify ]',
                             'consumed'   => '[ $Item::clove_of_garlic->bunch(3)->identify ]',
                             'cost'       => 16,
                             'range'      => 0,
                             'on_perform' => <<'END',
    my ($self, $target, $talent) = @_;
    my $l = $self->{location};
    my $x; my $y;
    for($x = 0; $x < $l->{sizex}; $x++)
    {
      for($y = 0; $y < $l->{sizey}; $y++)
      {
        $l->{lit}[$x][$y] = 1;
      }
    }
    $l->display($self);
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 0;
END
);

# to be replaced with: boltof(lightning)

$lightning_bolt = Talent->new('name'       => 'lightning bolt',
                              'type'       => 'spell',
                              'verbal'     => 1,
                              'somatic'    => 1,
                              'cost'       => 9,
                              'range'      => 6,
                             'on_perform' => <<'END',
    my ($self, $target, $talent) = @_;
    $self->seen($target, "<self> hurls a lightning bolt at <other>!");
    $target->hurt(Attack->weapon(+3, Dice->new(2,4), $Adj::electricity, $Adj::magic), $talent, $Distribution::bp{random}->pick);
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) <= $self->{range}
                                           and $caster->dist($caster->{target}) > 1;
    return 0;
END
);

$blur_self = Talent->new('name'       => 'blur self',
                              'type'       => 'spell',
                              'cost'       => 2,
                              'verbal'     => 1,
                              'somatic'    => 1,
                              'range'      => 0,
                              'on_perform' => <<'END',
    my ($self, $target, $talent) = @_;
    $self->seen($self, "The image of <self> becomes fuzzy and indistinct.");
    $self->{blurry} += ::d(2,6);
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) <= 4
                                           and $caster->dist($caster->{target}) > 1;
    return 0;
END
);

$card_capture   = Talent->new('name'       => 'card capture',
                              'type'       => 'spell',
                              'cost'       => 9,
                              'verbal'     => 1,
                              'somatic'    => 1,
                              'material'   => '[ $Item::blank_card->identify, $Item::gold_coin->identify ]',
                              'consumed'   => '[ $Item::blank_card->identify, $Item::gold_coin->identify ]',
                              'range'      => 6,
                             'on_perform' => <<'END',
    my ($self, $target, $talent) = @_;
    my $i = $Item::blank_card->clone;
    $target->seen($self, "<self>'s essence is drained and infused into a card held by <other>!");
    $target->{location}->relieve($target);
    $i->{name} = 'card';
    $i->{identity} = $target->{name} . ' card';
    $i->{soul} = $target;
    $self->take($i);
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) <= $self->{range};
    return 0;
END
);

$gigantic_growth = Talent->new('name'       => 'gigantic growth',
                              'type'       => 'spell',
                              'cost'       => 3,
                              'verbal'     => 1,
                              'somatic'    => 1,
                              'range'      => 4,
                              'on_perform' => <<'END',
  {
    my ($self, $target, $talent) = @_;
    $target->seen($self, "<self> slowly begins to grow to giant size under <other>'s enchantment!");
    $target->{max}{strength} *= 2;
    $target->{max}{constitution} *= 2;
    $::fuses->add(<<'END_FUSE', ::d(12,12), [$target], 'morph');
    {
      my ($target) = @_;
      $target->seen($target, "<self> slowly begins to shrink back to normal size.");
      $target->{max}{strength} /= 2;
      $target->{max}{constitution} /= 2;
      $target->review('status');
      0;
    }
END_FUSE
    $target->review('status');
  }
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) <= 4
                                           and $caster->dist($caster->{target}) > 1;
    return 0;
END
);

$wizard_window  = Talent->new('name'       => 'wizard window',
                              'type'       => 'spell',
                              'cost'       => 1,
                              'verbal'     => 1,
                              'somatic'    => 1,
                              'range'      => 2,
                              'on_perform' => <<'END',
  {
    my ($self, $target, $talent) = @_;
    my $was;
    if (ref($target) ne 'Terrain')
    {
      $target->seen("<self> only flickers momentarily.");
    } else
    {
      $was = $target->{opacity};
      if ($was == 100)
      {
        $target->seen("<self> becomes translucent.");
      } else
      {
        $target->seen("<self> becomes more transparent.");
      }
      $target->{opacity} /= 2;
      $::fuses->add(<<'END_FUSE', ::d(4,4), [$target, $was], 'cloud');
      {
        my ($target, $was) = @_;
        $target->seen("<self>'s translucency wanes.");
        $target->{opacity} = $was;
        0;
      }
END_FUSE
    }
  }
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 0;
END
);

$exploding_projectile  = Talent->new('name'       => 'exploding projectile',
                                     'type'       => 'spell',
                                     'cost'       => 3,
                                     'verbal'     => 1,
                                     'somatic'    => 1,
                                     'range'      => 0,
                                     'onitem'     => 1,
                                     'on_perform' => <<'END',
  {
    my ($self, $target, $talent) = @_;
    my $was;
    if (ref($target) ne 'Item')
    {
      $target->seen("<self> only glows momentarily.");
    } else
    {
      if ($target->{count} > 1)
      {
        $target->{count}--;
        $target = $target->bunch(1);
        $target->{identity} .= ' bomb';
        $talent->{caster}->take($target);
      }
      $target->seen("<self> begins to glow very faintly.");
      my $flag = 1;
      $::fuses->add(<<'END_FUSE', int($target->{weight} / 2)+1, [$target, $flag], 'explosion');
      {
        my ($target, $flag) = @_;
        if ($flag)
        {
          $target->seen("<self> begins to glow red hot!");
          $::fuses->current->{args}[1] = 0;
          1;
        } else
        {
          my $k = Attack->weapon(0, Dice->new(int($target->{weight} / 6)+1,4), $Adj::explosion, @{$target->{implies}});
          $target->seen("<self> explodes!");
          if (ref($target->{location}) eq 'Actor')
          {
            $target->{location}->hurt($k, $target, 'hands');
            $target->{location}->relieve($target);
          } elsif (ref($target->{location}) eq 'Region')
          {
            my $a = $target->{location}->actor_at($target->{x},$target->{y});
            $a->hurt($k, $target, 'feet') if defined $a;
            $target->{location}->relieve($target);
          }
          0;
        }
      }
END_FUSE
    }
  }
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    #return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) <= $self->{range}
    #                                       and $caster->dist($caster->{target}) > 1;
    # and has some appropriate unneeded fodder, eg stones?
    return 0;
END
);

$pixie_pyrotechnics = Talent->new('name'   => 'pixie pyrotechnics',
                              'type'       => 'spell',
                              'verbal'     => 1,
                              'somatic'    => 1,
                              'cost'       => 3,
                              'range'      => 4,
                              'on_perform' => <<'END',
  {
    my ($self, $target, $talent) = @_;
    my $q = $Item::bolt->make($Adj::fire);
    $q->{x} = $self->{x};
    $q->{y} = $self->{y};
    $q->{location} = $self->{location};
    my $a = $q->throw($target->{x}-$q->{x}, $target->{y}-$q->{y}, $talent->{range}, $self);
    my $i;
    for($i = 0; $i < 4; $i++)
    {
      my $b = $Item::rock->make($Adj::fire);
      $b->{x} = $q->{x};
      $b->{y} = $q->{y};
      $b->{location} = $q->{location};
      $b->{color} = Distribution->new(0.25 => 'sky',
                                      0.25 => 'pink',
                                      0.25 => 'lime',
                                      0.25 => 'yellow')->pick;
      $a = $b->throw(::d(1,7)-4, ::d(1,7)-4, $talent->{range}, $q);
      # todo: damage $a
    }
  }
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) <= $self->{range}
                                           and $caster->dist($caster->{target}) > 1;
    return 0;
END
);

$charm = Talent->new(        'name'       => 'charm',
                             'type'       => 'spell',
                             'verbal'     => 1,
                             'somatic'    => 1,
                             'cost'       => 6,
                             'range'      => 1,
                             'on_perform' => <<'END',
    my ($self, $target, $talent) = @_;
    if (ref($target) eq 'Actor' and defined $self->{party})
    {
      # if target is already in party, leave that party
      $self->{party}->add($target);
      $target->{target} = undef;
      # $target->{placid} += ::d(4,6);
      $self->seen($target, "<self> charms <other>!");
      return;
    }
    $self->seen($target, "<self> tries to charm <other> with no effect.");
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) == 1;
    return 0;
END
);

### UNDEAD

$laugh_of_insanity = Talent->new('name' => 'laugh of insanity',
                              'type'       => 'spell',
                              'verbal'     => 1,
                              'cost'       => 3,
                              'range'      => 1,
                       'on_perform'=> <<'END',
    my ($self, $target, $talent) = @_;
    $target->adjust('intelligence',0-::d(1,2),$self);
    $target->seen($self, "<self> is being driven insane by <other>'s laugh!");
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) == 1;
    return 0;
END
);

$drain_experience = Talent->new('name' => 'drain experience',
                              'type'       => 'spell',
                              'cost'       => 5,
                              'range'      => 1,
                       'on_perform'=> <<'END',
    my ($self, $target, $talent) = @_;
    if ($target->{experience} > 0)
    {
      $target->{experience} -= ::d(10,8);
      $target->{experience} = 0 if $target->{experience} < 0;
    } elsif ($#{$target->{talents}} > -1)
    {
      # degrade talents
    } else
    {
      # turn into juju zombie?
    }
    $self->seen($target, "<self> drains experience from <other>!");
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) == 1;
    return 0;
END
);

require "$::universe/Skills.pm";
require "$::universe/Poison.pm";

1;
