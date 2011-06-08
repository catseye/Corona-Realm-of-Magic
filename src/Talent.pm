package Talent;
@ISA = qw( Cloneable Saveable Saleable );

# Copyright (c)2000, Cat's Eye Technologies.
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 
#   Redistributions of source code must retain the above copyright
#   notice, this list of conditions and the following disclaimer.
# 
#   Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer in
#   the documentation and/or other materials provided with the
#   distribution.
# 
#   Neither the name of Cat's Eye Technologies nor the names of its
#   contributors may be used to endorse or promote products derived
#   from this software without specific prior written permission. 
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
# CONTRIBUTORS ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
# OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
# OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE. 

use Carp;

my %fields =
(
  %Saleable::fields,
  'name'         => '',
  'proper'       => 1,
  'type'         => 'skill',
  'innate'       => 0,
  'expertise'    => 0,
  'cost'         => 0,
  'range'        => 0,
  'onitem'       => 0,
  'moves'        => 0,
  'lastuse'      => -1,
  'recharge'     => -1,

  'verbal'       => 0,
  'musical'      => 0,
  'somatic'      => 0,
  'material'     => undef, # array of items required
  'consumed'     => undef, # array of items which will be used up
  'instrument'   => undef, # arrat of Adjectivals required on items

  'caster'       => undef,
  'what'         => undef,  # used by on_perform
  'num'          => undef,  # used by on_perform
  'prof'         => 100,    # proficiency, 1-100+
  'lesson'       => 0,      # lesson points

  'on_perform'   => '',
  'on_decide'    => '',     # code that determines when NPC should use
);

sub new
{
  my $class = shift;
  my %params = @_;
  my $self =
  {
    '_permitted' => \%fields,
    %fields,
    %params
  };
  bless $self, $class;
  return $self;
}

sub new_recharge
{
  my $self = shift;
  my $re = shift;
  my $n = $self->copy;
  $n->{recharge} = $re;
  $n->{cost} = 0;
  $n->{moves} = 0;
  $n->{range} = 4; # well, no 
  return $n;
}

sub use
{
  my $self = shift;
  my $actor = shift;
  my $item = shift;    # optional
  my $target = shift;  # optional

  my $x; my $y; my $loc;

  $self->{caster} = $actor;
  if ($self->{recharge} > -1)
  {
    if ($self->{lastuse} == -1 or $self->{lastuse} < $::game_time - $self->{recharge})
    {
      $self->{lastuse} = $::game_time;
    } else
    {
      $actor->seen("<self> must wait until $self recharges.");
      return;
    }
  }
  if ($actor eq $::leader)
  {
    if ($self->{onitem})
    {
      $target = $::leader->choose_item();
    }
    elsif ($self->{range} > 1)
    {
      my @c = ::crosshairs($self->{range});
      $x = $c[0] += $actor->{x};
      $y = $c[1] += $actor->{y};
      $loc = $actor->{location};
      $target = $loc->actor_at(@c);
      if (not defined $target)
      {
        $target = $loc->get_top(@c);
      }
    } elsif ($self->{range} == 1)
    {
      my $q = ::getdir();
      ($x, $y) = ::dirpad($q); $x += $actor->{x}; $y += $actor->{y};
      $loc = $actor->{location};
      $target = $loc->actor_at($x, $y);
      if (not defined $target)
      {
        $target = $loc->get_top($x, $y);
      }
    }
  } else
  {
    # todo : touchability rules: check range
    $target = $target || $actor->{target};  # if not already given perhaps
  }

  if($self->{verbal} and $actor->{dumb} and not defined $item)
  {
    $actor->seen($self, "<self> cannot speak the required words of <other>!");
    $self->{caster} = undef;
    return;
  }
  if($self->{somatic} and $actor->{op}{dexterity} < 3 and not defined $item) # 3???
  {
    $actor->seen($self, "<self> cannot make the required motions of <other>!");
    $self->{caster} = undef;
    return;
  }
  if (defined $self->{material} or defined $self->{instrument})
  {
    while (defined $self->{material} and ref($self->{material}) ne 'ARRAY')
    {
      $self->{material} = eval($self->{material});
      $self->{consumed} = eval($self->{consumed});
    }
    if($#{$self->{instrument}} > -1 and not defined $item)
    {
      my $a;
      foreach $a (@{$self->{instrument}})
      {
        next if $actor->has($a);
        my $f = $#{$self->{instrument}} > 0 ? "(and some other things) " : "";
        $actor->seen("<self> will require a $a->{name} (or something similar) ${f}for this.");
        $self->{caster} = undef;
        return;
      }
    }
    if(defined $self->{material} and $#{$self->{material}} > -1 and not defined $item)
    {
      my $m;
      foreach $m (@{$self->{material}})
      {
        next if $actor->has($m);
        my $f = $#{$self->{material}} > 0 ? "(and some other things) " : "";
        $actor->seen($m, "<self> will require <# other> ${f}for this.");
        $self->{caster} = undef;
        return;
      }
    }
  }

  if (::d(1,100) <= $self->{prof})
  {
    if ($self->{moves})
    {
      if (defined $item)
      {
        $actor->seen($item, "<self> begins using <other>...");
      } else
      {
        $actor->seen($self, "<self> begins using <his> talent at <other>...");
      }
      $actor->{using_talent} = [ $self->{moves}, $self, $target ];
    } else
    {
      ::script $self->{on_perform}, $actor, $target, $self;
      if(defined $self->{consumed} and $#{$self->{consumed}} > -1 and not defined $item)
      {
        my $m;
        foreach $m (@{$self->{consumed}})
        {
          my $i = $actor->has($m);
          $i->{count} -= $m->{count};
          $actor->relieve($i) if $i->{count} == 0;
        }
      }
      if (::d(1,100) <= $self->{lesson})
      {
        $self->{lesson} = 0;
        $self->{prof} += 1;
        $actor->seen($self, "<self> gets a little better at <other>.");
      }
    }
  } else
  {
    if (defined $item)
    {
      $actor->seen($item, "<self> can't seem to get <other> to work.");
    } else
    {
      $actor->seen($self, "<self> fails to use <his> talent at <other>.");
    }
    $self->{lesson}++;
  }
  $self->{caster} = undef;
  if (not defined $item)
  {
    $actor->adjust('spirit', 0-$self->{cost}, "casting $self->{name}");
  }
}

1;
