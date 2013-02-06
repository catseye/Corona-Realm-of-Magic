package Resistances;
@ISA = qw( Cloneable Saveable );

# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

use Carp;

# An 80% resistance to magic can be expressed as:
#  Resistance->new(0.80, 'magic');

# our $AUTOLOAD;  # it's a package global

my %fields =
(
  'element'      => {},
);

sub new
{
  my $class = shift;
  my @q = @_;
  my %params;
  while ($#q > -1)
  {
    my $e = shift @q;
    my $f = $e;
    $f = $e->{name} if ref($e) eq 'Adj';
    $params{$f} = shift @q;
  }
  my $self =
  {
    '_permitted' => \%fields,
    %fields,
   'element'      => { %params },
  };
  bless $self, $class;
}

1;
