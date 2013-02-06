package Attack;
@ISA = qw( Cloneable Saveable );

# Attack objects - multiple claws, teeth etc - in CARPE DIEM

# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

use Carp;

# our $AUTOLOAD;  # it's a package global

my %fields =
(
  'attemptverb'   => 'attacks',
  'successverb'   => 'hits',
  'force'         => undef,
  'accuracy'      => 0,
  'followup'      => 0,  # only applicable if preceding attack suceeded
  'autofollow'    => 0,  # >0 means automatically applicable if all n preceding attacks succeeded
  'on_strike'     => '',
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
  return $self;
}

sub weapon
{
  my $class = shift;
  my $ac = shift;
  my $d = shift;
  my @a = @_;
  my $self =
  {
    '_permitted' => \%fields,
    %fields,
    'attemptverb'   => 'swings at',
    'successverb'   => 'strikes',
    'force'      => Force->new($d, @a),
    'accuracy'   => $ac,
  };
  bless $self, $class;
  return $self;
}

sub equal
{
  my $self = shift;
  my $other = shift;

  return $self->{attemptverb} eq $other->{attemptverb} and
         $self->{successverb} eq $other->{successverb} and
         $self->{accuracy} == $other->{accuracy} and
         $self->{followup} == $other->{followup} and
         $self->{autofollow} == $other->{autofollow} and
         $self->{on_strike} == $other->{on_strike} and
         $self->{force}->equal($other->{force});
}

1;
