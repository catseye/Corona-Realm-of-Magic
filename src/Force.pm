package Force;
@ISA = qw( Cloneable Saveable Adj );

# Elemental forces in CARPE DIEM

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

# The damage of a regular mace may be expressed as
#  Force->new(Dice->new(1,6,1), 'metal', 'crushing');

# our $AUTOLOAD;  # it's a package global

my %fields =
(
  'dice'         => undef,
);

sub new
{
  my $class = shift; my $x;
  my $self =
  {
    '_permitted' => \%fields,
    %fields,
    'dice' => shift || Dice->new(1,6,0),
    'elements' => [],
  };
  bless $self, $class;
  while (defined($x = shift))
  {
    $self->implies($x);
  }
  return $self;
}

sub roll  # returns the BASE damage, i.e. before resistance by element
{
  my $self = shift;
  return $self->{dice}->roll;
}

sub roll_against  # returns the MODIFIED damage given a subsceptability
                  # or resistance factor (counter forces)
{
  my $self = shift;
  my $resists = shift;  # ref to Resistances object
  my $plus = shift || 0;  # typ. the strength bonus

  my $r = $self->{dice}->roll + $plus;
  return $r if not defined $resists;

  # look for any forces which have same elements as self

  # say self is a (2d6/magic fire) attack.
  # say other has (100/magic) and (50/fire) resists.
  # counter is a (75/magic fire) resist.
  # say an 8 is rolled.  75% of 8 = 6.  Final damage 2.

  # say self is a (2d6/magic fire) attack.
  # say other has (100/magic) and (0/fire) resists.
  # counter is a (50/magic fire) resist.
  # say an 8 is rolled.  50% of 8 = 4.  Final damage 4.

  my $eff = 0;

  my $se; my $c = 0;
  foreach $se (@{$self->{implies}})
  {
    $eff += ($resists->{element}{$se->{name}} || 0);
    $c++;
  }
  $eff /= $c if $c; # ($#{$self->{implies}} + 1); 
  $r = int ($r * (1 - $eff));
  return $r;
}

sub equal
{
  my $self = shift;
  my $other = shift;
  return ($self->{dice}{count} == $other->{dice}{count} and
          $self->{dice}{faces} == $other->{dice}{faces} and
          $self->{dice}{plus}  == $other->{dice}{plus});
}

sub copy
{
  my $self = shift;
  my $new = {
              'dice' => $self->{dice}->copy,
              'elements' => [ @{$self->{elements}} ],
            };
  bless $new, ref $self;
  return $new;
}

1;
