package Physical;
@ISA = qw( Cloneable Saveable Adj );

# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

use Carp;

# our $AUTOLOAD;  # it's a package global

# Things "every" physical object has:
# Actors, Terrain, (Vechile), Item, Talent

%fields =
(
  'name'           => 'untitled',
  'sex'            => 'Neuter',
  'plural'         => '',
  'identity'       => '',
  'pluralid'       => '',
  'proper'         => 0,

  'melee_attacks'      => undef, # array of Attack objects
  'projectile_attacks' => undef, # when thrown or launched

  'displayed'      => 0,
  'lightsource'    => 0,

  'opacity'        => 100,

  'count'          => 1,

  'lore'           => '',

  'weight'         => 1,
 #'aeroweight'     => undef,

  'indestructible' => 0,
  'durability'     => 1,
  'condition'      => 1,

  'resists'        => undef,
  'location'       => undef,
  'x'              => -1,
  'y'              => -1,
  'appearance'     => 'person',
  'color'          => 'grey',

  'on_strike'    => '',
  'on_struck'    => '',
);

sub dist
{
  my $self = shift;
  my $other = shift;
  return int(sqrt(($self->{x} - $other->{x}) * ($self->{x} - $other->{x}) +
                  ($self->{y} - $other->{y}) * ($self->{y} - $other->{y})));
}

sub in_bounds
{
  my $self = shift;
  my $x = shift || $self->{x};
  my $y = shift || $self->{y};
  my $location = shift || $self->{location};
  return (($x >= 0) and ($y >= 0) and ($x < $location->{sizex}) and ($y < $location->{sizey}));
}

sub plural
{
  my $self = shift;
  if ($self->{plural} ne '')
  {
    return $self->{plural};
  } else
  {
    return $self->{name} . "s";
  }
}

sub display
{
  my $self = shift;
  return if $::leader->{blind} or ($self ne $::leader and not $::leader->{lit});
  return if $self->{location} ne $::leader->{location};
  my $sx = $self->screenx;
  my $sy = $self->screeny;
  if ($sx > 0 and $sy > 0 and $sx < $::pref{map_width} and $sy < $::pref{map_height}
      and ($self->{location}{lit}[$self->{x}][$self->{y}] or $self eq $::leader))
  {
    # die("No " . $self->{appearance}) if not exists $::sc{$self->{appearance}};

    # return if $self ne $::leader and $self->dist($::leader) > 4;
    return if $self ne $::leader and not $::leader->los($self, 4);
    ::gotoxy($sx,$sy);
    if($self->{color} eq 'black')
    {
      ::color($self->{color}, 'grey');
    } else
    {
      ::color($self->{color}, 'black');
    }
    # ::color('red','magenta') if not $::leader->los($self, 4);
    ::display $::sc{$self->{appearance}};
    $self->{displayed} = 1;
    ::gotoxy($sx,$sy) if $self eq $::leader;
    $::notice = 1 if $self ne $::leader;
  }
}

sub undisplay
{
  my $self = shift;
  return if $::leader->{blind} or ($self ne $::leader and not $::leader->{lit});
  return if $self->{location} ne $::leader->{location};
  my $sx = $self->screenx;
  my $sy = $self->screeny;
  if ($sx > 0 and $sy > 0 and $sx < $::pref{map_width} and $sy < $::pref{map_height}
      and ($self->{location}{lit}[$self->{x}][$self->{y}] or
           (defined($::leader) and $self eq $::leader)))
  {
    return if $self ne $::leader and not $::leader->los($self, 4) and not $self->{displayed};
    ::gotoxy($sx,$sy);
    if ($self->{location}{lit}[$self->{x}][$self->{y}])
    {
      # die("No " . $self->{location}{map}[$self->{x}][$self->{y}][0]->{appearance}) if not exists $::sc{$self->{location}{map}[$self->{x}][$self->{y}][0]->{appearance}};
      ::color($self->{location}{map}[$self->{x}][$self->{y}][0]->{color}, 'black');
      ::display $::sc{$self->{location}{map}[$self->{x}][$self->{y}][0]->{appearance}};
    } else
    {
      ::display($::sc{dark});
    }
    $self->{displayed} = 0;
  }
}


%adj_table =
(
  'platinum' => [ 'white',  6.00, 2.75, Resistances->new($Adj::fire =>  0.10) ],
  'gold'     => [ 'yellow', 8.00, 2.25, Resistances->new($Adj::fire =>  0.05) ],
  'silver'   => [ 'grey',   5.00, 2.25, Resistances->new($Adj::fire =>  0.15) ],
  'copper'   => [ 'brown',  3.25, 2.75, Resistances->new($Adj::fire =>  0.20) ],
  'iron'     => [ 'aqua',   4.50, 4.00, Resistances->new($Adj::fire =>  0.25) ],
  'steel'    => [ 'blue',   4.00, 6.00, Resistances->new($Adj::fire =>  0.40) ],
  'meteoric-iron' =>
                [ 'sky',    3.75, 5.00, Resistances->new($Adj::fire =>  0.33) ],
  'bronze'   => [ 'brown',  3.00, 3.00, Resistances->new($Adj::fire =>  0.15) ],
  'lead'     => [ 'grey',   9.50, 3.50, Resistances->new($Adj::fire =>  0.05) ],
  'tin'      => [ 'grey',   5.50, 2.00, Resistances->new($Adj::fire =>  0.10) ],

  'wood'     => [ 'brown',  2.00, 2.00, Resistances->new($Adj::fire => -0.25) ],
  'holly'    => [ 'green',  0.20, 0.25, Resistances->new($Adj::fire => -0.50) ],
  'garlic'   => [ 'grey',   0.25, 0.25, Resistances->new($Adj::fire => -0.33) ],
  'mint'     => [ 'lime',   0.25, 0.25, Resistances->new($Adj::fire => -0.75) ],
  'leather'  => [ 'grey',   1.75, 1.75, Resistances->new($Adj::fire => -0.10) ],
  'fur'      => [ 'brown',  1.00, 1.00, Resistances->new($Adj::fire => -0.33) ],
  'silk'     => [ 'white',  0.80, 1.00, Resistances->new($Adj::fire => -0.25) ],
  'canvas'   => [ 'brown',  1.25, 1.50, Resistances->new($Adj::fire => -0.30) ],

  'mud'      => [ 'brown',  2.25, 0.75, Resistances->new($Adj::fire =>  0.25) ],
  'clay'     => [ 'red',    2.50, 1.50, Resistances->new($Adj::fire =>  0.25) ],
  'granite'  => [ 'grey',  12.00, 8.00, Resistances->new($Adj::fire =>  0.95) ],
  'marble'   => [ 'red',   16.00, 8.00, Resistances->new($Adj::fire =>  0.95) ],
  'opal'     => [ 'pink',   7.50, 4.00, Resistances->new($Adj::fire =>  0.95) ],
);

# only applies to unmaked things
sub make
{
  my $self = shift;
  my $n = $self->copy;
  my $a = shift;
  $n->{identity} = $a->{name} . ' ' . $self->{identity};
  $n->implies($a);

  # print $n->{identity}, ", ";
  $n->{melee_attacks}[0]{force}->implies($a); # PERHAPS NOT in the future
  $n->{color}  = $adj_table{$a->{name}}[0] || 'grey';
  $n->{weight}  = int (($adj_table{$a->{name}}[1] || 1) * $n->{weight} + .5);
  $n->{_defense} = int (($adj_table{$a->{name}}[2] || 0));  # times thickness??????????????????????????????????????????????????????

  # perhaps use alter_resistances; or maybe not...
  $n->{resists} = $adj_table{$a->{name}}[3];
  return $n;
}

sub color
{
  my $self = shift;
  $self->{color} = shift;
  return $self;
}

sub alter_resistances
{
  my $self = shift;
  my $element = shift;
  my $delta = shift;
  my $r = $self->{resists};
  $element = $element->{name} if ref($element) eq 'Adj';
  if (defined $r)
  {
    $r->{element}{$element} += $delta;
    my $i = 0; my @k;
    foreach $i (keys %{$r->{element}})
    {
      if ($r->{element}{$i} == 0)
      {
        push @k, $i;
      }
    }
    while (defined($i = shift @k))
    {
      delete $r->{element}{$i};
    }
  } else
  {
    $self->{resists} = Resistances->new($element => $delta);
  }
  $self->review('resistances') if ref($self) eq 'Actor';
}

sub hurt
{
  my $self = shift;
  my $attack = shift || carp "Need attack";
  my $other = shift || carp "Need other";
  my $part = shift || carp "Need body part";
  my $sky = shift || "";

  my $bonus = 0;
  my $armour;

  if (ref($other) eq 'Actor')
  {
    $bonus = int($other->{op}{strength} / 6) if $attack->{force}->is($Adj::kinetic);
  }
  elsif (ref($other) eq 'Talent')
  {
    $other = $other->{caster};
  }

  my $d = $attack->{force}->roll_against($self->{resists}, $bonus);
  my $orig = $d;

  if (ref($self) eq 'Actor')
  {
    $self->{totalhits}++;
  }

  # damage roll against should maybe come after armour, not before!

  my $ta = undef; my $fail = 0; my $armsky = '';

  if (ref($self) eq 'Actor')
  {
    $armour = $self->{$part};
    while (defined($armour) and ($armour->{name} eq 'nonexistant body part'))
    {
      if   ($part eq 'hands')     { $part = 'arms'; }
      elsif($part eq 'arms')      { $part = 'shoulders'; }
      elsif($part eq 'shoulders') { $part = 'torso'; }
      elsif($part eq 'head')      { $part = 'torso'; }
      elsif($part eq 'waist')     { $part = 'torso'; }
      elsif($part eq 'legs')      { $part = 'waist'; }
      elsif($part eq 'feet')      { $part = 'legs'; }
      elsif($part eq 'torso')     { $part = 'head'; }
      $armour = $self->{$part};
    }
  } else
  {
    $part = '';
  }

  if ($d <= 0 or $self->{indestructible})
  {
    $d = 0 if $d < 0;
    if ($part)
    {
      $other->seen($self, "<self> ${sky}$attack->{successverb} the $part of <other> with no effect.");
    } else
    {
      $other->seen($self, "<self> ${sky}$attack->{successverb} <other> with no effect.");
    }
  } else
  {
    if (defined $armour)
    {
      # roll against armour's coverage value
      my $ch = ::d(1,100);
      if ($ta = $self->has(Talent::armour_proficiency($part)))
      {
        # roll talent
        if (::d(1,100) <= $ta->{prof})
        {
          $self->seen("<self> uses <his> $ta->{name}!");
          # $armsky = "skillfully ";
          my $ch2 = ::d(1,100); $ch = $ch2 if $ch2 < $ch;
        }
      } else
      {
        $fail = 1;
      }
      # $other->seen($self, "<self> rolled $ch which must be below $self->{$part}{worn_on}{$self->{attached}{$part}}{$part} to hit armour...");
      if ($ch < $self->{$part}{worn_on}{$self->{attached}{$part}}{$part})
      {
        # damage armour as well?
        $d -= $self->{$part}->{_defense};
        if ($d < 0) { $d = 0; }
        if ($d == 0)
        {
          $other->seen($self, "<self> ${sky}$attack->{successverb} but hits the $self->{$part}->{name} on <other>'s $part. [$d]");
        } else
        {
          $other->seen($self, "<self> ${sky}$attack->{successverb} through the $self->{$part}->{name} on <other>'s $part! [$d]");
          ::script $attack->{on_strike}, $attack, $other, $self;
        }
        if ($ta and not $fail)
        {
          if(::d(1,100) <= $ta->{lesson})
          {
            $ta->{lesson} = 0;
            $ta->{prof}++;
            $self->review('talents');
            $self->seen("<self> gets a little more proficient at defending <him>self with <his> $self->{$part}->{name}.");
          }
        }
      } else
      {
        $other->seen($self, "<self> ${sky}$attack->{successverb} around the $self->{$part}->{name} on <other>'s $part! [$d]");
        ::script $attack->{on_strike}, $attack, $other, $self;
        if ($fail)
        {
          $ta->{lesson}++;
          $self->review('talents');
        }
      }
    } else
    {
      if ($part)
      {
        $other->seen($self, "<self> ${sky}$attack->{successverb} <other> in the $part! [$d]");
        ::script $attack->{on_strike}, $attack, $other, $self;
      } else
      {
        $other->seen($self, "<self> ${sky}$attack->{successverb} <other>! [$d]");
        ::script $attack->{on_strike}, $attack, $other, $self;
      }
    }
    if (ref($self) eq 'Actor')
    {
      $self->{blockedhits} += ($orig - $d);
      if (ref($other) eq 'Actor') { $other->{damagingswings} += $d; }
      $self->adjust('constitution', 0-$d, $other);
    } else
    {
      $self->{condition} -= $d;
      if ($self->{condition} <= 0)
      {
        $other->seen($self, "<self> has completely destroyed <other>.");
        if (ref($self->{location}) eq 'Region')
        {
          $self->{location}->relieve($self);
# shift @{$self->{location}{map}[$self->{x}][$self->{y}]};
#          $self->{location}->draw_cell($self->{x},$self->{y});
        }
        $self->{location} = undef;
      }
    }
  }
  if ($self eq $::leader or $other eq $::leader)
  {
    $::leader->review('character');
  }
  if (ref($self) eq 'Actor' and not defined $self->{target})
  {
    $self->{target} = $other;
  }
}

sub heal
{
  my $self = shift;
  my $damage = shift;
  # heal self
}

sub screenx
{
  my $self = shift;
  return $self->{x} - $self->{location}{offsetx} + 1;
}

sub screeny
{
  my $self = shift;
  return $self->{y} - $self->{location}{offsety} + 1;
}

sub accusative
{
  my $self = shift;
  if ($self->{sex} eq 'Male') { return "him"; }
  elsif ($self->{sex} eq 'Female') { return "her"; }
  return "it";
}

sub possessive
{
  my $self = shift;
  if ($self->{sex} eq 'Male') { return "his"; }
  elsif ($self->{sex} eq 'Female') { return "her"; }
  return "its";
}

# should use this, not ::msg directly.
sub seen
{
  my $self  = shift;
  my $other = shift;
  my $string; my $name = ''; my $proper = '';
  if (not ref $other)
  {
    $string = $other;
  } else
  {
    $string = shift;
    $name = $other->{name};
    $proper = $other->{proper};
    if (not $::leader->los($other, 4))
    {
      $other->{name} = 'something';
      $other->{proper} = 1;
    }
  }

  if ($self eq $::leader or $::leader->los($self, 4))
  {

# check $actor->count and $actor plural for like "Jeff attacks 3 berries!" or whatnot

    $string =~ s/^<self>/($self->{proper} ? "" : "The ") . $self->{name}/ge;
    $string =~ s/<self>/($self->{proper} ? "" : "the ")  . $self->{name}/ge;
    $string =~ s/^<other>/($other->{proper} ? "" : "The ") . $other->{name}/ge;
    $string =~ s/<other>/($other->{proper} ? "" : "the ")  . $other->{name}/ge;
    $string =~ s/^<a other>/($other->{proper} ? "" : "A ") . $other->{name}/ge;
    $string =~ s/<a other>/($other->{proper} ? "" : "a ")  . $other->{name}/ge;
    $string =~ s/<\# other>/$other->{count} > 1 ? $other->{count} . " " . $other->plural : "a " . $other->{name}/ge;
    $string =~ s/<his>/$self->possessive/ge;
    $string =~ s/<him>/$self->accusative/ge;

    ::msg($string);
  }
  if (defined $other)
  {
    $other->{name} = $name;
    $other->{proper} = $proper;
  }
}

sub los
{
  my $self = shift;
  my $x = shift;
  my $y;
  my $r;
  my $s = ''; my $s1 = 0;
  if (ref $x)
  {
    $r = shift || carp "Need range";
    return 1 if ref($x) eq 'Talent' and ref($self) eq 'Actor' and $self->has($x);
    return 1 if $self eq $x or (ref($x) ne 'Talent' and defined $x->{location} and $x->{location} eq $self);
    return 0 if not defined $self->{location}
             or not defined $x->{location}
             or $self->{location} ne $x->{location};
    return 0 if $self->dist($x) > $r;
    # ::gotoxy($x->screenx, $x->screeny);
    # ::display('!'); sleep 1;
    $y = $x->{y}-$self->{y};
    $x = $x->{x}-$self->{x};
    $s1 = 1;
  } else
  {
    $y = shift || 0;
    $r = shift || carp "Need range";
  }
  $x = $x || 0;
  return 0 if not $self->in_bounds($self->{x}+$x, $self->{y}+$y);

  my ($xd, $yd);
  if (abs($x) < abs($y))
  {
    $xd = ($y ? (abs($x)/abs($y)) : 1) * ::sgn($x);
    $yd = ::sgn($y);
  } else
  {
    $xd = ::sgn($x);
    $yd = ($x ? (abs($y)/abs($x)) : 1) * ::sgn($y);
  }
  my $xc = $self->{x};
  my $yc = $self->{y};
  my $impetus = $r;

  while((int($xc+.5) != $self->{x}+$x or int($yc+.5) != $self->{y}+$y)
              and ($impetus > 0))
  {
    my $t = $self->{location}->get_terrain(int($xc+.5), int($yc+.5));
    #if ($s1)
    #{
    #  ::gotoxy(int($xc+.5) - $self->{location}{offsetx} + 1,
    #           int($yc+.5) - $self->{location}{offsety} + 1);
    #  ::color('sky','blue');
    #  ::display('+');
    #}
    if ($t->{opacity} == 100 or ($t->{opacity} != 0 # and (not $self->{location}{lit}[int($xc+.5)][int($yc+.5)])
        and $t->{opacity} >= ::d(1,100))) # opaque
    {
      # ::msg($s) if $s1;
      return 0;
    }
    $xc += $xd;
    $yc += $yd;
    $impetus--;
  }
  # ::msg($s) if $s1;
  return 1;
}

sub throw
{
  my $q = shift;  # should be "self"
  my $x = shift;  # relative
  my $y = shift;
  my $r = shift;
  my $thrower = shift;
  my ($xd, $yd, $a);

  if (abs($x) < abs($y))
  {
    $xd = ($y ? (abs($x)/abs($y)) : 1) * ::sgn($x);
    $yd = ::sgn($y);
  } else
  {
    $xd = ::sgn($x);
    $yd = ($x ? (abs($y)/abs($x)) : 1) * ::sgn($y);
  }

  my $xc = $thrower->{x};
  my $yc = $thrower->{y};

  my $impetus = $r;

  while((int($xc+.5) != $thrower->{x}+$x or int($yc+.5) != $thrower->{y}+$y)
              and ($impetus > 0))
  {
    my $t = $thrower->{location}->get_terrain(int($xc+.5), int($yc+.5));
    last if not $t->allows($q);
    my $a = $thrower->{location}->actor_at(int($xc+.5), int($yc+.5));
    last if (defined $a and $a ne $thrower); # with respect to thing thrown
    unshift @{$thrower->{location}{map}[int($xc+.5)][int($yc+.5)]}, $q;
    $q->{x} = int($xc+.5);
    $q->{y} = int($yc+.5);
    if (int($xc+.5) != $thrower->{x} or int($yc+.5) != $thrower->{y})
    {
      $thrower->{location}->draw_cell(int($xc+.5), int($yc+.5));
      sleep 1 if $::pref{throwspeed} eq 'slow';
      if ($::pref{throwspeed} eq 'medium')
      {
        my $i;
        for($i = 0; $i < 100; $i++)
        {
          $thrower->{location}->draw_cell(int($xc+.5), int($yc+.5));
        }
      }
      shift @{$thrower->{location}{map}[int($xc+.5)][int($yc+.5)]};
      $thrower->{location}->draw_cell(int($xc+.5), int($yc+.5));
    } else
    {
      shift @{$thrower->{location}{map}[int($xc+.5)][int($yc+.5)]};
    }
    $xc += $xd;
    $yc += $yd;
    $impetus--;
  }
  $q->{x} = int($xc+.5);
  $q->{y} = int($yc+.5);
  my $t = $thrower->{location}->get_terrain(int($xc+.5), int($yc+.5));
  if (not $t->allows($q))
  {
    $xc -= $xd;
    $yc -= $yd;
    $q->{x} = int($xc+.5);
    $q->{y} = int($yc+.5);
    $q->seen($t, "<self> bounces off of <other> and falls to the ground.");
  }
  return $thrower->{location}->actor_at(int($xc+.5), int($yc+.5));
}

1;
