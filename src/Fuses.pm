package Fuses;
@ISA = qw( Saveable );

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

my %fields =
(
  'list'     => [],    # 'length', 'on_expire', 'args'
  '_current' => undef,
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
}

sub add
{
  my $self = shift;
  my $oe   = shift;
  my $l    = shift;
  my $a    = shift;
  my $freeze_channel = shift || carp "Need freeze channel on fuse";
  $a = [ @{$a} ];

  # freeze all fuses on list that have the same $a->[0] . $freeze_channel

  my $f;
  foreach $f (@{$self->{list}})
  {
    if ($f->{channel} eq $a->[0] . $freeze_channel)
    {
      $f->{freeze}++;
    }
  }

  push @{$self->{list}},
    { 'length'    => $l,
      'on_expire' => $oe,
      'args'      => $a,
      'freeze'    => 0,
      'channel'   => $a->[0] . $freeze_channel,
    };
}

sub current
{
  my $self = shift;
  return $self->{_current};
}

sub tick
{
  my $self = shift;
  my $i = 0; my @l = (); my $d = 0;
  while ($i <= $#{$self->{list}})
  {
# print "== $self->{list}[$i]: $self->{list}[$i]{length},,,";
    if ($self->{list}[$i]{freeze}) { $i++; next }
    if ($self->{list}[$i]{length} <= 0)
    {
      $self->{list}[$i]{length} = 0;
      $d = 1;
      $self->{_current} = $self->{list}[$i];
      my $b;
      if (ref $self->{list}[$i]{args}[0])
      {
        $b = ::script $self->{list}[$i]{on_expire}, @{$self->{list}[$i]{args}};
      } else
      {
        $b = 0;
      }
      if (defined $b and $b > 0)
      {
        $self->{list}[$i]{length} = $b-1;
      } else
      {
        $self->{list}[$i]{length} = -1;
        my $f;
        foreach $f (@{$self->{list}})
        {
          if ($f->{channel} eq $self->{list}[$i]{channel})
          {
            $f->{freeze}--;
          }
        }
      }
    } else
    {
      $self->{list}[$i]{length}--;
    }
    $i++;
  }
  $self->{_current} = undef;
  if ($d)
  {
    for($i = 0; $i <= $#{$self->{list}}; $i++)
    {
      push @l, $self->{list}[$i] if $self->{list}[$i]{length} >= 0;
    }
# print "HEY:".join(', ', @{$self->{list}}) . "???";
# print join(', ', @l) . "!!!\n";
    $self->{list} = [ @l ];
  }
}

1;
