package Encounter;
@ISA = qw( Cloneable Saveable );

# Encounter Drivers for CARPE DIEM

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
  'actors'       => [],
  'message'      => "There's something odd going on here.",
  'lore'         => qq("Lovely weather we're having isn't it?"),
  'persistent'   => 0,
  'friendly'     => 0,
  'itemseller'   => 0,
  'itembuyer'    => 0,
  'serviceseller'=> 0,
  'servicebuyer' => 0,

  'purchasing'   => undef,
  'bribeable'    => undef,
);

sub new
{
  my $class = shift;
  my %params = @_;
  my $self =
  {
    '_permitted' => \%fields,
    %fields,
   'purchasing'   => {},
    %params
  };
  bless $self, $class;
}

sub auto
{
  my $self = shift;
  my $m = shift;
  $self->{message} = "The $m->{name} eyes you suspiciously.";
  return $self;
}

sub begin
{
  my $self = shift;
  my $host = shift;
  my $done = 0;

  if (defined $host and ref($host) eq 'Actor')
  {
    $self->{actors} = [$host];
  }
  if (not defined $self->{actors}[0])
  {
    carp "Need 0th actor";
  }
  ::msg($self->{message});
  ::clrmsg();

  my @w = ('Show Item');
  if (defined $self->{bribeable}) { push @w, 'Bribe'; }
  if ($self->{itemseller})        { push @w, 'Buy Items'; }
  if ($self->{serviceseller})     { push @w, 'Buy Services'; }
  if ($self->{itembuyer})         { push @w, 'Sell Items'; }
  if ($self->{servicebuyer})      { push @w, 'Sell Services'; }

  while (not $done)
  {
    my $q = Menu->new(
                       'label' => [ 'Talk', @w, 'Attack',
                                    $self->{friendly} ? 'Leave' : 'Flee' ],
                     )->pick;
    if ($q eq 'Show Item')
    {
      my $i = $::leader->choose_item();
    }
    elsif ($q eq 'Bribe')
    {
      my $i = $::leader->choose_item();
      my $mx = $i->{count};
      next if not defined $i;
      if (not exists $self->{bribeable}{$i->{name}})
      {
        ::msg('There is no response.');
        $self->attack($host) if not $self->{friendly}; $done = 1;
        next;
      }
      my $min = $self->{bribeable}{$i->{name}};
      ::msg('How many of these will you tempt with?');
      ::gotoxy(60, 25);
      my $n = int(::readstring(3, '\d') || 0);
      if ($n > $mx or $n <= 0)
      {
        ::msg('Even corruption is subject to the basic laws of accounting.');
        next;
      }
      $i->{count} -= $n;
      if ($i->{count} == 0)
      {
        $::leader->relieve($i);
      }
      if ($n < $min)
      {
        ::msg('Seems it was not enough!');
        $self->attack($host) if not $self->{friendly};
        $done = 1;
        next;
      }
      ::msg('The bribe was accepted and you are left in peace.'); $done = 1;
    }
    elsif ($q eq 'Buy Items')
    {
      my $i = $self->{actors}[0]->choose_item('sell!');
      next if not defined $i;
      if (not defined $i->{value})
      {
        ::msg('"That\'s not for sale."');
        next;
      }
      ::msg('"And I ask only ' . $i->{value}{count} . ' '. $i->{value}{name} . 's for each!  How many?"');
      ::gotoxy(60, 25);
      my $n = int(::readstring(3, '\d') || 0);
      if ($n > $i->{count} or $n <= 0)
      {
        ::msg('"Sorry, no rainchecks; on-hand inventory only!"');
        next;
      }
      my $cost = $i->{value}->clone;  $cost->{count} *= $n;
      my $payment;
      if ($payment = $::leader->has($cost))
      {
        $payment->{count} -= $cost->{count};
        if ($payment->{count} == 0)
        {
          $::leader->relieve($payment);
        }
        $self->{actors}[0]->take($cost);
        push @{$::leader->{belongings}}, $i->bunch($n)->clone;
        # combine like items
        $i->{count} -= $n;
        if ($i->{count} == 0)
        {
          $self->{actors}[0]->relieve($i);
        }
        ::msg('"Sold!  A pleasure doing business with you."');
        next;
      } else
      {
        ::msg('"Sorry, you don\'t seem to have sufficient funds."');
        next;
      }
    }
    elsif ($q eq 'Buy Services')
    {
      my $t = $self->{actors}[0]->choose_talent('sell!');
      next if not defined $t;
      if (not defined $t->{value})
      {
        ::msg('"That\'s not for sale."');
        next;
      }
      ::msg('"And I ask only ' . $t->{value}{count} . ' '. $t->{value}{name} . ' for this service!  Buy?"');
      ::gotoxy(60, 25);
      my $n = uc(::readstring(1, '[ynYN]')) || 'N';
      my $cost = $t->{value}->clone;
      my $payment;
      if ($payment = $::leader->has($cost))
      {
        $::full_refund = 0;
        $t->use($self->{actors}[0], undef, $::leader);
        if ($::full_refund)
        {
          ::msg('"Sorry it didn\'t work out."');
        } else
        {
          $payment->{count} -= $cost->{count};
          if ($payment->{count} == 0)
          {
            $::leader->relieve($payment);
          }
          $self->{actors}[0]->take($cost);
          ::msg('"There you are!  It\'s been a pleasure to serve."');
        }
        $::full_refund = 0;
        next;
      } else
      {
        ::msg('"Sorry, you don\'t seem to have sufficient funds."');
        next;
      }
    }
    elsif ($q eq 'Sell Items')
    {
      my $i = $::leader->choose_item();
      my $gi;
      my $mx = $i->{count};
      next if not defined $i;
      if (not exists $self->{purchasing}{$i->{name}})
      {
        ::msg('"I\'m not really interested in that."');
        next;
      }
      $gi = $self->{purchasing}{$i->{name}};
      ::msg('"I\'ll give you ' . $gi->{count} . ' '. $gi->{name} . 's for each!  How many?"');
      ::gotoxy(60, 25);
      my $n = int(::readstring(3, '\d') || 0);
      if ($n > $mx or $n <= 0)
      {
        ::msg('"I was actually more interested in a plausible transaction."');
        next;
      }
      my $cost = $gi->bunch($gi->{count} * $n);
      my $payment;
      if ($payment = $self->{actors}[0]->has($cost))
      {
        $payment->{count} -= $cost->{count};
        if ($payment->{count} == 0)
        {
          $self->{actors}[0]->relieve($payment);
        }
        $::leader->take($cost);
        push @{$self->{actors}[0]->{belongings}}, $i->bunch($n)->clone;
        # combine like items
        $i->{count} -= $n;
        if ($i->{count} == 0)
        {
          $::leader->relieve($i);
        }
        ::msg('"Thank you kindly!  A pleasure doing business with you."');
        next;
      } else
      {
        ::msg('"Sorry, I don\'t seem to have sufficient funds for that many."');
        next;
      }
    }
    elsif ($q eq 'Sell Services')
    {
      $self->{actors}[0]->choose_talent('buy!');
    }
    elsif ($q eq 'Flee' or $q eq 'Cancel' or $q eq 'Leave')
    {
      if ($self->{friendly})
      {
        $done = 1;
      } else
      {
        if (::d(1,25) <= $::leader->{op}{dexterity})
        {
          ::msg("You begin to escape...");
          my $ro = ::d(1,25);
          my $targ = $self->{actors}[0]{max}{dexterity}->roll;
          if ($ro <= $targ)
          {
            ::msg("...and somehow, you got away!"); # [$ro and $targ]");
            $done = 1; next;
          } else
          {
            ::msg("...but you are outmanouevered!"); # [$ro and $targ]");
            $self->attack($host);
            $done = 1;
          }
        } else
        {
          ::msg("You fail to find an escape route.");
          $self->attack($host); $done = 1;
        }
      }
    }
    elsif ($q eq 'Attack')
    {
      $self->attack($host); $done = 1;
    }
    elsif ($q eq 'Talk')
    {
      if ($self->{friendly})
      {
        ::msg($self->{lore});
      } else
      {
        my $style = Menu->new( 'indent' => 1, 'display_help' => 1,
                               'label' => ['Haughty','Scary','Abusive','Disdainful','Neutral','Respectful','Friendly','Familiar','Grovelling'],
                               'help'  => ['Act officiously and with considerable snobbery.',
                                           'Try to frighten others away.',
                                           'Bully and strongarm others into compliance.',
                                           'Show disrespect and lack of regard for others stature and ability.',
                                           'Remain detached and uninvolved.',
                                           'Show due repect for others rank and abilities.',
                                           'Show courtesy, kindness, repentance, and forgiveness.',
                                           'Treat others as old friends.',
                                           'Supplicate yourself and apologize considerably.'],
                             )->pick;
        if (defined $self->{actors}[0]{negotiate}{$style} and
            ::d(1,100) <= ($self->{actors}[0]{negotiate}{$style} + int($::leader->{op}{charisma}/2)))
        {
          ::msg("Negotiations succeed and you manage to avoid combat.");
          $done = 1;
        } else
        {
          ::msg("Your attempts to negotiate have failed.");
          $self->attack($host); $done = 1;
        }
      }
    }
  }

  $::leader->view();
}

sub attack
{
  my $self = shift;
  my $host = shift;
  if (defined $host)
  {
    $host->{target} = $::leader;
    $host->{encounter} = '';
  } else
  {
    my $a;
    foreach $a (@{$self->{actors}})
    {
      my $b = $a->clone;
      $b->prep;
      $b->{target} = $::leader;
      $::leader->{location}->enter($b, $::leader);
      $b->display;
      my $li = ::d(1,$::leader->{op}{dexterity});
      my $ai = ::d(1,$b->{op}{dexterity});
      if ($li > $ai)
      {
        # $b->seen("<self> loses the initiative. [$ai to $li]");
        $b->{using_talent} = [1, undef, undef];  # you get initiative; delay by one move
      } else
      {
        # $b->seen("<self> gets the initiative. [$ai to $li]");
      }
    }
  }
}

1;
