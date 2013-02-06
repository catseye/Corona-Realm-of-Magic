package Cloneable;

# Coneable and Copyable objects for CARPE DIEM

# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

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
