package Distribution;
@ISA = qw( Saveable );

# Distribution objects for CARPE DIEM

# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

use Carp;

sub new
{
  my $class = shift;
  my @params = @_;
  my $self = [ @params ];
  bless $self, $class;
  $self->optimize;
  return $self;
}

sub optimize
{
  my $self = shift;
  my $i = 0;
  my @q = (); my @r = ();
  # sort the array.
  for($i=0;$i<=$#{$self};$i+=2)
  {
    push @q, [ $self->[$i], $self->[$i+1] ];
  }
  @r = sort { $a->[0] > $b->[0] } @q;
  @{$self} = ();
  for($i=0;$i<=$#r;$i++)
  {
    push @{$self}, $r[$i][0];
    push @{$self}, $r[$i][1];
  }
}

sub pick
{
  my $self = shift;
  my $j = 0;
  my $l = rand(1);
  while($j <= $#{$self})
  {
    if ($self->[$j] > $l)
    {
      return $self->[$j+1];
    }
    $l -= $self->[$j]; $j += 2;
  }
  return undef;
}

sub scale
{
  my $self = shift;
  my $s = shift;

  my $j = 0;
  while($j <= $#{$self})
  {
    $self->[$j] *= $s;
    $j += 2;
  }
}

sub DESTROY
{
}

1;
