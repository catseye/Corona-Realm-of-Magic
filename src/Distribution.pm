package Distribution;
@ISA = qw( Saveable );

# Distribution objects for CARPE DIEM

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
