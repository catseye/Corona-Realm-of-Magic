package Menu;
# @ISA = qw( Saveable );

# Menu object for CARPE DIEM

# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

use Carp;

my %fields =
(
  'title'       => '',
  'label'       => [],
  'value'       => [],
  'help'        => [],
  'lore'        => [],
  'cancel'      => 'Cancel',

  'display_help'=> 0,

  'erase'       => 0,
  'indent'      => 0,
  'x'           => 62,
  'y'           => 3,
  'lore_x'      => 2,
  'lore_y'      => 8,
);

sub new
{
  my $class = shift;
  my %params = @_;
  my $self =
  {
    '_permitted' => \%fields,
    %fields,
   'label'       => [],
   'value'       => [],
   'help'        => [],
   'lore'        => [],
   'x'           => $::pref{map_width}+3,
   'y'           => 3,
    %params,
  };
  bless $self, $class;
  $self->{x} += $self->{indent};
  $self->{y} += $self->{indent};
  return $self;
}

sub draw
{
  my $self = shift;
  my $i = shift;
  my $y = $self->{y};
  while($i <= $#{$self->{label}} and $y < $self->{y}+$self->{height})
  {
    ::gotoxy($self->{x}-1,$y);
    ::color('black','grey');
    ::display(chr(ord('a')+$i));
    ::color('grey','black');
    ::display(' ', ::fitpad($self->{label}[$i], $self->{width}));
    $y++;
    $i++;
  }
  while($y < $self->{y}+$self->{height})
  {
    ::gotoxy($self->{x}-1,$y);
    ::color('black','grey');
    ::display(' ');
    ::color('grey','black');
    ::display(' ', ::fitpad(' ', $self->{width}));
    $y++;
  }
}

# returns 'value' element corresponding to menu item chosen.
# if this does not exist, returns the menu label.
sub pick
{
  my $self = shift;
  my $x1 = $self->{x}-1;
  my $y1 = $self->{y}-1;
  my $t;

  while (not defined $self->{label}[$#{$self->{label}}])
  {
    $#{$self->{label}}--;
  }

  my $l = ::longest($self->{label});
  my $lc = ($::setup{screen_width}-$self->{x})-2;
  $l = $lc if $l > $lc;
  $self->{width} = $l;
  $self->{height} = ($::setup{screen_height}-$self->{y})-1;
  if ($#{$self->{label}}+1 < $self->{height})
  {
    $self->{height} = $#{$self->{label}}+1;
  }

  my $topline = 0;
  my $index = 0;

  my $x2 = $self->{x}+$self->{width}+2;
  my $y2 = $self->{y}+$self->{height};
  my $r = undef;

  ::color('grey','black');
  ::draw_box($x1,$y1,$x2,$y2);

  my $q; my $done = 0;

  $self->draw($topline);
  while ($index <= $#{$self->{label}} and not defined $self->{label}[$index])
  {
    $index++;
  }

  while(not $done)
  {
    if ($self->{display_help})
    {
      ::gotoxy(1,$::setup{screen_height});
      ::color('white','black');
      ::display(::fitpad($self->{help}[$index] || $self->{label}[$index],
                $::setup{screen_width}-1));
      if(defined $self->{lore}[$index])
      {
        my $t = ::wordwrap($self->{lore}[$index], $::pref{map_width}-2);
        my $i = 0;
        while ($i <= $#{$t})
        {
          ::gotoxy($self->{lore_x},$self->{lore_y}+$i);
          ::display(::fitpad($t->[$i], $::pref{map_width}-2));
          $i++;
        }
        while ($i <= 14)
        {
          ::gotoxy($self->{lore_x},$self->{lore_y}+$i);
          ::display(::fitpad(' ', $::pref{map_width}-2));
          $i++;
        }
      }
    }
    ::gotoxy($self->{x},$self->{y}+$index-$topline);
    ::color('black','grey');
    ::display(' ', ::fitpad($self->{label}[$index], $self->{width}));
    ::color('grey','black');
    $q = ::getkey;
    if (ord($q) == 27)
    {
      $q = ::getkey;
      if ($q eq '[')
      {
        $q = ::getkey;
        $q = '8' if $q eq 'A' or $q eq 'D';
        $q = '2' if $q eq 'B' or $q eq 'C';
      }
    }
    if($q ge 'a' and $q le chr(ord('a')+$self->{height}))
    {
      ::gotoxy($self->{x},$self->{y}+$index-$topline);
      ::display(' ', ::fitpad($self->{label}[$index], $self->{width}));
      $index = ord($q)-ord('a')+$topline;
      ::color('black','grey');
      ::gotoxy($self->{x},$self->{y}+$index-$topline);
      ::display(' ', ::fitpad($self->{label}[$index], $self->{width}));
      ::color('grey','black');
      $q = chr(13);
    }
    if($q eq '2' or $q eq '6')
    {
      ::gotoxy($self->{x},$self->{y}+$index-$topline);
      ::display(' ', ::fitpad($self->{label}[$index], $self->{width}));
      $index++;
      while ($index <= $#{$self->{label}} and not defined $self->{label}[$index])
      {
        $index++;
      }
      $index = 0 if $index > $#{$self->{label}};
    }
    if($q eq '8' or $q eq '4')
    {
      ::gotoxy($self->{x},$self->{y}+$index-$topline);
      ::display(' ', ::fitpad($self->{label}[$index], $self->{width}));
      $index--;
      while ($index >= 0 and not defined $self->{label}[$index])
      {
        $index--;
      }
      $index = $#{$self->{label}} if $index < 0;
    }
    if($q eq '2' or $q eq '6' or $q eq '8' or $q eq '4')
    {
      if ($index > $topline+$self->{height}+1)
      {
        $topline += $self->{height};
        $self->draw($topline);
        $index = $topline;
        while ($index <= $#{$self->{label}} and not defined $self->{label}[$index])
        {
          $index++;
        }
      }
      if ($index < $topline)
      {
        $topline -= $self->{height};
        $self->draw($topline);
        while ($index >= 0 and not defined $self->{label}[$index])
        {
          $index--;
        }
      }
    }
    if (ord($q) == 13 or ord($q) == 10)
    {
      $r = $index;
      $done = 1;
    }
    if (ord($q) == 27)
    {
      $done = 1;
    }
  }
  if(defined $r)
  {
    my $ri = $r;
    $r = $self->{value}[$ri] || $self->{label}[$ri];
    $r = $self->{cancel} if not defined $r;
    $self->{erase} = 0 if $ri != $#{$self->{label}};
  } else
  {
    $r = $self->{cancel};
  }
  if ($self->{erase})
  {
    ::blank_out($x1,$y1,$x2,$y2);
  }
  if(defined $self->{lore}[0])
  {
    my $i = 0;
    while ($i <= 14)
    {
      ::gotoxy($self->{lore_x},$self->{lore_y}+$i);
      ::display(::fitpad(' ', $::pref{map_width}-2));
      $i++;
    }
  }
  return $r;
}

1;
