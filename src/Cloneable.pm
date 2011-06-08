package Cloneable;

# Coneable and Copyable objects for CARPE DIEM

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

# deep copy the object network involved,
# instancing Dice and Distribution objects in the process
sub clone
{
  my $self = shift;
  my $new = +{}; my $key;
  foreach $key (keys %{$self})
  {
    if (not defined $self->{$key})
    {
      $new->{$key} = undef; next;
    }
    my $r = ref($self->{$key});
    if (not $r)
    {
      $new->{$key} = $self->{$key};
    } elsif ($r eq 'SCALAR')
    {
      $new->{$key} = \${$self->{$key}};
    } elsif($r eq 'ARRAY')
    {
      $new->{$key} = [ @{$self->{$key}} ];
    } elsif($r eq 'HASH')
    {
      # $new->{$key} = +{ %{$self->{$key}} };
      $new->{$key} = Cloneable::clone($self->{$key});  # crafty recursion?
    } elsif($r eq 'CODE')
    {
      $new->{$key} = $self->{$key};  # no way/need to clone a sub
    } elsif($r eq '')
    {
      $new->{$key} = $self->{$key};  # no need to clone a scalar
    } elsif($r eq 'Adj')
    {
      $new->{$key} = $self->{$key};  # no need to clone Adj, no identity involved
    } elsif($r eq 'Dice')
    {
      $new->{$key} = $self->{$key}->roll;  # gen new stat
    } elsif($r eq 'Distribution')
    {
      $new->{$key} = $self->{$key}->pick;  # gen new stat
    } elsif($r eq 'Force' or $r eq 'Resistances' or $key eq 'location' or $key eq 'soul')
    {
      # DON'T clone, as will have embedded Dices and Distributions
      # which must be kept, not instanced.
      $new->{$key} = $self->{$key};  # mirror dat reference
    } else # we assume it is cloneable...
    {
      $new->{$key} = $self->{$key}->clone;  # wow, recursion
    }
    # print "\n$key: $self->{$key} ---> $new->{$key}"; ::getkey;
  }
  bless $new, ref $self;
  return $new;
}

# deep copy the object network involved,
# while NOT instancing Dice and Distribution objects in the process

# this will NOT deep-copy references in unblessed arrays
# also it will NOT deep-copy any blessed reference which is NOT a hash
sub copy
{
  my $self = shift;
  my $new = +{}; my $key;
  foreach $key (keys %{$self})
  {
    if (not defined $self->{$key})
    {
      $new->{$key} = undef; next;
    }
    my $r = ref($self->{$key});
    if (not $r)
    {
      $new->{$key} = $self->{$key};
    } elsif ($r eq 'SCALAR')
    {
      $new->{$key} = \${$self->{$key}};
    } elsif($r eq 'ARRAY')
    {
      $new->{$key} = [ @{$self->{$key}} ];
    } elsif($r eq 'HASH')
    {
      $new->{$key} = +{ %{$self->{$key}} };
    } elsif($r eq 'CODE')
    {
      $new->{$key} = $self->{$key};  # no way/need to clone a sub
    } elsif($r eq '')
    {
      $new->{$key} = $self->{$key};  # no need to clone a scalar
    } else
    {
      if ($self->{$key}->isa('Cloneable') and $r ne 'Region')
      {
        $new->{$key} = $self->{$key}->copy;  # wow, recursion
      } else
      {
        $new->{$key} = $self->{$key};  # implies: un-Cloneables have no identity
      }
    }
  }
  bless $new, ref $self;
  return $new;
}

1;
