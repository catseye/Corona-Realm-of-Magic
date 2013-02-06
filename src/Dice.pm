package Dice;
@ISA = qw( Saveable );

# Dice object for CARPE DIEM

# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

use Carp;

# our $AUTOLOAD;  # it's a package global

my %fields =
(
  'count'       => 1,
  'faces'       => 6,
  'plus'        => 0,
);

sub new
{
  my $class = shift;
  my $self =
  {
    '_permitted' => \%fields,
    %fields,
    'count'  => shift || $fields{count},
    'faces'  => shift || $fields{faces},
    'plus'   => shift || $fields{plus},
  };
  bless $self, $class;
  return $self;
}

sub roll
{
  my $self = shift;
  return ::d($self->{count}, $self->{faces}) + $self->{plus};
}

sub improve
{
  my $self = shift;
  my $x = shift;
  my $n = Dice->new($self->{count}, $self->{faces}, $self->{plus} + $x);
  return $n;
}

sub improve_faces
{
  my $self = shift;
  my $x = shift;
  my $r = int($self->{faces} * $x);
  $r = 1 if $r == 0;
  my $n = Dice->new($self->{count}, $r, $self->{plus});
  return $n;
}

sub max
{
  my $self = shift;
  return $self->{count} * $self->{faces} + $self->{plus};
}

sub copy
{
  my $self = shift;
  my $new = {
              'count' => $self->{count},
              'faces' => $self->{faces},
              'plus'  => $self->{plus},
            };
  bless $new, ref $self;
  return $new;
}

1;
