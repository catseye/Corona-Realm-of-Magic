package Item;
@ISA = qw( Physical Saleable );

# Things Actors can pick up and use in CARPE DIEM

# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

use Carp;

# our $AUTOLOAD;  # it's a package global

my %fields =
(
  %Physical::fields,
  %Saleable::fields,
  'worn_on'      => { 'rhand' => 0, 'lhand' => 0 },
  'body'         => 0, # is it part of the body? (is not dropped after death)
  'charges'      => -1,
  'talent'       => undef,    # when used or consumed
  'soul'         => undef,

  'monogram'     => '',

  'on_wear'      => '',       # effect on player when put on/taken off
  'on_consume'   => '',       # effect on player when consumed
  'on_use'       => '',       # effect on player when used
  'on_land'      => '',       # effect after item is thrown
  'on_pickup'    => '',       # effect after item is picked up
);

sub new
{
  my $class = shift;
  my %params = @_;
  my $self =
  {
    '_permitted' => \%fields,
    %fields,
    'worn_on'      => { 'rhand' => { 'rhand' => 0 },
                        'lhand' => { 'lhand' => 0 } },
    'melee_attacks'      => [ Attack->weapon(0, Dice->new(1,2), $Adj::crushing) ],
    'projectile_attacks' => [ Attack->weapon(0, Dice->new(1,1), $Adj::crushing) ],
    %params
  };
  bless $self, $class;
}

sub useup
{
  my $self = shift;
  my $consumer = shift;
  my $delta = shift || 1;
  if (defined $self->{talent})  # should probably be consume_talent
  {
    $self->{talent}->use($consumer, $self);
  } else
  {
    ::script $self->{on_consume}, $self, $consumer;
  }
  $self->identify;
  $self->{count} -= $delta;
  return $self->{count} == 0;
}

sub usemissile
{
  my $self = shift;
  my $consumer = shift;
  my $delta = shift || 1;
  $self->{count} -= $delta;
  return $self->{count} == 0;
}

sub use
{
  my $self = shift;
  my $user = shift;

  if (defined $self->{talent})
  {
    if ($self->{charges} > -1)
    {
      if ($self->{charges} > 0)
      {
        $self->{talent}->use($user, $self);
        $self->{charges}--;
      } else
      {
        $user->seen($self, "<self> cannot seem to get <other> to work.");
      }
    }
  }
  ::script $self->{on_use}, $self;
}

sub bunch
{
  my $self = shift;
  my $amt = shift;
  my $new = $self->clone;
  $new->{count} = $amt;
  return $new;
}

sub combinable
{
  my $self = shift;
  my $other = shift;

  if ($self->{name} eq $other->{name} and
      $self->{identity} eq $other->{identity} and
      # $self->{worn_on} hasheq $other->{worn_on} and        ***************************
      # $self->{written} == $other->{written} and
      # $self->{food} == $other->{food} and
      # $self->{beverage} == $other->{beverage} and
      # $self->{body} == $other->{body} and
      # $self->{magic} == $other->{magic} and
      # $self->{curse} == $other->{curse} and
      $self->equal_adjectival($other) and
      $self->{appearance} eq $other->{appearance} and
      $self->{color} eq $other->{color} and
      $self->{melee_attacks}[0]->equal($other->{melee_attacks}[0]) and  # ************ SHOULD COMPARE ALL ATTACKS
      $self->{weight} == $other->{weight} and
      $self->{durability} == $other->{durability} and
      $self->{condition} == $other->{condition} and
      ((not defined $self->{talent} and not defined $other->{talent}) or
        $self->{talent} eq $other->{talent}) and
      ((not defined $self->{soul} and not defined $other->{soul}) or
        $self->{soul} eq $other->{soul})
     )
  {
    return 1;
  }
  return 0;
}

sub identify
{
  my $self = shift;
  $self->{name} = $self->{identity};
  $self->{plural} = $self->{pluralid};
  return $self;
}

1;
