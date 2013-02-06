# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see file LICENSE for more info.

package Talent;

### SPELL CONSTRUCTORS ###

# NOTE NOTE NOTE NOTE NOTE NOTE NOTE
# $self might be an Actor *or* an Item!
# $target could be anything!

sub create_ring
{
  my $what = shift;
  my $self = Talent->new('name'      => "create ring of $what->{name}",
                         'what'      => $what,
                         'type'      => 'spell',
                         'verbal'    => 1,
                         'somatic'   => 1,
                         'cost'      => 6,
                         'range'     => 6,
                         'on_perform'=> <<'END',
    my ($self, $target, $talent) = @_;
    my $xd; my $yd;
    for ($xd = -1; $xd <= 1; $xd++)
    {
      for ($yd = -1; $yd <= 1; $yd++)
      {
        if (not ($xd == 0 and $yd == 0))
        {
          my $q = $talent->{what}->clone;
          $q->{location} = $self->{location};
          $q->{x} = $target->{x}+$xd;
          $q->{y} = $target->{y}+$yd;
          unshift @{$self->{location}{map}[$target->{x}+$xd][$target->{y}+$yd]}, $q
            if $self->in_bounds($target->{x}+$xd,$target->{y}+$yd);
          $self->{location}->draw_cell($target->{x}+$xd,$target->{y}+$yd);
        }
      }
    }
    $self->seen($target, "<self> creates a ring of $talent->{what}{name}s around <other>!");
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) <= $self->{range};
    return 0;
END
                        );
  return $self;
}

sub create_cloud
{
  my $what = shift;
  my $self = Talent->new('name'      => "create cloud of $what->{name}",
                         'what'      => $what,
                         'type'      => 'spell',
                         'verbal'    => 1,
                         'somatic'   => 1,
                         'cost'      => 6,
                         'range'     => 6,
                         'on_perform'=> <<'END',
    my ($self, $target, $talent) = @_;
    my $xd; my $yd; my $eg;
    for ($xd = -3; $xd <= 3; $xd++)
    {
      for ($yd = -3; $yd <= 3; $yd++)
      {
        my $q = $talent->{what}->clone;
        $q->{location} = $self->{location};
        $q->{x} = $target->{x}+$xd;
        $q->{y} = $target->{y}+$yd;
        next if $target->dist($q) > 3;
        $self->{location}{lit}[$q->{x}][$q->{y}] = 0;
        if (not $self->{location}->get_terrain($q->{x},$q->{y})->is($Adj::wall)
            and $self->in_bounds($q->{x},$q->{y}))
        {
          unshift @{$self->{location}{map}[$q->{x}][$q->{y}]}, $q;
          $self->{location}->draw_cell($q->{x},$q->{y});
          $::fuses->add(<<'END_FUSE', ::d(5,6), [$q], 'cloud');
          {
            my ($target) = @_;
            $target->seen("<self> dissipates.");
            shift @{$target->{location}{map}[$target->{x}][$target->{y}]};
#              if $#{$target->{location}{map}[$target->{x}][$target->{y}]} > 0;
            $target->{location}->draw_cell($target->{x},$target->{y});
            0;
          }
END_FUSE
        }
        $eg = $q;
      }
    }
    $self->seen($eg, "<self> creates clouds of <other>!");
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) <= $self->{range};
    return 0;
END
                        );
  return $self;
}

sub create
{
  my $what = shift;
  my $self = Talent->new('name'      => "create $what->{name}",
                         'what'      => $what,
                         'type'      => 'spell',
                         'verbal'    => 1,
                         'somatic'   => 1,
                         'cost'      => 4,
                         'range'     => 6,
                         'on_perform'=> <<'END',
    my ($self, $target, $talent) = @_;
    my $q = $talent->{what}->clone;
    $q->{location} = $self->{location};
    $q->{x} = $target->{x};
    $q->{y} = $target->{y};
    unshift @{$self->{location}{map}[$target->{x}][$target->{y}]}, $q
      if $self->in_bounds($target->{x}+$xd,$target->{y}+$yd);
    $self->{location}->draw_cell($target->{x},$target->{y});
    $self->seen($talent->{what}, "<self> creates <a other>.");
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) <= $self->{range};
    return 0;
END
                        );
  return $self;
}

$cause_table =
{
  'blind'     => ['blindness',     'blinded'],
  'deaf'      => ['deafness',      'deafened'],
  'dumb'      => ['dumbness',      'struck dumb'],
  'placid'    => ['placidity',     'pacified'],
  'confused'  => ['confusion',     'confused'],
  'paralyzed' => ['paralysis',     'paralyzed'],
};

sub cause
{
  my $what = shift;
  carp "Need effect, not $what" if not defined $cause_table->{$what};
  my $num  = shift;
  carp 'Need dice' if ref($num) ne 'Dice';
  my $self = Talent->new('name'      => "cause $Talent::cause_table->{$what}[0]",  # $num->{count}d$num->{faces} 
                         'what'      => $what,
                         'num'       => [$num],   # not the best way to do it, but it works for now
                         'type'      => 'prayer',
                         'moves'     => 3,
                         'verbal'    => 1,
                         'somatic'   => 1,
                         'cost'      => 1,
                         'range'     => 1,
                         'on_perform'=> <<'END',
  {
    my ($self, $target, $talent) = @_;
    my $what = $talent->{what} || "confused";
    $target->{$what} += $talent->{num}[0]->roll;
    $target->review('character');
    $target->seen($self, "<self> is $Talent::cause_table->{$what}[1] by <other>!");
  }
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) <= $self->{range};
    return 0;
END
                        );
  return $self;
}

sub cure
{
  my $what = shift;
  carp 'Need effect' if not defined $what;
  # my $num  = shift;
  # carp 'Need dice' if ref($num) ne 'Dice';
  my $self = Talent->new('name'      => "cure $cause_table->{$what}[0]",  # $num->{count}d$num->{faces} 
                         'what'      => $what,
                         # 'num'       => [$num],   # not the best way to do it, but it works for now
                         'type'      => 'prayer',
                         'moves'     => 3,
                         'verbal'    => 1,
                         'somatic'   => 1,
                         'cost'      => 1,
                         'range'     => 1,
                         'on_perform'=> <<'END',
  {
    my ($self, $target, $talent) = @_;
    $target->{$talent->{what}} = 0;
    $target->review('status');
    $target->{location}->display($target) if $target eq $::leader;
    $target->seen($self, "<self>'s $cause_table->{$what}[1] is cured by <other>!");
  }
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    # much more complex than 'cause'
    # return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) <= $self->{range};
    return 0;
END
                        );
  return $self;
}

sub polymorph
{
  my $what = shift;
  carp 'Need actor' if ref($what) ne 'Actor';
  my $num  = shift;
  carp 'Need dice' if ref($num) ne 'Dice';
  my $self      = Talent->new('name'       => 'polymorph into ' . $what->{name},
                              'type'       => 'spell',
                              'what'       => $what,
                              'num'        => [$num],
                              'verbal'     => 1,
                              'somatic'    => 1,
                              'cost'       => 9,
                              'range'      => 4,
                              'on_perform' => <<'END',
  {
    my ($self, $target, $talent) = @_;
    my $c = $talent->{what}->clone;
    my $original = { %{$target} };
    $c->prep;
    $target->{max} = $c->{max};
    $target->{op} = $c->{op};
    $target->{race} = $c->{race};
    $target->{sex} = $c->{sex};
    $target->{appearance} = $c->{appearance};
    $target->{color} = $c->{color};
    # todo: copy resistances, attack forms, body armor, innate talents
    # every appearance except eye colour    

    $target->seen("<self> turns into a $c->{name}!");

    $::fuses->add(<<'END_FUSE', $talent->{num}[0]->roll, [$target, $original], 'morph');
    {
      my ($target, $original) = @_;
      $target->{max} = $original->{max};
      $target->{op} = $original->{op};
      $target->{race} = $original->{race};
      $target->{sex} = $original->{sex};
      $target->{appearance} = $original->{appearance};
      $target->{color} = $original->{color};
      $target->seen($original, "<self> turns back into <his> former self.");
      $target->review();
      0;
    }
END_FUSE
    $target->review();
  }
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) <= $self->{range};
    return 0;
END
);
  return $self;
}

sub resist
{
  my $what = shift;
  carp 'Need adjectival' if ref($what) ne 'Adj';
  my $num  = shift;
  carp 'Need dice' if ref($num) ne 'Dice';
  my $self      = Talent->new('name'       => 'resist ' . $what->{name},
                              'type'       => 'spell',
                              'what'       => [$what],
                              'num'        => [$num],
                              'verbal'     => 1,
                              'somatic'    => 1,
                              'cost'       => 3,
                              'range'      => 4,
                              'on_perform' => <<'END',
  {
    my ($self, $target, $talent) = @_;
    $target->seen($self, "<self> becomes more $talent->{what}[0]{name}-resistant thanks to <other>'s enchantment!");
    my $r = $target->{resists};
    if (defined $r)
    {
      $target->{resists}{element}{$talent->{what}[0]{name}} += 0.75;
    } else
    {
      $target->{resists} = Resistances->new($talent->{what}[0]{name} => 0.75);
    }
    $::fuses->add(<<'END_FUSE', $talent->{num}[0]->roll, [$target, $talent], 'resist');
    {
      my ($target, $talent) = @_;
      $target->seen($target, "<self> loses <his> resistance to $talent->{what}[0]{name}.");
      $target->{resists}{element}{$talent->{what}[0]{name}} -= 0.75;
      $target->{resists}->remove_resistances;
      $target->review('resistances');
      0;
    }
END_FUSE
    $target->review('resistances');
  }
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    # return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) <= $self->{range};
    return 0;
END
);
  return $self;
}

# transmute x to y

### ATTACK CONSTRUCTORS

sub touch
{
  my $what = shift;
  carp 'Need adjectival' if ref($what) ne 'Adj';
  my $num  = shift;
  carp 'Need dice' if ref($num) ne 'Dice';
  my $self      = Talent->new('name'       => 'touch of ' . $what->{name},
                              'type'       => 'spell',
                              'what'       => [$what],
                              'num'        => [$num],
                              'verbal'     => 1,
                              'somatic'    => 1,
                              'cost'       => 2,
                              'range'      => 1,
                              'on_perform' => <<'END',
  {
    my ($self, $target, $talent) = @_;
    # to to-hit roll, make into subroutine, actor->hitroll or something
    my $a = Attack->new('attemptverb' => 'tries to touch',
                        'successverb' => 'touches',
                        'force' => Force->new($talent->{num}[0], $Adj::flesh, $talent->{what}[0]));
    $self->seen($target, "<self> touches <other> and delivers $talent->{what}[0]{name} damage!");
    $target->hurt($a, $self, 'torso');
    $target->review('character');
  }
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) <= $self->{range};
    return 0;
END
);
  return $self;
}

sub bolt
{
  my $what = shift;
  carp 'Need adjectival' if ref($what) ne 'Adj';
  my $num  = shift;
  carp 'Need dice' if ref($num) ne 'Dice';
  my $self      = Talent->new('name'       => 'bolt of ' . $what->{name},
                              'type'       => 'spell',
                              'what'       => [$what],
                              'num'        => [$num],
                              'verbal'     => 1,
                              'somatic'    => 1,
                              'cost'       => 2,
                              'range'      => 4,
                              'on_perform' => <<'END',
  {
    my ($self, $target, $talent) = @_;
    $q = $Item::bolt->make($talent->{what}[0]);
    $q->{x} = $self->{x};
    $q->{y} = $self->{y};
    $q->{location} = $self->{location};
    $self->seen($q, "<self> hurls <a other>!");

    my $a = $q->throw($target->{x}-$q->{x}, $target->{y}-$q->{y}, $talent->{range}, $self);

    if (defined $a)
    {
      my $targ = 60;
      $targ = $a->{op}{dexterity} + 1 if $a->{op}{dexterity} > $targ;
      if ($a->{op}{dexterity} > ::d(1,$targ))
      {
        $a->seen($q, "<self> avoids being hit by <other>.");
      } elsif ($a ne $self)
      {
        my %tab = (
                    'fire'  => 'burns',
                    'cold'  => 'freezes',
                    'water' => 'drenches',
                  );
        my $v = $tab{$talent->{what}[0]{name}} || "blasts with $talent->{what}[0]{name}";
        my $k = Attack->new('attemptverb' => "blasts $talent->{what}[0]{name} towards",
                            'successverb' => $v,
                            'force' => Force->new($talent->{num}[0], $talent->{what}[0]));
        $a->hurt($k, $self, $Distribution::bp{random}->pick);
        $a->review('character');
      }
    }
  }
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) <= $self->{range};
    return 0;
END
);
  return $self;
}

sub sphere
{
  my $what = shift;
  carp 'Need adjectival' if ref($what) ne 'Adj';
  my $num  = shift;
  carp 'Need dice' if ref($num) ne 'Dice';
  my $self      = Talent->new('name'       => 'sphere of ' . $what->{name},
                              'type'       => 'spell',
                              'what'       => [$what],
                              'num'        => [$num],
                              'verbal'     => 1,
                              'somatic'    => 1,
                              'cost'       => 2,
                              'range'      => 6,
                              'on_perform' => <<'END',
  {
    my ($self, $target, $talent) = @_;
    # do explosion animation, make into subroutine, $physical->explode or something
    my $a = Attack->new('attemptverb' => 'nearly engulfs',
                        'successverb' => 'engulfs',
                        'force' => Force->new($talent->{num}[0], $talent->{what}[0]));
    $self->seen($target, "<self> engulfs <other> with $talent->{what}[0]{name}!");
    $target->hurt($a, $self, 'torso');
    $target->review('character');
  }
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) <= $self->{range};
    return 0;
END
);
  return $self;
}

sub detect
{
  my $what = shift;
  carp 'Need adjectival' if ref($what) ne 'Adj';
  my $self      = Talent->new('name'       => 'detect ' . $what->{name},
                              'type'       => 'spell',
                              'what'       => [$what],
                              'verbal'     => 1,
                              'somatic'    => 1,
                              'cost'       => 2,
                              'range'      => 0,
                              'on_perform' => <<'END',
  {
    my ($self, $target, $talent) = @_;
    my $c = 0;
    my $xd; my $yd; my $zd;
    for ($xd = -8; $xd <= 8; $xd++)
    {
      for ($yd = -8; $yd <= 8; $yd++)
      {
        next if int(sqrt($xd*$xd+$yd*$yd)) > 8 or not $self->in_bounds($self->{x}+$xd,$self->{y}+$yd);
        $self->{location}->gel($self->{x}+$xd,$self->{y}+$yd);
        my $q = $self->{location}->get_top($self->{x}+$xd,$self->{y}+$yd);
        if ($q->is($talent->{what}[0]))
        {
          my $lit = $self->{location}{lit}[$self->{x}+$xd][$self->{y}+$yd];
          $self->{location}{lit}[$self->{x}+$xd][$self->{y}+$yd] = 1;
          $self->{location}->draw_cell($self->{x}+$xd,$self->{y}+$yd, $lit);
          $c++;
        }
      }
    }
    if ($c)
    {
      $self->seen("<self> senses the presence of $talent->{what}[0]{name}!");
    } else
    {
      $self->seen("<self> senses no $talent->{what}[0]{name} at present.");
    }
  }
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 0;
END
);
  return $self;
}

# if target is deaf, they should automatically avoid

sub songof
{
  my $self = shift;
  my $inst = shift || carp "Need instrument";
  my $n = $self->copy;
  $n->{name} = "song of " . $n->{name} . " (" . $inst->{name} . ")";
  $n->{material} = undef;
  $n->{consumed} = undef;
  $n->{verbal} = 1;
  $n->{musical} = 1;
  $n->{somatic} = 0;
  $n->{instrument} = [ $inst ];
  return $n;
}

sub summon
{
  my $what = shift;
  carp 'Need actor' if ref($what) ne 'Actor';
  my $num  = shift;
  carp 'Need dice' if ref($num) ne 'Dice';
  my $self = Talent->new('name'      => "summon $what->{name}s",  # $num->{count}d$num->{faces} 
                         'what'      => $what,
                         'num'       => [$num],   # not the best way to do it, but it works for now
                         'type'      => 'spell',
                         'verbal'    => 1,
                         'somatic'   => 1,
                         'cost'      => 9,
                         'range'     => 5,
                         'on_perform'=> <<'END',
    my ($self, $target, $talent) = @_;
    my $num = $talent->{num}->[0]->roll;
    if (ref($target) ne 'Actor') { $target = $self; } # eep!
    # $self->seen('', " summons $num " , $talent->{what}, 's!');
    my $s; my $i; for($i=0; $i<$num; $i++)
    {
      $s = $talent->{what}->clone;
      $s->prep;
      $s->{target} = $target;
      $target->{location}->enter($s, $target);
    }
    $target->seen($self, "<self> is surrounded by <other>'s $talent->{what}->{name}s!");
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) <= $self->{range};
    return 0;
END
                        );
  return $self;
}

1;
