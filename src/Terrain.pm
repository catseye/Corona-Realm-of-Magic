package Terrain;
@ISA = qw( Physical );

# Terrain elements (obstacles/floors) for CARPE DIEM

# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

use Carp;

# our $AUTOLOAD;  # it's a package global

my %fields =
(
  %Physical::fields,
  'low'          => 0,      # can be jumped over
  'climbable'    => 0,      # open above, can be climbed
  'conceals'     => 0,      # how well it conceals what's underneath
  'graffiti'     => '',     # words inscribed upon it
  'to'           => '',     # name of region
  'to_x'         => -1,
  'to_y'         => -1,
  '_to_new'      => '',
  'encounter'    => undef,

  'on_reveal'    => '',     # what's hidden underneath
  'on_open'      => '',     # what heppns when opened or closed
  'on_enter'     => '',     # what's happens when stepping onto it
  'on_exit'      => '',     # what's happens when stepping off of it
  'on_stay'      => '',     # what's happens when staying in it

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
}
	
sub to_new  # sets up an interesting transformation upon enter
{
  my $self = shift;
  my $newr = shift;
  my $r = $self->clone;
  $r->{_to_new} = $newr;
  return $r;
}

sub enc
{
  my $self = shift;
  my $newe = shift;
  my $r = $self->clone;
  $r->{encounter} = $newe;
  return $r;
}

sub switch
{
  my $self = shift;
  my $on_pull = shift;
  my $r = $self->clone;
  $r->{name} .= " with a switch";
  $r->{on_pull} = $on_pull;
  return $r;
}

sub at
{
  my $self = shift;
  my $loc = shift;
  my $x = shift;
  my $y = shift;
  $self->{location} = $loc;
  $self->{x} = $x;
  $self->{y} = $y;
  return $self;
}

sub allows
{
  my $self = shift;
  my $actor = shift;

  # todo: should care about movement rates

  return 0 if $self->is($Adj::wall) and not $actor->is($Adj::ethereal);
  return 0 if $self->is($Adj::obstacle) and not $actor->is($Adj::ethereal) and not $actor->is($Adj::airborne);
  return 0 if $self->is($Adj::water) and not $actor->is($Adj::ethereal) and not $actor->is($Adj::airborne) and not $actor->is($Adj::aquatic);
  return 1;
}

sub new_inscribe
{
  my $self = shift;
  my $msg = shift;
  my $new = $self->copy;
  $new->{graffiti} .= $msg . ". ";
  return $new;
}

1;
