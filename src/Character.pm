# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

sub sexualize  # this should be implemented on the race object? ***
{
  my $self = shift;
  if ($self->{sex} eq 'Male' and $self->{race} ne 'Ursati')
  {
    $self->{max}{strength}++;
  }
  elsif ($self->{sex} eq 'Female' and $self->{race} ne 'Ursati')
  {
    $self->{max}{dexterity}++;
  }
  elsif ($self->{sex} eq 'Female' and $self->{race} eq 'Ursati')
  {
    $self->{max}{strength}++;
    $self->{max}{constitution}--;
  }
  $self->{name} = lcfirst($self->{sex}) . ' ' . $self->{name} unless $self->{proper};
  return $self;
}

sub roll # a high-level constructor
{
  my $class = shift;
  my %params = @_;
  my $self; my $race = undef; my $sex = 'Cancel';
  ::color('grey','black');
  ::clrscr();
  ::color('lime','black');
  ::draw_box(1,1,$::pref{map_width},$::pref{map_height});
  ::color('white','black');
  ::draw_box($::pref{map_width}+1,1,$::setup{screen_width},$::pref{map_height});

  my @rnam; my @rlor;
  my $i;
  for($i = 0; $i <= $#{$::pc_races}; $i++)
  {
    push @rnam, $::pc_races->[$i]{race};
    push @rlor, $::pc_races->[$i]{lore};
  }
  while((not defined $race) or ($sex eq 'Cancel'))
  {
    $race = Menu->new( 'cancel' => undef, 'display_help' => 1,
                       'value' => [@{$::pc_races}],
                       'label' => [@rnam],
                       'lore'  => [@rlor],
                     )->pick;
    if (defined $race and ref($race->{sex}) eq 'Distribution')
    {
      $sex = Menu->new('indent'=>1,'label' => ['Male','Female'], 'display_help' => 1,
                       'lore'=>['Males generally have slightly greater raw strength than females.',
                                'Females generally have slightly greater dexterity than males.'])->pick;
    }
    $sex = $race->{sex} if ref($race->{sex}) ne 'Distribution';
  }

roll_it:
  $self = $race->clone;
  $self->{sex} = $sex;
  $self->sexualize;
  $self->{color} = $self->{skin_color};

  $self->heal_all;
  $self->{proper} = 1;
  $self->{body_aim} = 'smart_biped';
  $self->view('character');

  ::gen_bio($self);

  ::color('grey','black');
  ::gotoxy(4,21); ::display(::fit($self->{hair_type} . ' ' . $self->{hair_color} . " hair", 40) . '          ');
  ::gotoxy(4,22); ::display(::fit($self->{eye_type}  . ' ' . $self->{eye_color}  . " eyes", 40) . '          ');
  ::gotoxy(4,23); ::display(::fit($self->{skin_type} . ' ' . $self->{skin_color} . " skin", 40) . '          ');

  ::gotoxy(4,20);
  ::display("right-handed  ") if $self->{domhand} eq 'rhand'; 
  ::display("left-handed   ") if $self->{domhand} eq 'lhand'; 
  ::display("ambidextrous  ") if $self->{domhand} eq 'ambi'; 

  ::gotoxy(4,3);
  ::color('grey','black');
  ::display("'R' to re-roll character stats or 'Enter' to accept.");
  my $key = ::getkey;
  if ($key eq 'r' or $key eq 'R') { goto roll_it; }
  ::gotoxy(4,3);
  ::display("                                                    ");

  ::gotoxy(4,3);
  ::display("Enter the name of this character: ");
  $self->{name} = ::readstring(15)
        || ($self->{sex} eq 'Male' ? $::male_name{$self->{race}}[::d(1,$#{$::male_name{$self->{race}}}+1)-1]
                                   : $::female_name{$self->{race}}[::d(1,$#{$::female_name{$self->{race}}}+1)-1])
        || $self->{race};

  my $d = $self->{domhand};
  if ($d eq 'ambi')
  {
    $self->{ambidextrous} = 1;
    $d = $self->{domhand} = 'rhand';
  }

  return $self;
}

# returns: ref to Item
# or undef if action cancelled
# or 0 if no applicable items
sub choose_item
{
  my $self = shift;
  my @type = @_;

  my $x; my @r; my @ru; my $j = 0; my $map = {};
  my @r2; my @ru2;
  while ($j <= $#{$self->{belongings}})
  {
    $x = $self->{belongings}[$j++];
    my $inc = 0;
    if ($#type == -1)
    {
      $inc = 1;
    } else
    {
      my $t;
      foreach $t (@type)
      {
        if ((ref($t) eq 'Adj' and $x->is($t))
             or exists $x->{worn_on}{$t}
             or ($t eq 'sell!' and defined $x->{value})
             or ($t eq 'buy!'  and defined $x->{value}))
        {
          $inc = 1;
        }
      }
    }
    if ($inc)
    {
      my $g;
      if ($x->{count} > 1)
      {
        $g = $x->{count} . ' ' . $x->plural;
      } else
      {
        $g = $x->{name};
      }
      if ($x->{monogram} ne '')
      {
        $r2[ord($x->{monogram})-ord('a')] = $g;
        $ru2[ord($x->{monogram})-ord('a')] = $x;
      } else
      {
        push @r, $g;
        push @ru, $x;
      }
    }
  }
  return 0 if $#r == -1 and $#r2 == -1;

  # interleave r and r2
  $j = 0;
  while ($j <= $#r2)
  {
    if (defined $r2[$j])
    {
      my $w = $r[$j];
      $r[$j] = $r2[$j];
      push @r, $w;
      my $t = $ru[$j];
      $ru[$j] = $ru2[$j];
      push @ru, $t;
    }
    $j++;
  }

  my $g = Menu->new( 'display_help' => 1,
                     'cancel' => undef,
                     'value' => [@ru],
                     'label' => [@r])->pick;
  return $g;
}

sub choose_talent
{
  my $self = shift;
  my $type = shift || '';

  my $x; my @r; my @ru; my $j = 0;
  while ($j <= $#{$self->{talents}})
  {
    $x = $self->{talents}[$j++];
    next if $x->{type} eq 'reflex';
    if ($type eq '' or $x->{type} eq $type
             or ($type eq 'sell!' and defined $x->{value})
             or ($type eq 'buy!'  and defined $x->{value}))
    {
      push @r, sprintf("%2d", $x->{prof}) . '% ' . $x->{name};
      push @ru, $x;
    }
  }
  return undef if $#r == -1;
  my $g = Menu->new( 'display_help' => 1,
                     'cancel' => undef,
                     'value' => [@ru],
                     'label' => [@r])->pick;
  return $g;
}

sub view
{
  my $self = shift;
  my $new = shift;
  if (defined($new))
  {
    $self->{_view} = $new;
  }
  if (not defined($self->{_view}))
  {
    $self->{_view} = 'character';
  }
  if ($self->{_view} eq 'character')
  {
    my $i;
    ::color('grey','black');
    ::draw_box($::pref{map_width}+1,1,$::setup{screen_width},$::pref{map_height});

    ::gotoxy($::pref{map_width}+3,2); ::display($self->{name});
    ::gotoxy($::pref{map_width}+3,3); ::display($self->{sex} . ' ' . $self->{race});

    for($i=0;$i<=$#{$sorder};$i++)
    {
      ::gotoxy($::pref{map_width}+3,5+$i);
      ::display(ucfirst(substr($sorder->[$i], 0, 3)));
      ::display(": ");
      if ($self->{op}{$sorder->[$i]} > $self->{max}{$sorder->[$i]})
      {
        ::color('sky','black');
      } elsif ($self->{op}{$sorder->[$i]} == $self->{max}{$sorder->[$i]})
      {
        ::color('lime','black');
      } elsif ($self->{op}{$sorder->[$i]} > int($self->{max}{$sorder->[$i]}/2))
      {
        ::color('green','black');
      } elsif ($self->{op}{$sorder->[$i]} > int($self->{max}{$sorder->[$i]}/4))
      {
        ::color('yellow','black');
      } else
      {
        ::color('black','red');
      }
      ::display(sprintf("%3d",$self->{op}{$sorder->[$i]}));
      ::color('grey','black');
      ::display("/");
      ::display(sprintf("%3d",$self->{max}{$sorder->[$i]}));
    }

    ::gotoxy($::pref{map_width}+3,11); ::display("Exp: ", sprintf("%9d", $self->{experience}));
    ::gotoxy($::pref{map_width}+3,12); ::display("Def: ", sprintf("%9.2f", $self->{totalhits} ? $self->{blockedhits} / $self->{totalhits} : 0));
    ::gotoxy($::pref{map_width}+3,13); ::display("Att: ", sprintf("%9.2f", $self->{totalswings}?$self->{damagingswings}/$self->{totalswings}:0));

    ::gotoxy($::pref{map_width}+3,17);
    ::display($self->{blind} ? "blind ":"      ");
    ::display($self->{deaf}  ? "deaf " :"     " );
    ::display($self->{dumb}  ? "dumb"  :"    " );
    ::gotoxy($::pref{map_width}+3,18);
    ::display($self->{confused}  ? "confused " :"         ");
    ::display($self->{paralyzed} ? "paralyzed" :"         ");
    ::gotoxy($::pref{map_width}+3,19);
    ::display($self->{placid} ? "placid " :"       ");
    ::display($self->{blurry} ? "blurry " :"       ");
    ::gotoxy($::pref{map_width}+3,20);
    ::display($self->{sleeping} > 0 ? "asleep " :"       ");
    ::display($self->{sleeping} > -30 and $self->{sleeping} < 0 ? "tired " :"      ");
  }
  elsif ($self->{_view} eq 'impression')
  {
    my $i;
    ::color('grey','black');
    ::draw_box($::pref{map_width}+1,1,$::setup{screen_width},$::pref{map_height});
    # ::gotoxy(62,2); ::display($self->{name});
    ::gotoxy($::pref{map_width}+3,3); ::display($self->{sex} . ' ' . $self->{race});

    for($i=0;$i<=$#{$sorder};$i++)
    {
      ::gotoxy($::pref{map_width}+3,5+$i);
      ::color('grey','black');
      ::display(ucfirst(substr($sorder->[$i], 0, 3)));
      ::display(": ");
      if ($self->{op}{$sorder->[$i]} > $self->{max}{$sorder->[$i]})
      {
        ::color('sky','black');
        ::display("Extreme");
      } elsif ($self->{op}{$sorder->[$i]} == $self->{max}{$sorder->[$i]})
      {
        ::color('lime','black');
        ::display("Uninjured");
      } elsif ($self->{op}{$sorder->[$i]} > int($self->{max}{$sorder->[$i]}/2))
      {
        ::color('green','black');
        ::display("Shaken");
      } elsif ($self->{op}{$sorder->[$i]} > int($self->{max}{$sorder->[$i]}/4))
      {
        ::color('yellow','black');
        ::display("Injured");
      } else
      {
        ::color('black','red');
        ::display("Dwindling");
      }
    }
    ::color('grey','black');

    ::gotoxy($::pref{map_width}+3,18);
    ::display("asleep") if $self->{sleeping} > 0;

    ::gotoxy($::pref{map_width}+2,19);
    ::display("ambidextrous  ") if $self->{ambidextrous}; 
    ::gotoxy($::pref{map_width}+2,20);
    ::display("right-handed  ") if $self->{domhand} eq 'rhand'; 
    ::display("left-handed   ") if $self->{domhand} eq 'lhand'; 
    ::gotoxy($::pref{map_width}+2,21); ::display(::fit($self->{hair_type} . ' ' . $self->{hair_color} . " hair", 19));
    ::gotoxy($::pref{map_width}+2,22); ::display(::fit($self->{eye_type}  . ' ' . $self->{eye_color}  . " eyes", 19));
    ::gotoxy($::pref{map_width}+2,23); ::display(::fit($self->{skin_type} . ' ' . $self->{skin_color} . " skin", 19));
  }
  elsif ($self->{_view} eq 'equipment')
  {
    ::color('grey','black');
    ::draw_box($::pref{map_width}+1,1,$::setup{screen_width},$::pref{map_height});
    ::gotoxy($::pref{map_width}+3,2);  ::display $self->{name};
    my $i = 0;
    while ($i <= 16)
    {
      ::gotoxy($::pref{map_width}+3,$i+4);
      my $part = $wtable->{$worder->[$i]}[0];
      if(defined($self->{$part}))
      {
        ::color('white','black');
        ::display(::fit($self->{$part}{name},16));
      } else
      {
        ::color('grey','black');
        ::display(::fit("(bare " . lc($worder->[$i]) . ")", 16));
      }
      $i++;
    }
  }
  elsif ($self->{_view} eq 'talents')
  {
    ::color('grey','black');
    ::draw_box($::pref{map_width}+1,1,$::setup{screen_width},$::pref{map_height});
    ::gotoxy($::pref{map_width}+3,2);
    ::display($self->{name});
    my $j = 0; my $l = 4;
    while ($j <= $#{$self->{talents}})
    {
      ::gotoxy($::pref{map_width}+3,$l++);
      ::display(::fit($self->{talents}[$j]{name},18));
      ::gotoxy(64,$l++);
      ::display(sprintf('%2d', $self->{talents}[$j]{prof}) . '% (' . sprintf('%2d',$self->{talents}[$j]{lesson}) . '%)');
      $j++;
      if ($l >= $::pref{map_height}-1 and $j <= $#{$self->{talents}})
      {
        ::gotoxy($::pref{map_width}+3,$l);
        ::display("(more)");
        $l = 4;
        last;
      }
    }
    if ($j == 0)
    {
      ::gotoxy($::pref{map_width}+3,4+$j);
      ::display("(no talents)");
    }
  }
  elsif ($self->{_view} eq 'resistances')
  {
    ::color('grey','black');
    ::draw_box($::pref{map_width}+1,1,$::setup{screen_width},$::pref{map_height});
    ::gotoxy($::pref{map_width}+3,2);
    ::display($self->{name});
    my $j; my $l = 4; my $d = 0;
    foreach $j (sort keys %{$self->{resists}{element}})
    {
      $d = 1;
      ::gotoxy($::pref{map_width}+3,$l++);
      ::display(::fit($j,13));
      ::display(sprintf('%3d', $self->{resists}{element}{$j} * 100) . '%');
      if ($l == 19)
      {
        ::gotoxy($::pref{map_width}+3,$l);
        ::display("(more)");
        $l = 4;
        last;
      }
    }
    if ($d == 0)
    {
      ::gotoxy($::pref{map_width}+3,4);
      ::display("(no resistances)");
    }
  }
  elsif ($self->{_view} eq 'party')
  {
    $self->{party}->view;
  }
  elsif ($self->{_view} eq 'all_parties')
  {
    $self->{party}->view; # not quite
  }
  elsif ($self->{_view} eq 'messages')
  {
    my $i = $#::message;
    my $s = 23;
    ::color('grey','black');
    ::draw_box($::pref{map_width}+1,1,$::setup{screen_width},$::pref{map_height});
    ::color('white', 'black');
    my $t;
    while ($i >= 0 and $s > 1)
    {
      $t = ::wordwrap("> " . $::message[$i], $::setup{screen_width}-$::pref{map_width}-2);
      while ($s > 1 and $#{$t} > -1)
      {
        ::gotoxy($::pref{map_width}+2, $s);
        ::display(::fitpad(pop @{$t},$::setup{screen_width}-$::pref{map_width}-2));
        $s--;
      }
      $i--;
    }
    while ($s > 1)
    {
      ::gotoxy($::pref{map_width}+2, $s);
      ::display(::fitpad(' ', $::setup{screen_width}-$::pref{map_width}-2));
      $s--;
    }
  }
  elsif ($self->{_view} eq 'careers' or $self->{_view} eq 'guilds')
  {
    ::color('grey','black');
    ::draw_box($::pref{map_width}+1,1,$::setup{screen_width},$::pref{map_height});
    ::gotoxy($::pref{map_width}+3,2);  ::display($self->{name});

    my $key; my $i = 4;
    foreach $key (sort keys %{$self->{standing}})
    {
      ::gotoxy($::pref{map_width}+3,$i++);
      ::display(sprintf("Rank %2d %s", $self->{standing}{$key}, ucfirst($key)));
    }
    if ($i == 4)
    {
      ::gotoxy($::pref{map_width}+3,$i++);
      ::display("(no affiliations)");
    }
  }
  elsif ($self->{_view} eq 'inventory')
  {
    ::color('grey','black');
    ::draw_box($::pref{map_width}+1,1,$::setup{screen_width},$::pref{map_height});
    ::gotoxy($::pref{map_width}+3,2); ::display($self->{name});
    my $j = 0;
    while ($j <= $#{$self->{belongings}})
    {
      ::gotoxy($::pref{map_width}+3,4+$j);
      ::display(::fit($self->{belongings}[$j]{name},12));
      ::gotoxy($::setup{screen_width}-6,4+$j);
      ::display(sprintf("x%3d",$self->{belongings}[$j]{count}));
      $j++;
      if ($j == 19 and $j <= $#{$self->{belongings}})
      {
        ::gotoxy($::pref{map_width}+3,4+$j);
        ::display("(more)");
        last;
      }
    }
    if ($j == 0)
    {
      ::gotoxy($::pref{map_width}+3,4+$j);
      ::display("(no items)");
    }
  }
  elsif ($self->{_view} eq 'journal')
  {
    ::color('red','black');
    ::draw_box($::pref{map_width}+1,1,$::setup{screen_width},$::pref{map_height});
    ::color('green','black');
    ::gotoxy($::pref{map_width}+3,2);  ::display($self->{name});
    # todo  $self->{journal}[...]
    # ::gotoxy($::pref{map_width}+3,4);  ::display("Rank  1 Adventurer");  # not exactly
  } else
  {
    carp "Unknown view '$self->{_view}'";
  }
}

sub review
{
  my $self = shift;
  my $v = shift;
  if (defined $::leader)
  {
    if ($self eq $::leader and
        defined $self->{_view} and
        ((not defined $v) or $self->{_view} eq $v)) { $self->view; }
  }
}

sub light
{
  my $self = shift;
  return if not $self->{lit};
  return if $self->{blind};
  my $i = 0; my $j = 0;
  for($j = -4; $j <= 4; $j++)
  {
    for($i = -4; $i <= 4; $i++)
    {
      next if int(sqrt($i*$i+$j*$j)) > 4;
      next if not $self->in_bounds($self->{x}+$i, $self->{y}+$j);
      next if not $self->los($i, $j, 4);
      $self->{location}->gel($self->{x}+$i, $self->{y}+$j);
      if (not $self->{location}{lit}[$self->{x}+$i][$self->{y}+$j])
      {
        $self->{location}{lit}[$self->{x}+$i][$self->{y}+$j] = 1;
        if ($self->{x}+$i < $self->{location}{sizex} and $self->{y}+$j < $self->{location}{sizey}
            and $self->{x}+$i >= 0 and $self->{y}+$j >= 0)
        {
          if (not ($j == 0 and $i == 0)
              and ($self->screenx+$i >= 1)
              and ($self->screenx+$i <= $::pref{map_width})
              and ($self->screeny+$j >= 1)
              and ($self->screeny+$j <= $::pref{map_height}))
          {
            ::gotoxy($self->screenx+$i, $self->screeny+$j);
            ::color($self->{location}->get_top($self->{x}+$i,$self->{y}+$j)->{color}, 'black');
            ::display($::sc{$self->{location}->get_top($self->{x}+$i,$self->{y}+$j)->{appearance}});
          }
        }
        $::notice = 1;
      }
    }
  }
  my $x;
  foreach $x (@{$self->{location}->{actors}})
  {
    next if not defined $x;
    $x->display;
  }
}

1;
