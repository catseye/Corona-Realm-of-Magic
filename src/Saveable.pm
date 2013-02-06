package Saveable;

# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

$::saved_objects = 0;
# This is the default save method, overrided on some classes
sub save
{
  my $self = shift;
  my $fh = shift;
  my $indent = shift || 0;
  my $k;
  if (not defined $self)
  {
    print $fh "undef";
  }
  elsif (not $self)
  {
    if ($self =~ /^\d+/)
    {
      print $fh $self;
    } else
    {
      print $fh "''";
    }
  }
  elsif (not ref($self))
  {
    print $fh "q`$self`";
  }
  elsif (ref($self) eq 'Adj')
  {
    my $n = $self->{name};
    $n =~ s/\-/_/g;
    print $fh "\$Adj::$n";
  }
  elsif ($self =~ /SCALAR/)
  {
    print $fh "q`$$self`";
  }
  elsif ($self =~ /HASH/)
  {
    my $b = " "; $b = "bless(" if ref($self) ne 'HASH';
    print $fh "${b}\{\n";
    foreach $k (sort keys %{$self})
    {
      next if defined($k) and
              $k =~ /^_/ or $k eq 'location' or $k eq 'target' or
              $k eq 'party' or $k eq 'caster' or $k eq 'owner';
# print ' ' x ($indent+2), "$k\n" if $k;
      print $fh ' ' x ($indent+2), "'$k' => ";
      save($self->{$k}, $fh, $indent + 2);
    }
    print $fh ' ' x $indent, "}";
    print $fh (",'", ref($self), "')") if ref($self) ne 'HASH';
  }
  elsif ($self =~ /ARRAY/)
  {
    my $b = " "; $b = "bless(" if ref($self) ne 'ARRAY';
    print $fh "${b}\[\n";
    my $i;
    for($i=0;$i<=$#{$self};$i++)
    {
      print $fh ' ' x ($indent + 2);
      save($self->[$i], $fh, $indent + 2)
        unless defined($self->[$i]) and $self->[$i] eq $::leader;
    }
    print $fh ' ' x $indent, "]";
    print $fh (",'", ref($self), "')") if ref($self) ne 'ARRAY';
  } else
  {
    die "What the hell is a '$self' ???";
  }
  $::saved_objects++;
  print $fh ",\n";
}

1;
