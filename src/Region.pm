package Region;
@ISA = qw( Cloneable Saveable );

# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

use Carp;

# our $AUTOLOAD;  # it's a package global

my %fields =
(
  'name'         => 'area',
  'sizex'        => 20,
  'sizey'        => 20,
  'offsetx'      => 0,
  'offsety'      => 0,
  'worldx'       => 0,
  'worldy'       => 0,
  'map'          => [],
  'lit'          => [],
  'actors'       => [],
  '_collmap'     => [],
  'generated'    => 0,
  'genpattern'   => 'random',
  'outside'      => $::sc{dark},
  'border'       => undef,
  'ambient'      => undef,
  'terraind'     => undef,
  'terrgradn'    => undef,
  'terrgrads'    => undef,
  'terrgrade'    => undef,
  'terrgradw'    => undef,
  'coast_dir'    => '',
  'coast_begin'  => 0,
  'coast_end'    => 0,
  'monsterd'     => undef,
  'itemd'        => undef,
  'unique'       => undef,
  'apropos_exit' => undef,
  'music'        => '',
  'msg'          => '',
  'template'     => '',
  'legend'       => '',
);

sub new
{
  my $class = shift;
  my %f = @_;
  my $self =
  {
    '_permitted' => \%fields,
    %fields,
    'map'          => [],
    'lit'          => [],
    'actors'       => [],
    '_collmap'     => [],
    %f,
  };
  bless $self, $class;
}

sub get_terrain
{
  my $self = shift;
  my $x = shift;
  my $y = shift;
  my $oi = 0;
  my $thing = $self->{map}[$x][$y][$oi];
  while (ref($thing) eq 'Item')
  {
    $thing = $self->{map}[$x][$y][++$oi];
  }
  if (not defined $thing)
  {
    ::msg("Why is the terrain at ($x,$y) missing?");
    $thing = $self->{ambient}->clone;
    $self->{map}[$x][$y] = [ $thing ];
    if (defined($self->{border}) and
        ($x == 0 or $y == 0 or $x == $self->sizex-1 or $y == $self->sizey-1))
    {
      $thing = $self->{border}->clone;
      unshift @{$self->{map}[$x][$y]}, $thing;
    }
  }
  if (ref($thing) ne 'Terrain')
  {
    carp "Ref of thing can't be " . ref($thing);
  }
  return $thing;
}

sub get_top
{
  my $self = shift;
  my $x = shift;
  my $y = shift;
  my $oi = 0;
  my $thing = $self->{map}[$x][$y][$oi];
  if (not defined $thing)
  {
    ::msg("Why is the terrain at ($x,$y) missing?");
    $thing = $self->{ambient}->clone;
    $self->{map}[$x][$y] = [ $thing ];
    if (defined($self->{border}) and
        ($x == 0 or $y == 0 or $x == $self->{sizex}-1 or $y == $self->{sizey}-1))
    {
      $thing = $self->{border}->clone;
      unshift @{$self->{map}[$x][$y]}, $thing;
    }
  }
  return $thing;
}

sub fill
{
  my $self = shift;
  my $t_dist = shift || $self->{terraind};
  my $o_dist = shift || $self->{itemd};
  my $m_dist = shift || $self->{monsterd};
  $self->{map}[$self->{sizex}][$self->{sizey}] = [];  # pre-extend
  $self->fill_random($t_dist) if $self->{genpattern} eq 'random';
  $self->fill_accretion($t_dist) if $self->{genpattern} eq 'accretion';
  $self->fill_recursive($t_dist, 0, 0, $self->{sizex}-1, $self->{sizey}-1) if $self->{genpattern} eq 'recursive';
  $self->fill_canned($t_dist) if $self->{genpattern} eq 'canned';
  $self->fill_dungeon($t_dist) if $self->{genpattern} eq 'dungeon';
  $self->fill_gradient if $self->{genpattern} eq 'gradient';
  $self->fill_coastline if $self->{genpattern} eq 'coastline';
  $self->fill_maze if $self->{genpattern} eq 'maze';
  $self->fresh_items($o_dist) if defined $o_dist;
  $self->fresh_monsters($m_dist) if defined $m_dist;

  my $u;
  $self->{unique} = [] if not defined $self->{unique};
  foreach $u (@{$self->{unique}})
  {
    if (ref($u) eq 'Actor')
    {
      $self->enter($u->clone);
    } elsif (ref($u) eq 'Terrain' or ref($u) eq 'Item')
    {
      my $x; my $y;
      $x = ::d(1,$self->{sizex})-1;
      $y = ::d(1,$self->{sizex})-1;
      while (not $self->get_terrain($x,$y)->allows($u))
      {
        $x = ::d(1,$self->{sizex})-1;
        $y = ::d(1,$self->{sizex})-1;
      }
      $u = $u->clone;
      $u->{location} = $self;
      $u->{x} = $x;
      $u->{y} = $y;
      unshift @{$self->{map}[$x][$y]}, $u;
    }
  }
}

sub gel
{
  my $self = shift;
  my $x = shift;
  my $y = shift;
  if (not $self->{gelled}[$x][$y])
  {
    $self->{gelled}[$x][$y] = 1;
    if ($self->{map}[$x][$y][$#{$self->{map}[$x][$y]}] ne $self->{ambient})
    {
      push @{$self->{map}[$x][$y]}, $self->{ambient};
    }
    for($k = 0; $k <= $#{$self->{map}[$x][$y]}; $k++)
    {
      $self->{map}[$x][$y][$k] = $self->{map}[$x][$y][$k]->clone;
      $self->{map}[$x][$y][$k]->{x} = $x;
      $self->{map}[$x][$y][$k]->{y} = $y;
      $self->{map}[$x][$y][$k]->{location} = $self;
    }
  }
}

sub fresh_monsters
{
  my $self = shift;
  my $m_dist = shift;
  my $i = 0; my $j = 0;
  for($i = 0; $i < $self->{sizex}; $i++)
  {
    for($j = 0; $j < $self->{sizey}; $j++)
    {
      $self->{_collmap}[$i][$j] = 0;
      my $m = $m_dist->pick;
      if (defined $m)
      {
        if ($self->get_terrain($i,$j)->allows($m))
        {
          my $g = $m->clone;
          $g->prep;
          $self->enter($g,$i,$j);
        }
      }
    }
  }
}

sub fresh_items
{
  my $self = shift;
  my $o_dist = shift;
  my $i = 0; my $j = 0;
  for($i = 0; $i < $self->{sizex}; $i++)
  {
    for($j = 0; $j < $self->{sizey}; $j++)
    {
      my $o = $o_dist->pick;
      if (defined $o and $self->get_terrain($i,$j)->allows($o))
      {
        unshift @{$self->{map}[$i][$j]}, $o->clone;
      }
    }
  }
}

sub fill_random
{
  my $self = shift;
  my $t_dist = shift || $self->{terraind};

  my $i = 0; my $j = 0;

  for($i = 0; $i < $self->{sizex}; $i++)
  {
    for($j = 0; $j < $self->{sizey}; $j++)
    {
      if(defined($self->{border}) and ($j == 0 or $j == $self->{sizey}-1
         or $i == 0 or $i == $self->{sizex}-1))
      {
        $self->{map}[$i][$j] = [ $self->{border} ];
      } else
      {
        my $t = $t_dist->pick;
        $self->{map}[$i][$j] = [ $self->{ambient} ];
        unshift @{$self->{map}[$i][$j]}, $t if defined $t;
      }
    }
  }
}

sub fill_gradient
{
  my $self = shift;

  my $i = 0; my $j = 0;

  for($i = 0; $i < $self->{sizex}; $i++)
  {
    for($j = 0; $j < $self->{sizey}; $j++)
    {
      if(defined($self->{border}) and ($j == 0 or $j == $self->{sizey}-1
         or $i == 0 or $i == $self->{sizex}-1))
      {
        $self->{map}[$i][$j] = [ $self->{border} ];
      } else
      {
        my $t = Distribution->new( (($i)/$self->{sizex})                / 2 => $self->{terrgrade},
                                   (($self->{sizex}-$i)/$self->{sizex}) / 2 => $self->{terrgradw},
                                   (($j)/$self->{sizey})                / 2 => $self->{terrgrads},
                                   (($self->{sizey}-$j)/$self->{sizey}) / 2 => $self->{terrgradn} )->pick;
        if (defined $t)
        {
          $t = $t->pick;
        } else
        {
          $t = $self->{terraind}->pick;
        }
        $self->{map}[$i][$j] = [ $self->{ambient} ];
        unshift @{$self->{map}[$i][$j]}, $t if defined $t;
      }
    }
  }
}

sub fill_coastline
{
  my $self = shift;

  my $i = 0; my $j = 0;

  for($i = 0; $i < $self->{sizex}; $i++)
  {
    for($j = 0; $j < $self->{sizey}; $j++)
    {
      if(defined($self->{border}) and ($j == 0 or $j == $self->{sizey}-1
         or $i == 0 or $i == $self->{sizex}-1))
      {
        $self->{map}[$i][$j] = [ $self->{border} ];
      } else
      {
        my $t;
#        if ($self->{coast_dir} eq 'N/S')
#        {
          if ($i + ::d(1,5,-3) > ($j/$self->{sizey} * $self->{coast_end}))
          {
            $t = $self->{terrgrade};
          } else
          {
            $t = $self->{terrgradw};
          }
#        }
        if (defined $t)
        {
          $t = $t->pick;
        } else
        {
          $t = $self->{terraind}->pick;
        }
        $self->{map}[$i][$j] = [ $self->{ambient} ];
        unshift @{$self->{map}[$i][$j]}, $t if defined $t;
      }
    }
  }
}

sub fill_maze
{
  my $self = shift;

  my $i = 0; my $j = 0;

  for($i = 0; $i < $self->{sizex}; $i++)
  {
    for($j = 0; $j < $self->{sizey}; $j++)
    {
      if(defined($self->{border}) and ($j == 0 or $j == $self->{sizey}-1
         or $i == 0 or $i == $self->{sizex}-1))
      {
        $self->{map}[$i][$j] = [ $self->{border} ];
      } else
      {
        my $t = $self->{terraind}->pick;
        $self->{map}[$i][$j] = [ $self->{ambient} ];
        unshift @{$self->{map}[$i][$j]}, $t if defined $t;
      }
    }
  }
  $i = ::d(1, $self->{sizex})-1;
  $j = ::d(1, $self->{sizey})-1;
  my $done = 0;
  while (not $done)
  {
    $self->{map}[$i][$j] = [ $self->{ambient} ];
    my $w = ::d(1,4);
    if    ($w == 1) { $i++; }
    elsif ($w == 2) { $i--; }
    elsif ($w == 3) { $j++; }
    elsif ($w == 4) { $j--; }
    if ($i < 0 or $j < 0 or $i >= $self->{sizex} or $j >= $self->{sizey})
    {
      $done = 1;
    }
  }
}

sub fill_accretion
{
  my $self = shift;
  my $t_dist = shift || $self->{terraind};
  # my $o_dist = shift || $self->{itemd};
  # my $m_dist = shift || $self->{monsterd};
  my $mcnt = shift;

  my $i = 0;

# Method "A for Accretion":
# Step 1: Take a blank terrain grid, seed it with random terrain types in a 
# dozen or so random cells (depending on size of the grid you're populating). 

  for($i = 0; $i < ($self->{sizex} * $self->{sizey} * 0.025); $i++)
  {
    my $x = ::d(1,$self->{sizex})-1;
    my $y = ::d(1,$self->{sizey})-1;
    my $t = $t_dist->pick;
    $self->{map}[$x][$y] = [ $self->{ambient} ];
    unshift @{$self->{map}[$x][$y]}, $t if defined $t;
  }

# Step 2: For a number of times equal to about 50% of the remaining cells, 
# pick a random cell to start in; if it's blank, do a 4-directional random 
# walk until you hit an already-filled cell. The last blank cell you hit in 
# the walk gets the terrain type of the filled cell. The seeds, in effect, 
# start spreading their own terrain type to nearby areas. 

  my $j = int($self->{sizex} * $self->{sizey} * 0.975 * 0.5);
  for($i = 0; $i < $j; $i++)
  {
    my $x = ::d(1,$self->{sizex})-1;
    my $y = ::d(1,$self->{sizey})-1;
    if (defined $self->{map}[$x][$y])
    {
      $i--;
    } else
    {
rewalk:
      my $ox = $x; my $oy = $y;
      my $d = ::d(1,4);
      if    ($d==1) { $x -= 1; }
      elsif ($d==2) { $x += 1; }
      elsif ($d==3) { $y -= 1; }
      elsif ($d==4) { $y += 1; }
      if ($x < 0 or $y < 0 or $x > $self->{sizex}-1 or $y > $self->{sizey}-1)
      {
        $x = $ox; $y = $oy; goto rewalk;
      }
      if (defined $self->{map}[$x][$y])
      {
        $self->{map}[$ox][$oy] = [ @{$self->{map}[$x][$y]} ];
      } else
      {
        goto rewalk;
      }
    }
  }

# Step 3: For each remaining blank cell, randomly either (a) fill with a 
# random terrain type or (b) pick a direction and walk in a straight line 
# until you hit an edge, in which case you fill with a random terrain type 
# or hit a filled cell, in which case fill the last blank cell as above. 

  for($i = 0; $i < $self->{sizex}; $i++)
  {
    for($j = 0; $j < $self->{sizey}; $j++)
    {
      if (not defined $self->{map}[$i][$j])
      {
        my $t = $t_dist->pick;
        $self->{map}[$i][$j] = [ $self->{ambient} ];
        unshift @{$self->{map}[$i][$j]}, $t if defined $t;
      }
    }
  }
}

sub fill_recursive
{
  my $self = shift;
  my $t_dist = shift || $self->{terraind};
  my $x1 = shift;
  my $y1 = shift;
  my $x2 = shift;
  my $y2 = shift;
  my $pt = shift || $self->{ambient};

#  print "filling ($x1,$y1)-($x2,$y2)"; # <STDIN>;
  if ($x1>=$x2 and $y1>=$y2)
  {
    if (not defined $self->{map}[$x2][$y2])
    {
#      print "planting a ", $pt->name; <STDIN>;
      $self->{map}[$x2][$y2] = [ $self->{ambient} ];
      unshift @{$self->{map}[$x2][$y2]}, $pt if defined $pt;
    }
  } else
  {
    my $t = $t_dist->pick || $self->{ambient};
    my @z;
    $z[0] = $pt;
    $z[1] = $pt;
    $z[2] = $pt;
    $z[3] = $pt;
    $z[::d(1,4)-1] = $t;

    my $xa = int(($x1+$x2)/2);
    my $ya = int(($y1+$y2)/2);
# print "upper left\n";
    $self->fill_recursive($t_dist, $x1, $y1, $xa, $ya, $z[0]);
# print "bottom left\n";
    $self->fill_recursive($t_dist, $x1, $ya+1, $xa, $y2, $z[1]);
# print "bottom right\n";
    $self->fill_recursive($t_dist, $xa+1, $ya+1, $x2, $y2, $z[2]);
# print "upper right\n";
    $self->fill_recursive($t_dist, $xa+1, $y1, $x2, $ya, $z[3]);
  }
}

sub fill_canned
{
  my $self = shift;
  my $t_dist = shift || $self->{terraind};

  my $i = 0; my $j = 0;

  for($i = 0; $i < $self->{sizex}; $i++)
  {
    for($j = 0; $j < $self->{sizey}; $j++)
    {
      my $mapsym = substr($self->{template}[$j], $i, 1) || " ";
      my $t = $self->{legend}{$mapsym};
      if (ref($t) eq 'Distribution') { $t = $t->pick; }
      $self->{map}[$i][$j] = [ $self->{ambient} ];
      unshift @{$self->{map}[$i][$j]}, $t if defined $t;
    }
  }
}

sub fill_dungeon
{
  my $self = shift;
  my $t_dist = shift || $self->{terraind};

  my $x = 0;
  my $y = 0;
  my $i = 0;

  # fill area

  for($x = 0; $x < $self->{sizex}; $x++)
  {
    for($y = 0; $y < $self->{sizey}; $y++)
    {
      my $t = $t_dist->pick;
      if(defined($self->{border}) and ($y == 0 or $y == $self->{sizey}-1
         or $x == 0 or $x == $self->{sizex}-1))
      {
        $t = $self->{border};
      }
      $self->{map}[$x][$y] = [ $self->{ambient} ];
      unshift @{$self->{map}[$x][$y]}, $t if defined $t;
    }
  }

  # create rooms

  for($i = 0; $i < ($self->{sizex} * $self->{sizey} * 0.02); $i++)
  {
    my $px = ::d(1,$self->{sizex}-2);
    my $py = ::d(1,$self->{sizey}-2);
    my $pw = ::d(1,int($self->{sizex}/8));
    my $ph = ::d(1,int($self->{sizey}/8));

    for($x = $px; $x <= $px+$pw and $x < $self->{sizex}-1; $x++)
    {
      for($y = $py; $y <= $py+$ph and $y < $self->{sizey}-1; $y++)
      {
        $self->{map}[$x][$y] = [ $self->{ambient} ];
      }
    }

    # create tunnels

    for($x = $px; $x <= $px+$pw and $x < $self->{sizex}-1; $x++)
    {
      if (::d(1,8) == 1)
      {
        my $d = ::d(1,8)+3;
        for($y = $py; $y > $py-$d and $y > 1; $y--)
        {
          $self->{map}[$x][$y] = [ $self->{ambient} ];
        }
      }
      if (::d(1,8) == 1)
      {
        my $d = ::d(1,8)+3;
        for($y = $py+$ph; $y < $py+$ph+$d and $y < $self->{sizey}-1; $y++)
        {
          $self->{map}[$x][$y] = [ $self->{ambient} ];
        }
      }
    }

    for($y = $py; $y <= $py+$pw and $y < $self->{sizey}-1; $y++)
    {
      if (::d(1,8) == 1)
      {
        my $d = ::d(1,8)+3;
        for($x = $px; $x > $px-$d and $x > 1; $x--)
        {
          $self->{map}[$x][$y] = [ $self->{ambient} ];
        }
      }
      if (::d(1,8) == 1)
      {
        my $d = ::d(1,8)+3;
        for($x = $px+$ph; $x < $px+$ph+$d and $x < $self->{sizex}-1; $x++)
        {
          $self->{map}[$x][$y] = [ $self->{ambient} ];
        }
      }
    }
  }
}

# puts the designated actor into this region.
# one of : enter(dude)       => random location
#        : enter(dude,x,y)   => specific location
#        : enter(dude,dude2) => near dude2
sub enter
{
  my $self = shift;
  my $actor = shift;
  if ($actor eq $::leader)
  {
    $self->{supplement}->browse if defined $self->{supplement};
  }
  if ($actor eq $::leader and not $self->{generated})
  {
    ::msg("Please wait, generating '" . $self->{name} . "' region...");
    ::clrmsg;
    ::update_display;
    $self->fill;
    $self->{generated} = 1;
  }
  if ($actor eq $::leader and defined $self->{msg} and $self->{msg})
  {
    ::msg($self->{msg});
    $self->{msg} = '';
  }

  my $x = shift; $x = ::d(1,$self->{sizex}-2) if not defined $x;
  my $y = shift; $y = ::d(1,$self->{sizey}-2) if not defined $y;
  if (ref($x) eq 'Actor')
  {
    $y = $x->{y} + ::d(1,3)-2;
    $x = $x->{x} + ::d(1,3)-2;
  }
  my $good = 0;
  my $ci = 100;
  while (not $good)
  {
    if (not defined $self->actor_at($x,$y) and
        $self->get_terrain($x,$y)->allows($actor))
    {
      $good = 1;
    } else
    {
      my $ox = $x; my $oy = $y;
arrrgh:
      $x = $ox; $y = $oy;
      $x += (::d(1,3)-2);
      $y += (::d(1,3)-2);
      goto arrrgh if $x < 0 or $y < 0 or $x >= $self->{sizex} or $y >= $self->{sizey};
    }
    $ci--;
    if ($ci == 0)
    {
      ::msg("Can't find any place for " . $actor->{name} . "!");
      $good = 1;
    }
  }
  push @{$self->{actors}}, $actor;
  $actor->{location} = $self;
  $actor->{x} = $x;
  $actor->{y} = $y;
  $self->{_collmap}[$x][$y] = 1;
  $self->gel($x,$y);
  $actor->display;
}

# removes an actor after it's demise or departure
sub relieve
{
  my $self = shift;
  my $actor = shift;
  return if not defined $actor;
  if (ref($actor) eq 'Item' or ref($actor) eq 'Terrain')
  {
    my $t; my @s;
    foreach $t (@{$actor->{location}{map}[$actor->{x}][$actor->{y}]})
    {
      push @s, $t if $t ne $actor;
    }
    $actor->{location}{map}[$actor->{x}][$actor->{y}] = [ @s ];
    $actor->{location}->draw_cell($actor->{x},$actor->{y});
    return;
  }
  my $j = 0;
  while ($j <= $#{$self->{actors}})
  {
    if (defined $self->{actors}[$j])
    {
      if ($actor eq $self->{actors}[$j])
      {
        $self->{_collmap}[$actor->{x}][$actor->{y}] = 0;
        # $#{$self->actors}--;
        $actor->undisplay;
        # $actor->location(undef); # it's not here anymore right?
        $self->{actors}[$j] = undef; # $self->actors->[$#{$self->{actors}}];
        last;
      }
    }
    $j++;
  }
}

sub queue_follow
{
  my $self = shift;
  my $actor = shift;
  my $newrg = shift;
  my $x = shift;
  my $y = shift;

  my $a;
  foreach $a (@{$self->{actors}})
  {
    next if (not defined $a) or $a eq $actor or
         $a->{blind} or $a->{paralyzed} or $a->{confused} or $a->{incapacitated} or
         $a->{sleeping} > 0;
    if ((defined $a->{target} and $a->{target} eq $actor) or
        (defined $a->{party} and $a->{party} eq $actor->{party}))
    {
      $::fuses->add(<<'END_FUSE', $a->dist($actor), [$a, $self, $newrg, $x, $y], 'resist');
      {
        my ($actor, $reg, $newrg, $x, $y) = @_;
        if (defined $actor->{location} and $actor->{location} eq $reg and $::leader->{location} ne $reg)
        {
          $reg->relieve($actor);
          $newrg->enter($actor, $x, $y);
        }
        0;
      }
END_FUSE
    }
  }
}

sub display
{
  my $self = shift;
  my $c = shift; my $ox; my $oy;
  if (ref($c) eq 'Actor')
  {
    $ox = $c->{x} - int($::pref{map_width}/2);    # center on this actor
    $oy = $c->{y} - int($::pref{map_height}/2);
  } else
  {
    $ox = $c - int($::pref{map_width}/2);    # center on these x and y coordinates
    $oy = (shift || 0) - int($::pref{map_width}/2);
  }

  $self->{offsetx} = $ox;
  $self->{offsety} = $oy;

  my $i = 0; my $j = 0; my $q;
  $q = '';
  for($j = $oy; $j <= $::pref{map_height}+$oy-1; $j++)
  {
    ::gotoxy(1,$j-$oy+1);
    for($i = $ox; $i <= $::pref{map_width}+$ox-1; $i++)
    {
      if ($i >= 0 and $j >= 0 and $i < $self->{sizex} and $j < $self->{sizey})
      {
        if ($self->{lit}[$i][$j])
        {
          # $q .= ($::sc{$self->{map}[$i][$j][0]->{appearance}} || '?');
          ::color($self->{map}[$i][$j][0]->{color},'black');
          ::display($::sc{$self->{map}[$i][$j][0]->{appearance}});
        } else
        {
          ::color('grey','black');
          ::display($::sc{dark});
          # $q .= $::sc{dark};
        }
      } else
      {
        ::color('grey','black');
        ::display($self->{outside});
        # $q .= $self->outside;
      }
    }
    # $q .= "\n" if $j != 23+$self->offsety;
  }
  # ::gotoxy(1,1); print $q;
  my $x;
  foreach $x (@{$self->{actors}})
  {
    next if not defined $x;
    $x->display;
  }
}

sub draw_cell
{
  my $self = shift;
  my $x = shift;
  my $y = shift;
  my $detect = shift || 0;
  my $q;
  # $i < $self->sizex and $j < $self->sizey
  if ($self->{lit}[$x][$y])
  {
    die("No " . $self->{map}[$x][$y][0]->{appearance}) if not exists $::sc{$self->{map}[$x][$y][0]->{appearance}};
    $q = $::sc{$self->{map}[$x][$y][0]->{appearance}};
  } else
  {
    $q = $::sc{dark};
  }
  my $i = $x - $self->{offsetx} + 1;
  my $j = $y - $self->{offsety} + 1;
  if ($i >= 1 and $j >= 1 and $i < $::pref{map_width} and $j < $::pref{map_height})
  {
    ::gotoxy($i, $j);
    if ($detect)
    {
      ::color('magenta','blue');
      ::display '*';
    } else
    {
      ::color($self->{map}[$x][$y][0]->{color},'black');
      ::display $q;
    }
  }
  ::update_display;
}

sub tick
{
  my $self = shift;
  my $leader = shift || carp "Need leader in tick";
  my $x; my $j = 0;
  while ($j <= $#{$self->{actors}})
  {
    $x = $self->{actors}[$j++];
    next if not defined $x;
    next if $x eq $leader;
    $x->move;
  }
}

sub actor_at
{
  my $self = shift;
  my $x = shift;
  my $y = shift;
  return undef if $x < 0 or $y < 0 or $x >= $self->{sizex} or $y >= $self->{sizey};
  if ($self->{_collmap}[$x][$y])
  {
    my $q;
    foreach $q (@{$self->{actors}})
    {
      next if not defined $q;
      if ($q->{x} == $x and $q->{y} == $y) { return $q; }
    }
    croak "_collmap is out of date";
  }
  return undef;
}

1;
