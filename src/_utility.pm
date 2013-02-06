# _utility.pm: utility functions for CARPE DIEM

# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

sub d # returns n-die-m function
{
  my $n = shift;
  my $f = shift;
  my $i; my $t=0;
  return $n if $f==1;
  for($i=0;$i<$n;$i++) { $t += int(rand(1)*$f)+1; }
  return $t;
}

sub sgn # returns sign-function
{
  my $n = shift;
  if ($n > 0) { return 1; }
  elsif ($n < 0) { return -1; }
  return 0;
}

sub dirpad # returns delta from number on directional keypad
{
  my $char = shift;
  if    ($char eq $::padmap->[2][0]) { return (-1,+1); }
  elsif ($char eq $::padmap->[2][1]) { return ( 0,+1); }
  elsif ($char eq $::padmap->[2][2]) { return (+1,+1); }
  elsif ($char eq $::padmap->[1][0]) { return (-1, 0); }
  elsif ($char eq $::padmap->[1][1]) { return ( 0, 0); }
  elsif ($char eq $::padmap->[1][2]) { return (+1, 0); }
  elsif ($char eq $::padmap->[0][0]) { return (-1,-1); }
  elsif ($char eq $::padmap->[0][1]) { return ( 0,-1); }
  elsif ($char eq $::padmap->[0][2]) { return (+1,-1); }
}

sub direction # returns delta from cardinal direction name
{
  my $char = shift;
  if    ($char eq 'southwest') { return (-1,+1); }
  elsif ($char eq 'south')     { return ( 0,+1); }
  elsif ($char eq 'southeast') { return (+1,+1); }
  elsif ($char eq 'west')      { return (-1, 0); }
  elsif ($char eq 'nowhere')   { return ( 0, 0); }
  elsif ($char eq 'east')      { return (+1, 0); }
  elsif ($char eq 'northwest') { return (-1,-1); }
  elsif ($char eq 'north')     { return ( 0,-1); }
  elsif ($char eq 'northeast') { return (+1,-1); }
}

sub longest # returns longest string in array
{
  my $ar = shift;
  my $i = 0; my $l = 0;
  for($i = 0; $i <= $#$ar; $i++)
  {
    $l = length($ar->[$i]) if defined $ar->[$i] and length($ar->[$i]) > $l;
  }
  return $l;
}

sub fit
{
  my $text = shift;
  my $width = shift;
  my $ellipsis = "..";
  if (length($text) > $width)
  {
    return substr($text, 0, $width - length($ellipsis)) . $ellipsis;
  }
  return $text;
}

sub fitpad
{
  my $text = shift || 'N/A';
  my $width = shift;
  $text = fit($text, $width);
  $text .= ' ' x ($width - length($text)) if length($text) < $width;
  return $text;
}

sub script # har har
{
  my $script = shift @_;
  my @a = @_;
  my $r = 1;
  if (defined $script and $script)
  {
    @_ = @a;
    $r = eval $script;
    print $script if $@;
    die $@ if $@;
  }
  return $r;
}

sub wordwrap
{
  my $text = shift;
  my $col  = shift;

  my $t = []; my $a = '';
  while($text =~ /^\s*(\S+)\s*/)
  {
    if (length($a . $1 . ' ') > $col)
    {
      push @{$t}, $a; $a = '';
    }
    $a .= $1 . ' ';
    $text = $';
  }
  push @{$t}, $a;
  return $t;
}

1;
