sub attack
{
  my $self = shift;
  my $other = shift;

  # $self swings.  Did they hit?

  my $attr = $self->{melee_attacks};
  my $att;
  if (defined($self->{$self->{domhand}}))
  {
    $attr = $self->{$self->{domhand}}->{melee_attacks};
  }
  my $best = 0;
  my $i = 0;
  for ($i=0;$i<=$#{$attr};$i++)
  {
    $att = $attr->[$i];
    next if not defined $other->{location}; # i.e. other died
    $self->{totalswings}++;
    my $targ = 20 + int($other->{op}{dexterity} * 0.75) - $att->{accuracy}
       - int(($other->{blurry}+9)/10);   # target die: 1d(20+...)
    if ($targ <= $self->{op}{dexterity}) { $targ = $self->{op}{dexterity} + 1; }
    my $r = ::d(1,$targ);                                   # basic roll to hit

    my $ta = undef; my $fail = 0; my $sky = '';
    if ($i == 0 and $ta = $self->has(Talent::weapon_proficiency($self->{$self->{domhand}})))
    {
      # roll talent
      if (::d(1,100) <= $ta->{prof})
      {
        # $self->seen("<self> uses <his> weapon proficiency!");
        $sky = "skillfully ";
        my $r2 = ::d(1,$targ); $r = $r2 if $r2 < $r;
      } else
      {
        $fail = 1;
      }
    }

    if ($att->{autofollow} > 0)
    {
      if ($best >= $att->{autofollow})
      {
        $r = $self->{op}{dexterity};
      } else
      {
        $self->{totalswings}--;
        next;
      }
    } elsif ($att->{followup} > 0)
    {
      if ($best < $att->{followup})
      {
        $self->{totalswings}--;
        next;
      }
    }

    if ($r <= $self->{op}{dexterity})                       # a hit, a palpable hit!
    {
      # where on $other did we hit? choose body part.
      my $b = $Distribution::bp{$self->{body_aim}}->pick;
      my $d = $other->hurt($att, $self, $b, $sky);
      $best++;
      if ($ta and not $fail)
      {
        if(::d(1,100) <= $ta->{lesson})
        {
          $ta->{lesson} = 0;
          $ta->{prof}++;
          $self->review('talents');
          $self->seen("<self> gets a little more proficient at using <his> $self->{$self->{domhand}}->{name}.");
        }
      }
    } else
    {
      $self->seen($other, "<self> ${sky}$att->{attemptverb} <other> but misses.");
      $best = 0;
      if ($fail)
      {
        $ta->{lesson}++;
        $self->review('talents');
      }
    }
  }
}

sub death
{
  my $self = shift;
  my $other = shift;
  my $x;
  if (defined $other)
  {
    $self->seen($other, "<self> is slain by <other>!");
    $other->{experience} += $self->reward;
  } else
  {
    $self->seen($self, "<self> dies!");
  }
  foreach $x (keys %{$wtable})
  {
    my $method = $wtable->{$x}->[0];
    if (defined $self->{$method})
    {
      $self->take_off($method, 1);  # force takeoff even of cursed items
    }
  }
  foreach $x (@{$self->{belongings}})
  {
    $x->{x} = $self->{x};
    $x->{y} = $self->{y};
    $x->{location} = $self->{location};
    unshift @{$self->{location}{map}[$self->{x}][$self->{y}]}, $x;
  }
  foreach $x (@{$self->{location}{actors}})
  {
    next if not defined $x;
    next if not defined $x->{target};
    if ($x->{target} eq $self) { $x->{target} = undef; }
  }
  if ($self->{carcass})
  {
    unshift @{$self->{location}{map}[$self->{x}][$self->{y}]},
      $self->carcass;
  }
  if (defined $self->{party})
  {
    $self->{party}->remove($self);
  }
  if ($self eq $::leader)
  {
    ::moremsg();
    ::color('grey','black');
    ::clrscr();
    ::color('white','grey');
    ::draw_box(30,11,50,22);
    ::gotoxy(34,13);
    ::color('black','grey');
    ::display('R.I.P ' . $::leader->{name});
    ::gotoxy(10,22);
    ::color('lime','green');
    ::display("^`'^'`^'`'" x 6);
    ::getkey;
    ::normal;
    ::clrscr;
    exit(0);
  }
  $self->{location}->relieve($self);
  $self->{location} = undef;
}

sub carcass
{
  my $self = shift;
  return
    Item->new('name' => 'carcass',
              'identity' => $self->{name} . ' carcass',
              'plural' => 'carcasses',
              'pluralid' => $self->{name} . ' carcasses',
              'appearance' => 'carcass',
              'color' => $self->{color},
              'weight' => $self->{max}{constitution} * 10,
              'soul' => $self,
              'x' => $self->{x},
              'y' => $self->{y},
              'location' => $self->{location},
              'type' => 'food')->implies($Adj::edible);
}

sub rest
{
  my $self = shift;
  my $scale = shift;

  my @attrib = ('blind', 'deaf', 'dumb', 'confused', 'paralyzed', 'placid', 'blurry');
  my @release= ('can see', 'can hear', 'can speak', 'can think clearly', 'can move', 'can make decisions', 'is distinct');
  my $i;
  my $f = 0;

  for($i = 0; $i <= $#attrib; $i++)
  {
    if ($self->{$attrib[$i]} > 0)
    {
      $self->{$attrib[$i]} -= $scale;
      if ($self->{$attrib[$i]} <= 0)
      {
        $self->{$attrib[$i]} = 0;
        $self->seen($self, "<self> $release[$i] again!");
        $f = 1;
      }
    }
  }

  my $s = {
                          'strength'     => 240,
                          'constitution' => 160,
                          'dexterity'    => 200,
                          'intelligence' => 280,
                          'spirit'       => 120,
                          'charisma'     => 100,
  };
  my $k;
  foreach $k (keys %{$s})
  {
    if (::d(1,$s->{$k}/$scale) <= $self->{op}{$k})
    {
      my $m = ::sgn($self->{max}{$k} - $self->{op}{$k});
      $self->adjust($k, $m, 'healing') if $m;
      $f = abs($m) if not $f;
    }
  }
  if ($f and $self eq $::leader) { $self->review('character'); }
}

sub step
{
  my $self = shift;
  my $xd   = shift;
  my $yd   = shift;
  my $oi   = 0;
  if ($xd == 0 and $yd == 0)
  {
    $self->rest(2);
    return;
  }
  $self->rest(1);
  if ($self->{confused} or ($self->{blind} and $self ne $::leader))
  {
    my $mxd = ::d(1,3)-2;
    my $myd = ::d(1,3)-2;
    if ($mxd != 0 or $myd != 0)
    {
      $xd = $mxd;
      $yd = $myd;
    }
  }
  if      ($self->{x}+$xd < 0)
  {
    return if $self ne $::leader;
    if ($self->{location}{worldx} == 0)
    {
      $self->seen($self, "<self> cannot cross over the edge of the world.");
      return;
    }
    my $a = $::reg{$::wmap->[$self->{location}{worldy}][$self->{location}{worldx} - 1]};
    # return if not defined $a;
    my $y = $self->{y};
    $self->{location}->queue_follow($self, $a, $a->{sizex}-1, $y);
    $self->{location}->relieve($self);
    $a->enter($self, $a->{sizex}-1, $y);
    $self->{location}->display($self);
    $self->display;
    return;
  } elsif ($self->{y}+$yd < 0)
  {
    return if $self ne $::leader;
    if ($self->{location}{worldy} == 0)
    {
      $self->seen($self, "<self> cannot cross over the edge of the world.");
      return;
    }
    my $a = $::reg{$::wmap->[$self->{location}{worldy} - 1][$self->{location}{worldx}]};
    # return if not defined $a;
    my $x = $self->{x};
    $self->{location}->queue_follow($self, $a, $x, $a->{sizey}-1);
    $self->{location}->relieve($self);
    $a->enter($self, $x, $a->{sizey}-1);
    $self->{location}->display($self);
    $self->display;
    return;
  } elsif ($self->{x}+$xd >= $self->{location}{sizex})
  {
    return if $self ne $::leader;
    if ($self->{location}{worldx} == $#{$::wmap->[0]})
    {
      $self->seen($self, "<self> cannot cross over the edge of the world.");
      return;
    }
    my $a = $::reg{$::wmap->[$self->{location}{worldy}][$self->{location}{worldx} + 1]};
    # return if not defined $a;
    my $y = $self->{y};
    $self->{location}->queue_follow($self, $a, 0, $y);
    $self->{location}->relieve($self);
    $a->enter($self, 0, $y);
    $self->{location}->display($self);
    $self->display;
    return;
  } elsif ($self->{y}+$yd >= $self->{location}{sizey})
  {
    return if $self ne $::leader;
    if ($self->{location}{worldy} == $#{$::wmap})
    {
      $self->seen($self, "<self> cannot cross over the edge of the world.");
      return;
    }
    my $a = $::reg{$::wmap->[$self->{location}{worldy} + 1][$self->{location}{worldx}]};
    # return if not defined $a;
    my $x = $self->{x};
    $self->{location}->queue_follow($self, $a, $x, 0);
    $self->{location}->relieve($self);
    $a->enter($self, $x, 0);
    $self->{location}->display($self);
    $self->display;
    return;
  }

  $self->{location}->gel($self->{x}+$xd,$self->{y}+$yd);
  my $thing = $self->{location}->get_terrain($self->{x}+$xd,$self->{y}+$yd);
  if (not $thing->allows($self))
  {
    if ($self eq $::leader)
    {
      if ($self->{blind} or not $self->{lit})
      {
        $self->seen($self, "Something blocks <self>'s progress.");
      } else
      {
        $self->seen($thing, "<self> can't move through <other>.");
      }
    }
  } else
  {
    my $q = $self->{location}->actor_at($self->{x}+$xd, $self->{y}+$yd);
    if (defined $q)   # fight/encounter
    {
      # if ($q eq $self) { carp "Weird: cannot encounter yourself"; }
      if ($self eq $::leader)
      {
        if ($self->{blind} or not $self->{lit})
        {
          $self->seen($self, "Something blocks <self>'s progress.");
        } else
        {
          $self->seen($q, "<self> can't move through <other>.");
        }
      } else
      {
        $self->attack($q);
      }
      return; # if not defined $self;  # might have been killed if $q reflects attack
    } else            # move
    {
      my $t = $self->{location}->get_terrain($self->{x},$self->{y});
      ::script $t->{on_exit}, $t, $self;

      $self->{location}{_collmap}[$self->{x}][$self->{y}] = 0;
      $self->undisplay;
      $self->{x} += $xd;
      $self->{y} += $yd;
      $self->{location}->gel($self->{x}, $self->{y});
      $self->display;
      $self->{location}{_collmap}[$self->{x}][$self->{y}] = 1;
    }

    my $string = '';
    my $stuff = $self->{location}->get_top($self->{x},$self->{y});
    while (ref($stuff) eq 'Item' and $self->{party})
    {
      if ($self->{blind} or not $self->{lit})
      {
        $self->seen($self, "<self> notes something on the ground here.");
        last;
      }
      elsif ($stuff->{count} > 1)
      {
        $string .= "$stuff->{count} " . $stuff->plural . ", ";
      } else
      {
        $string .= "a $stuff->{name}, ";
      }
      $stuff = $self->{location}{map}[$self->{x}][$self->{y}][++$oi];
    }

    $string =~ s/\,\s*$//g if $string;
    $string =~ s/\,\s*([^,]*?)$/ and $1/g if $string;
    $self->seen("<self> notes $string here.") if $string;

    ::script $thing->{on_enter}, $thing, $self;

    if ($self eq $::leader and defined $thing->{encounter})
    {
      $thing->{encounter}->begin;
      if (not $thing->{encounter}->{persistent})
      {
        $thing->{encounter} = undef;
      }
    }
  }
}

# holds Actor's internal logic for "believable" movement.
# called by Region->tick, et al.
sub move
{
  my $self = shift;
  return if $self->{incapacitated} or $self->{paralyzed};
  if ($self->{sleeping} > 0)
  {
    $self->{sleeping}--;
    if ($self->{sleeping} <= 0)
    {
      $self->seen("<self> wakes up.");
      $self->{sleeping} = -::d(100,3);
    }
    return;
  } elsif ($self->{sleeping} < 0)
  {
    $self->{sleeping}++;
    if ($self->{sleeping} >= 0)
    {
      $self->seen("<self> falls asleep.");
      $self->{sleeping} = ::d(50,3);
      return;
    }
  } else
  {
    $self->{sleeping} = -::d(100,3);
  }
  if ($self->{on_move})
  {
    ::script $item->{on_move}, $self;
    return;
  }
  if (defined $self->{using_talent})
  {
    $self->{using_talent}[0]--;
    if ($self->{using_talent}[0] == 0)
    {
      # should probably be encapsulated in talent...
      if (defined $self->{using_talent}[1])
      {
        ::script $self->{using_talent}[1]->{on_perform},
          $self, $self->{using_talent}[2];
      }
      $self->{using_talent} = undef;
    }
  } elsif (defined $self->{target})
  {
    my $t; my $p = undef;
    foreach $t (@{$self->{talents}})
    {
      next if $t->{recharge} > -1 and $t->{lastuse} >= $::game_time - $t->{recharge};
      if ($self->{op}{spirit} > $t->{cost})
      # and $self->dist($self->{target}) <= $self->{talents}[0]{range})
      {
        if(::script $t->{on_consider}, $t, $self)
        {
          if (defined $p and $p->{lastuse} < $t->{lastuse}) { }
          else { $p = $t; }
        }
      }
    }
    if(defined $p)
    {
      $p->use($self, undef, $self->{target});
      return;
    }
    my $dx = ::sgn($self->{target}{x} - $self->{x});
    my $dy = ::sgn($self->{target}{y} - $self->{y});
    my $aa = $self->{location}->actor_at($self->{x}+$dx,$self->{y}+$dy);
    if ($self->{combat} eq 'Flee')
    {
      $dx *= -1;
      $dy *= -1;
    }
    while ((not $self->in_bounds($self->{x}+$dx,$self->{y}+$dy)) or
         (not $self->{location}->get_terrain($self->{x}+$dx,$self->{y}+$dy)->allows($self)) or
         (defined $aa and $aa ne $self->{target}))
    {
      $dx = ::d(1,3)-2;
      $dy = ::d(1,3)-2;
      $aa = $self->{location}->actor_at($self->{x}+$dx,$self->{y}+$dy);
      $aa = undef if defined $aa and $aa eq $self;
    }
    $self->step($dx,$dy);
  } elsif(defined $self->{party})
  {
    # follow party leader
    my $dx = ::sgn($::leader->{x} - $self->{x});
    my $dy = ::sgn($::leader->{y} - $self->{y});
    if (::d(1,20) > $::leader->{op}{charisma})
    {
      $dx = ::d(1,3)-2;
      $dy = ::d(1,3)-2;
    }
    my $i = 0;
follow_argggh:
    my $aa = $self->{location}->actor_at($self->{x}+$dx,$self->{y}+$dy);
    if ((not $self->in_bounds($self->{x}+$dx,$self->{y}+$dy)) or
        (not $self->{location}->get_terrain($self->{x}+$dx,$self->{y}+$dy)->allows($self)) or
        defined $aa)  
    {
      $dx = ::d(1,3)-2;
      $dy = ::d(1,3)-2;
      $i++;
      if ($i < 100)
      {
        goto follow_argggh;
      } else
      {
        $self->rest; # bash?
      }
    } else
    {
      $self->step($dx, $dy);
    }
  } else
  {
    if ($self->{noncombat} eq 'Wander')
    {
      # wander around randomly
      my $dx = ::d(1,3)-2;
      my $dy = ::d(1,3)-2;
      if ($self->{location}->actor_at($self->{x}+$dx,$self->{y}+$dy)) { $dx = 0; $dy = 0; }
      $self->step($dx, $dy);
      if ($self->{hostile} and $self->los($::leader, 4))
      {
        $self->{target} = $::leader;
      }
    } else
    {
      $self->step(0, 0);
    }
  }
}

sub look_dir
{
  my $self = shift;
  my $x = shift;
  my $y = shift;

  if ($self->{blind})
  {
    $self->seen($self, "<self> is blind.");
    return;
  }
  if (not $self->{lit})
  {
    $self->seen($self, "<self> cannot see in the dark.");
    return;
  }

  $x += $self->{x};
  $y += $self->{y};
  my $t = $self->{location}->get_top($x,$y);
  my $a = $self->{location}->actor_at($x,$y);
  if (defined $a)
  {
    $a->view('impression');
    $self->seen($a, "<self> can see <a other> on a $t->{name} there.");
  } else
  {
    $self->seen($t, "<self> can see <a other> there.");
  }
  if ($t->{graffiti})
  {
    $self->seen($self, "<self> sees scratched in it: $t->{graffiti}");
  }
}

1;
