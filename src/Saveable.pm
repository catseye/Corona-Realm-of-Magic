package Saveable;

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
