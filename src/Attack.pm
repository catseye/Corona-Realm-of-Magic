package Attack;
@ISA = qw( Cloneable Saveable );

# Attack objects - multiple claws, teeth etc - in CARPE DIEM

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
