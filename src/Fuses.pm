package Fuses;
@ISA = qw( Saveable );

# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

use Carp;

my %fields =
(
  'list'     => [],    # 'length', 'on_expire', 'args'
  '_current' => undef,
);

sub new
{
  my $class = shift;
  my %params = @_;
  my $self =
  {
    '_permitted' => \%fields,
    %fields,
    %params,
  };
  bless $self, $class;
}

sub add
{
  my $self = shift;
  my $oe   = shift;
  my $l    = shift;
  my $a    = shift;
  my $freeze_channel = shift || carp "Need freeze channel on fuse";
  $a = [ @{$a} ];

  # freeze all fuses on list that have the same $a->[0] . $freeze_channel

  my $f;
  foreach $f (@{$self->{list}})
  {
    if ($f->{channel} eq $a->[0] . $freeze_channel)
    {
      $f->{freeze}++;
    }
  }

  push @{$self->{list}},
    { 'length'    => $l,
      'on_expire' => $oe,
      'args'      => $a,
      'freeze'    => 0,
      'channel'   => $a->[0] . $freeze_channel,
    };
}

sub current
{
  my $self = shift;
  return $self->{_current};
}

sub tick
{
  my $self = shift;
  my $i = 0; my @l = (); my $d = 0;
  while ($i <= $#{$self->{list}})
  {
# print "== $self->{list}[$i]: $self->{list}[$i]{length},,,";
    if ($self->{list}[$i]{freeze}) { $i++; next }
    if ($self->{list}[$i]{length} <= 0)
    {
      $self->{list}[$i]{length} = 0;
      $d = 1;
      $self->{_current} = $self->{list}[$i];
      my $b;
      if (ref $self->{list}[$i]{args}[0])
      {
        $b = ::script $self->{list}[$i]{on_expire}, @{$self->{list}[$i]{args}};
      } else
      {
        $b = 0;
      }
      if (defined $b and $b > 0)
      {
        $self->{list}[$i]{length} = $b-1;
      } else
      {
        $self->{list}[$i]{length} = -1;
        my $f;
        foreach $f (@{$self->{list}})
        {
          if ($f->{channel} eq $self->{list}[$i]{channel})
          {
            $f->{freeze}--;
          }
        }
      }
    } else
    {
      $self->{list}[$i]{length}--;
    }
    $i++;
  }
  $self->{_current} = undef;
  if ($d)
  {
    for($i = 0; $i <= $#{$self->{list}}; $i++)
    {
      push @l, $self->{list}[$i] if $self->{list}[$i]{length} >= 0;
    }
# print "HEY:".join(', ', @{$self->{list}}) . "???";
# print join(', ', @l) . "!!!\n";
    $self->{list} = [ @l ];
  }
}

1;
