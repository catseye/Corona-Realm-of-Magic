package Dice;
@ISA = qw( Saveable );

# Dice object for CARPE DIEM

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
