package Saleable;
# @ISA = qw( Cloneable Saveable Adj );

# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

use Carp;

# Things saleable objects have:
# Item, Talent, Actor(?)

%fields =
(
  'value'          => undef,
);

# applies only to the Actor posessing this Item or Talent
sub perceive_value
{
  my $self = shift;
  my $v = shift;
  $self->{value} = $v;
  return $self;
}

1;
