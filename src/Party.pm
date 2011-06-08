package Party;
@ISA = qw( Cloneable Saveable );

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
  'name'         => undef,
  'leader'       => undef,
  'actors'       => [],
);

sub new
{
  my $class = shift;
  my $leader = shift;
  my $name = shift || 'Untitled Party';
  my $self = {};
  $self->{_permitted}   = \%fields;
  $self->{name}         = $name;
  $self->{leader}       = $leader;
  $self->{actors}       = [ $leader ];
  $self->{vehicles}     = [];
  bless $self, $class;
  $leader->{party} = $self;
  return $self;
}

sub add
{
  my $self = shift;
  my $char = shift;
  if (ref($char) eq 'Actor')
  {
    push @{$self->{actors}}, $char;
    $char->{party} = $self;
  }
  else
  {
    croak("Can only add Actor to Party, not " . ref($char));
  }
}

sub remove
{
  my $self = shift;
  my $char = shift;
  if (ref($char) eq 'Actor')
  {
    my $a; @noo = ();
    foreach $a (@{$self->{actors}})
    {
      if ($a eq $char)
      {
        $char->{party} = undef;
      } else
      {
        push @noo, $a;
      }
    }
    $self->{actors} = [ @noo ];
  }
  else
  {
    croak("Can only remove Actor from Party, not " . ref($char));
  }
}

sub count
{
  my $self = shift;
  return $#{$self->{actors}} + 1;
}

sub view
{
  my $self = shift;
  ::color('grey','black');
  ::draw_box($::pref{map_width}+1,1,$::setup{screen_width},$::pref{map_height});
  ::gotoxy($::pref{map_width}+2,2); ::display($self->{name});
  ::gotoxy($::pref{map_width}+2,3); ::display($::leader->{location}{name});
  # ::display(" (" . $::leader->location->{worldx} . ", " . $::leader->location->{worldy} . ")");

  my $minute =           $::game_time % 60;
  my $hour   = int($::game_time / 60) % 24;

  my $day    = int($::game_time / (60 * 24));
  my $wday   = $day % 7;
  my $mday   = $day % 27;
  my $month  = int($::game_time / (60 * 24 * 27)) % 12;
  my $year   = int($::game_time / (60 * 24 * 27 * 12)) + 786;

  my @wd = ('Solday', 'Lunday', 'Thoday', 'Woday', 'Tyrday', 'Venday', 'Daytag');
  my @md = ('Hominary', 'Eluary', 'Bince',
            'Binget', 'Bremeny', 'Issuary',
            'Amnet', 'Corcuary', 'Tressel',
            'Nabillary', 'Jammusary', 'Vench');

  my $time = sprintf("%2d:%02d", $hour, $minute);

  ::gotoxy($::pref{map_width}+2,4); ::display("$time $wd[$wday]");
  ::gotoxy($::pref{map_width}+2,5); ::display("$md[$month] $mday $year");

  my $j = 0;
  while ($j < $self->count)
  {
    ::gotoxy($::pref{map_width}+2,7+$j);
    ::display($self->{actors}[$j]->{name});
    ::gotoxy($::setup{screen_width}-5,7+$j);
    ::display(sprintf("%3d",$self->{actors}[$j]->{op}{constitution}));
    $j++;
  }
}

1;
