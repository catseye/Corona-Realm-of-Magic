package Actor;
@ISA = qw( Physical );

# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

use Carp;

# our $AUTOLOAD;  # it's a package global

%stat =
(
  'strength'     => 1,
  'constitution' => 1,
  'dexterity'    => 1,
  'intelligence' => 1,
  'spirit'       => 1,
  'charisma'     => 1,
);
$sorder =
[
  'strength',
  'constitution',
  'dexterity',
  'intelligence',
  'spirit',
  'charisma',
];
my %fields =
(
  %Physical::fields,
  'hair_type'      => '',
  'hair_color'     => 'unremarkable',
  'eye_type'       => '',
  'eye_color'      => 'unremarkable',
  'skin_type'      => '',
  'skin_color'     => 'unremarkable',
  'character_bio'  => undef,

  'race'           => 'Unique',
  'carcass'        => 1,

  'lit'            => 0,  # value *derived* from holding light source
  'incapacitated'  => 0,  # value *derived* from operating stats

  'using_talent'   => undef,  # when like [13, $talent, $target], means slow talent is being used

  'blind'          => 0,
  'deaf'           => 0,
  'dumb'           => 0,
  'confused'       => 0,
  'paralyzed'      => 0,
  'placid'         => 0,
  'blurry'         => 0,

  'nightvision'    => 0,

  'sleeping'       => 0,
  
  'totalhits'      => 0,
  'blockedhits'    => 0,
  'totalswings'    => 0,
  'damagingswings' => 0,

  'party'          => undef,
  'encounter'      => undef,

  'combat'         => 'Attack',  # some creatures will Flee or Bargain instead
  'noncombat'      => 'Wander',
  'body_aim'       => 'dumb_biped',

  'max'            => { %stat },
  'op'             => { %stat },

  'experience'       => 0,
  'spent_experience' => 0,
  'standing'         => {},

  'belongings'     => [],
  'talents'        => [],

  'target'         => undef,

  'head'           => undef,
  'neck'           => undef,
  'shoulders'      => undef,
  'arms'           => undef,
  'rwrist'         => undef,
  'lwrist'         => undef,
  'hands'          => undef,
  'rfinger'        => undef,
  'lfinger'        => undef,
  'rhand'          => undef,
  'lhand'          => undef,
  'torso'          => undef,
  'waist'          => undef,
  'legs'           => undef,
  'rankle'         => undef,
  'lankle'         => undef,
  'feet'           => undef,

  'domhand'        => 'rhand',
  'ambidextrous'   => 0,       # 1 means can control the above
  'on_move'        => '',
);

sub new
{
  my $class = shift;
  my %params = @_;
  my $self =
  {
    '_permitted' => \%fields,
    %fields,
    'standing'       => {},
    'belongings'     => [],
    'talents'        => [],
    'max'            => { %stat },
    'op'             => { %stat },
    %params
  };
  bless $self, $class;
  $self->heal_all;
  $self->recalc_lit;
  return $self;
}

require Character;

# called after constructor to ensure proper sexualization,
# wielding items (even magicked ones,) etc.
sub prep
{
  my $self = shift;

  # adjust character for gender bonuses

  $self->sexualize;

  # clone out individual attacks array

  my $y; my @e = ();
  foreach $y (@{$self->{melee_attacks}})
  {
    my $q = $y->clone;
    $q->{force} = $y->{force}->copy;
    push @e, $q;
  }
  $self->{melee_attacks} = [ @e ] if $#e > -1;

  #@e = ();
  #foreach $y (@{$self->{projectile_attacks}})
  #{
  #  push @e, $y->clone;
  #}
  #$self->{projectile_attacks} = [ @e ] if $#e > -1;

  # swap contents of lhand and rhand if nonweapon is in dominant hand

  my $d = $self->{domhand};
  if ($d eq 'ambi')
  {
    $self->{ambidextrous} = 1;
    $d = $self->{domhand} = 'rhand';
  }
  $nd = 'rhand' if $d eq 'lhand';
  $nd = 'lhand' if $d eq 'rhand';

  if (defined $self->{$d})
  {
    if (defined $self->{$nd})
    {
      if ($self->{$d}{melee_attacks}[0]{force}->max <
          $self->{$nd}{melee_attacks}[0]{force}->max)
      {
        my $t = $self->{$d};
        $self->{$d} = $self->{$nd};
        $self->{$nd} = $t;
      }
    }
  } else
  {
    if (defined $self->{$nd})
    {
      $self->{$d} = $self->{$nd};
      $self->{$nd} = undef;
    }
  }

  # activate worn magic items (girdles of strength and so on)

  my $i;
  foreach $i (keys %{$wtable})
  {
    if (defined $self->{$wtable->{$i}[0]})
    {
      # ::msg($self->{$wtable->{$i}[0]}{name});
      $self->{$wtable->{$i}[0]} = $self->{$wtable->{$i}[0]}->clone;
      ::script $self->{$wtable->{$i}[0]}{on_wear}, $self->{$wtable->{$i}[0]}, $self, 1;
    }
  }

  # instance any belongings which are not yet Items (i.e. Distributions)

  my @q = ();
  foreach $i (@{$self->{belongings}})
  {
    if (ref($i) eq 'Distribution')
    {
      while (ref($i) eq 'Distribution')
      {
        $i = $i->pick;
      }
      push @q, $i->clone if defined $i;
    } else
    {
      push @q, $i->clone if defined $i;
    }
  }
  $self->{belongings} = [ @q ];

  # clone out talents

  @q = ();
  foreach $i (@{$self->{talents}})
  {
    if (ref($i) eq 'Distribution')
    {
      while (ref($i) eq 'Distribution')
      {
        $i = $i->pick;
      }
      push @q, $i->clone if defined $i;
    } else
    {
      push @q, $i->clone if defined $i;
    }
  }
  $self->{talents} = [ @q ];

  # anything else appropriate to newly created creatures

  $self->heal_all;

  return;
}

sub heal_all
{
  my $self = shift; my $k;
  foreach $k (keys %{$self->{max}})
  {
    $self->{op}{$k} = $self->{max}{$k};
  }
}

sub adjust
{
  my $self = shift;
  my $stat = shift;
  my $delta = shift;
  my $causer = shift || carp "Need cause";
  if (defined $delta and $delta != 0)
  {
    if ($self->{op}{$stat} + $delta <= 0 and $self->{op}{$stat} > 0)
    {
      $self->{op}{$stat} = 0;
      $self->seen($self, "<self> is incapacitated by the loss of all of <his> $stat!") if not $self->{incapacitated};
      $self->{incapacitated} = 1;
      $self->review('character');
    } elsif ($self->{op}{$stat} + $delta <= 0 and $self->{op}{$stat} == 0)
    {
      $self->death($causer);
    } else
    {
      $self->{op}{$stat} += $delta;
      # $self->{op}{$stat} = 0
      #   if $stat ne 'constitution' and $self->{op}{$stat} < 0;
      $self->review('character');
    }
  }
}

# given Item or Talent, returns boolean indicating whether
# this actor possesses it; in case of count of Items, the
# actor must possess at least that many
# given Adj, return first item which implies that Adj
sub has
{
  my $self = shift;
  my $thing = shift;

  if (ref($thing) eq 'Item')
  {
    my $x;
    foreach $x (@{$self->{belongings}})
    {
      if ($thing->combinable($x) and $x->{count} >= $thing->{count})
      {
        return $x;
      }
    }
  }
  elsif (ref($thing) eq 'Adj')
  {
    my $x;
    foreach $x (@{$self->{belongings}})
    {
      if ($x->is($thing))
      {
        return $x;
      }
    }
  }
  elsif (ref($thing) eq 'Talent' or not ref($thing))
  {
    my $x;
    my $n = $thing;
    $n = $thing->{name} if ref($thing);
    foreach $x (@{$self->{talents}})
    {
      return $x if $n eq $x->{name};
    }
  }
  return 0;
}

sub learn
{
  my $self = shift;
  my $talent = shift;
  my $prof = shift;
  carp "Need proficiency level" if not defined $prof;

  my $t = undef;

  if (ref($talent) eq 'Talent')
  {
    if ($t = $self->has($talent))
    {
      $t->{prof} += $prof;
      if ($t->{prof} <= 0)
      {
        $t->{prof} = 0;
        my $i = 0;
        for($i = 0; $i <= $#{$self->{talents}}; $i++)
        {
          last if not defined $self->{talents}[$i];
          if ($self->{talents}[$i]{prof} <= 0)
          {
            my $j;
            # print "deleting $self->{talents}[$i]{name}"; sleep 2;
            for($j = $i+1; $j <= $#{$self->{talents}}; $j++)
            {
              $self->{talents}[$j-1] = $self->{talents}[$j];
            }
            $#{$self->{talents}}--;
            $i--;
          }
        }
      }
    } else
    {
      if ($#{$self->{talents}} == -1)
      {
        $self->{talents} = [];
      }
      $t = $talent->clone;
      $t->{owner} = $self;
      $t->{prof} = $prof;
      push @{$self->{talents}}, $t;
    }
    $self->review('talents');
  }
  return $t;
}

sub take
{
  my $self = shift;
  my $item = shift;
  if (ref($item) eq 'Item')
  {
    my $x;
    foreach $x (@{$self->{belongings}})
    {
      if ($item->combinable($x))
      {
        $x->{count} += $item->{count};
        $self->review('inventory');
        return;
      }
    }
    push @{$self->{belongings}}, $item;
    $item->{x} = -1;
    $item->{y} = -1;
    $item->{location} = $self;
  } else { carp "Need item I think!" }
  $self->review('inventory');
}

sub pickup
{
  my $self = shift;
  my $thing = $self->{location}{map}[$self->{x}][$self->{y}][0];
  if (ref($thing) ne 'Item')
  {
    $self->seen($thing, "<self> finds nothing on <other>.");
    return 0;
  }
  shift @{$self->{location}{map}[$self->{x}][$self->{y}]};
  if ($thing->{count} > 1)
  {
    $self->seen($thing, "<self> picks up <# other>.");
  } else
  {
    $self->seen($thing, "<self> picks up <a other>.");
  }
  if (::script $thing->{on_pickup}, $thing, $self)
  {
    $self->take($thing);
  }
  return 1;
}

sub relieve
{
  my $self = shift;
  my $thing = shift;
  my $j = 0;
  while ($j <= $#{$self->{belongings}})
  {
    if ($thing eq $self->{belongings}[$j])
    {
      my $k = $j;
      for($k = $j; $k < $#{$self->{belongings}}; $k++)
      {
        $self->{belongings}[$k] = $self->{belongings}[$k+1];
      }
      $#{$self->{belongings}}--;
      last;
    }
    $j++;
  }
  $self->review('inventory');
}

sub drop
{
  my $self = shift;
  my $thing = shift;
  $thing->{x} = $self->{x};
  $thing->{y} = $self->{y};
  $thing->{location} = $self->{location};
  unshift @{$self->{location}{map}[$self->{x}][$self->{y}]}, $thing;
}

$wtable = 
{
  'Head'      => ['head',      'head'],
  'Neck'      => ['neck',      'neck'],
  'Shoulders' => ['shoulders', 'shoulders'],
  'Arms'      => ['arms',      'arms'],
  'R.Wrist'   => ['rwrist',    'bracelet'],
  'L.Wrist'   => ['lwrist',    'bracelet'],
  'Hands'     => ['hands',     'hands'],
  'R.Finger'  => ['rfinger',   'ring'],
  'L.Finger'  => ['lfinger',   'ring'],
  'R.Hand'    => ['rhand',     'hand'],
  'L.Hand'    => ['lhand',     'hand'],
  'Torso'     => ['torso',     'torso'],
  'Waist'     => ['waist',     'waist'],
  'Legs'      => ['legs',      'legs'],
  'R.Ankle'   => ['rankle',    'bracelet'],
  'L.Ankle'   => ['lankle',    'bracelet'],
  'Feet'      => ['feet',      'feet'],
};

$worder = 
[
  'Head',
  'Neck',
  'Shoulders',
  'Arms',
  'R.Wrist',
  'L.Wrist',
  'Hands',
  'R.Finger',
  'L.Finger',
  'R.Hand',
  'L.Hand',
  'Torso',
  'Waist',
  'Legs',
  'R.Ankle',
  'L.Ankle',
  'Feet',
];

sub recalc_lit
{
  my $self = shift;
  my $j; my $l = 0;
  for($j = 0; $j <= $#{$worder}; $j++)
  {
    my $method = $wtable->{$worder->[$j]}->[0];
    my $r = $self->{$method};
    if (defined $r) { $l = 1 if $r->{lightsource}; }
  }
  $self->{lit} = $l || $self->{nightvision};
}

# returns false if action could not be accomplished
sub put_on
{
  my $self = shift;
  my $item = shift;
  my $method = shift;
  my $init_equip = shift || 0;
  my $old;

  if ($item->{count} > 1)
  {
    $old = $item;
    $item = $item->clone;
    $old->{count}--;
    $item->{count} = 1;
  } else
  {
    $self->relieve($item);
  }

  my $k;
  foreach $k (keys %{$item->{worn_on}{$method}})
  {
    if (defined $self->{$k})
    {
      if ($init_equip)
      {
        $self->take($item);
        return 1;
      } else
      {
        $self->seen($self->{$k}, "<self> will have to remove <other> first.");
        return 0;
      }
    }
    $self->{$k} = $item;
    $self->{attached}{$k} = $method;
  }

  $self->recalc_lit;
  if (exists $item->{on_wear})
  {
    ::script $item->{on_wear}, $item, $self, 1;
  }
  $item->{x} = -1;
  $item->{y} = -1;
  $item->{location} = $self;
  $item->identify;

  return 1;
}

# returns item taken off
sub take_off
{
  my $self = shift;
  my $method = shift;
  my $force = shift || 0;
  $method = $self->{attached}{$method} if defined $self->{attached}{$method};
  my $item = $self->{$method};
  if (not ($item->{curse} and not $force))
  {
    my $k;
    foreach $k (keys %{$item->{worn_on}{$method}})
    {
      $self->{$k} = undef;
      $self->{attached}{$k} = undef;
    }
    $self->{$method} = undef;
    if (not $item->{body})
    {
      $self->take($item);
    }
    $self->recalc_lit;
    if (exists $item->{on_wear})
    {
      ::script $item->{on_wear}, $item, $self, -1;
    }
  }
  return $item;
}

sub wield
{
  my $self = shift;
  my $key; my @w;
  if ($::pref{wield} eq 'body')
  {
    foreach $key (@{$worder})
    {
      my $method = $wtable->{$key}[0];
      push @w, $key if (not defined $self->{$method}
                        or $::pref{bodymenu} eq 'full');
    }
    if ($#w == -1)
    {
      $self->seen($self, "<self> can equip no more items.");
      return 0;
    } else
    {
      my $q = Menu->new(
                         'label' => [ @w ],
                       )->pick;
      if ($q eq 'Cancel')
      {
        return 0;
      }
      if (defined $self->{$wtable->{$q}->[0]})
      {
        my $verb = "take off";
        $verb = "put away" if $q eq 'L.Hand' or $q eq 'R.Hand';
        $self->seen($self->{$wtable->{$q}->[0]}, "<self> will have to $verb <other> first.");
        return 0;
      }
      my $i = $self->choose_item($wtable->{$q}->[0]);
      if (not defined $i)
      {
        return 0;
      } else
      {
        if ($i)
        {
          if ($self->put_on($i, $wtable->{$q}->[0]))
          {
            $i->identify;
            if ($wtable->{$q}->[0] eq 'lhand' or $wtable->{$q}->[0] eq 'rhand')
            {
              $self->seen($i, "<self> readies <other>.");
            } else
            {
              $self->seen($i, "<self> puts on <other>.");
            }
          }
        } else
        {
          $self->seen($self, "<self> has nothing appropriate to equip there.");
          return 0;
        }
      }
    }
  } elsif ($::pref{wield} eq 'item')
  {
    my $i = $self->choose_item();
    if (not defined $i)
    {
      return 0;
    } else
    {
      if ($i)
      {
        foreach $key (@{$worder})
        {
          my $method = $wtable->{$key}[0];
          push @w, $key if (not defined $self->{$method} and
                                defined $i->{worn_on}{$method});
        }
        if ($#w == -1)
        {
          $self->seen("<self> has nowhere to equip that.");
          return 0;
        } else
        {
          my $q = Menu->new( 'indent' => 1,
                             'label' => [ @w ],
                           )->pick;
          if ($q eq 'Cancel')
          {
            return 0;
          }
          $i->identify;
          $self->put_on($i, $wtable->{$q}->[0]);  # should always return 0
        }
      } else
      {
        $self->seen($self, "<self> has nothing to equip.");
        return 0;
      }
    }
  }
  return 1;
}

sub unwield
{
  my $self = shift;
  my $key; my @w;
  foreach $key (@{$worder})
  {
    my $method = $wtable->{$key}[0];
    push @w, $key if defined $self->{$method};
  }
  if ($#w == -1)
  {
    $self->seen($self, "<self> has nothing equipped.");
    return 0;
  } else
  {
    my $q = Menu->new(
                       'label' => [ @w ],
                     )->pick;
    my $t;
    if ($q eq 'Cancel')
    {
      return 0;
    }
    $t = $self->take_off($wtable->{$q}->[0]);
    if ($t->{curse})
    {
      $self->seen($t, "<self> cannot seem to let go of <other>!");
    } else
    {
      if ($wtable->{$q}->[0] eq 'lhand' or $wtable->{$q}->[0] eq 'rhand')
      {
        $self->seen($t, "<self> puts <other> away.");
      } else
      {
        $self->seen($t, "<self> takes off <other>.");
      }
    }
  }
  return 1;
}

require Combat;

sub hostile
{
  my $self = shift;
  my $n = { %{$self} };
  bless $n, ref $self;
  $n->{hostile} = 1;
  return $n;
}

sub reward
{
  my $self = shift;
  my $k; my $r = 0;
  foreach $k (keys %stat)
  {
    $r += $self->{max}{$k};
  }
  foreach $k (@{$self->{talents}})
  {
    $r += 50; # $k->reward;
  }
  # also factor in: experience, talents, and so forth
  $r += $self->{experience};
  return $r;
}

1;
