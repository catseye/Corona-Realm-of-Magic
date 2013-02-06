# _action.pm for CARPE DIEM

# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

require "_meta.pm";

%::action =
(
  %::meta,
  'exit_vehicle' => sub
  {
    my $self = shift;
    $self->seen("<self> is not currently in a vehicle.");
    return 1;
  },
  'board_vehicle' => sub
  {
    my $self = shift;
    $self->seen("<self> can find no vehicle to board.");
    return 1;
  },

  'move' => sub
  {
    my $self = shift;
    my $arg  = shift;
    my @c; my $dir;
    if (defined $arg and ref($arg) eq 'ARRAY' and $#{$arg} > -1)
    {
      $dir = $arg->[0];
      @c = ::direction($arg->[0]);
    } else
    {
      $dir = ::getdir();
      @c = ::dirpad($dir);
    }
    if ($self->in_bounds($self->{x}+$c[0],$self->{y}+$c[1]))
    {
      my $q = $self->{location}->actor_at($self->{x}+$c[0],$self->{y}+$c[1]);
      if (defined $q)
      {
        if ($::pref{bumpactor} eq 'look')
        {
          $::redirect = "look_around $dir";
        }
        elsif ($::pref{bumpactor} eq 'interact' or (defined $q->{encounter} and $q->{encounter}{friendly}))
        {
          $::redirect = "interact $dir";
        }
        elsif ($::pref{bumpactor} eq 'attack')
        {
          $::redirect = "bash $dir";
        } else
        {
          $self->step(@c);
        }
      }
      elsif (not $self->{location}->get_terrain($self->{x}+$c[0],$self->{y}+$c[1])->allows($self))
      {
        if ($::pref{bumpterrain} eq 'look')
        {
          $::redirect = "look_around $dir";
        }
        elsif ($::pref{bumpterrain} eq 'bash')
        {
          $::redirect = "bash $dir";
        } else
        {
          $self->step(@c);
        }
      } else
      {
        $self->step(@c);
      }
    } else
    {
      $self->step(@c);
    }
    return 1;
  },
  'rest' => sub
  {
    my $self = shift;
    $self->step(0,0);
    return 1;                # how much time it took up: 0 = meta, 1 = normal, slow or fast?
  },
  'jump' => sub
  {
    my $self = shift;
    my $q = ::getdir();
    my $x; my $y; ($x, $y) = ::dirpad($q);
    my $jox = $self->{x} + $x;
    my $joy = $self->{y} + $y;
    if (not $self->in_bounds($jox, $joy))
    {
      $self->seen($self, "<self> cannot jump into another region.");
      return 1;
    }
    my $t = $self->{location}->get_terrain($jox,$joy);
    my $dude = $self->{location}->actor_at($jox,$joy);
    if (defined $dude)
    {
      $self->seen($dude, "<self> cannot jump over <other>.");
    } elsif ($t->{low} and $t->allows($self))
    {
      # roll effective dexterity
      # if wielding a pole or staff, add 'vaulting' bonus from item
      if (::d(1,25) <= $self->{op}{dexterity})
      {
        my $qm; my $a;
        if (not $self->in_bounds($jox+$x, $joy+$y))
        {
          $a = $::leader;  # not exactly
        } else
        {
          $qm = $self->{location}->get_terrain($jox+$x,$joy+$y);
          $a = $self->{location}->actor_at($jox+$x,$joy+$y);
        }
        if(defined $a or not $qm->allows($self))
        {
          $self->undisplay;
          $self->{location}{_collmap}[$self->{x}][$self->{y}] = 0;
          $self->{x} = $jox;
          $self->{y} = $joy;
          $self->{location}{_collmap}[$self->{x}][$self->{y}] = 1;
          $self->seen($t, "<self> jumps over <other> but crashes into something!");
          # check $t->pit
          $self->display;
        } else
        {
          $self->undisplay;
          $self->{location}{_collmap}[$self->{x}][$self->{y}] = 0;
          $self->{x} = $jox+$x;
          $self->{y} = $joy+$y;
          $self->{location}{_collmap}[$self->{x}][$self->{y}] = 1;
          $self->seen($t, "<self> jumps over <other>!");
          $self->display;
        }
      } else
      {
        $self->undisplay;
        $self->{location}{_collmap}[$self->{x}][$self->{y}] = 0;
        $self->{x} = $jox;
        $self->{y} = $joy;
        $self->{location}{_collmap}[$self->{x}][$self->{y}] = 1;
        $self->seen($t, "<self> fails to jump over <other>!");
        # check $t->pit
        $self->display;
      }
    } else
    {
      $self->seen($t, "<self> cannot jump through <other>.");
    }
    return 1;
  },


  'take_item' => sub
  {
    my $self = shift;
    return $self->pickup();
  },
  'drop_item' => sub
  {
    my $self = shift;
    my $q = $self->choose_item();
    if (defined($q))
    {
      if ($q)
      {
        my $c = 1;
        if ($q->{count} > 1)
        {
          $c = ::ask("Drop how many " . $q->plural . "? [$q->{count}]", 10, '[0-9]') || $q->{count};
        }
        if ($c == $q->{count})
        {
          $self->drop($q);
          $self->relieve($q);
          $self->seen($q, "<self> puts down <# other> here.");
        } elsif($c > 0 and $c < $q->{count})
        {
          my $r = $q->bunch($c);
          $q->{count} -= $c;
          $self->drop($r);
          $self->seen($r, "<self> puts down <# other> here.");
        }
      } else
      {
        $self->seen("<self> is already empty-handed.");
      }
    } else
    {
      $self->view;
      return 0;
    }
    $self->view;
    return 1;
  },
  'wield_item' => sub
  {
    my $self = shift;
    $self->wield;
    $self->view;
    return 1;
  },
  'unwield_item' => sub
  {
    my $self = shift;
    $self->unwield;
    $self->view;
    return 1;
  },
  'use_item' => sub
  {
    my $self = shift;
    my $q = $self->choose_item();
    if (defined($q))
    {
      if ($q)
      {
        $q->use($::leader);
      } else
      {
        $self->seen("<self> is not carrying any implements.");
      }
    } else
    {
      $self->view;
      return 0;
    }
    $self->view;
    return 1;
  },
  'throw_item' => sub
  {
    my $self = shift;
    my $q = $leader->choose_item();
    if (defined($q))
    {
      if ($q)
      {
        my $r; my $dmgscl = 1; my $verb = "throw"; my $with = "";
        if (defined $q->{aeroweight})
        {
          $r = int($leader->{op}{strength}/(log($q->{aeroweight}+2)));
        } else
        {
          $r = int($leader->{op}{strength}/(log($q->{weight}+2)));
        }
        if (defined $self->{$self->{domhand}})
        {
          my $b = $self->{$self->{domhand}};
          if (defined $b->{missiles} and $q->is($b->{missiles}))
          {
            $verb = "shoot";
            $with = " with the $b->{name}";
            $r *= $b->{missile_range_scale};
            $dmgscl = $b->{missile_damage_scale};
          }
        }
        my ($x, $y) = ::crosshairs($r);
        $self->relieve($q) if $q->usemissile($self);
        $q = $q->bunch(1);
        $self->seen($q, "<self> ${verb}s <other>${with}.");
        $q->{location} = $self->{location};
        my $a = $q->throw($x, $y, $r, $self);
        if (defined $a)
        {
          my $targ = 20;
          $targ = $a->{op}{dexterity} + 1 if $a->{op}{dexterity} > $targ;
          if ($a->{op}{dexterity} > ::d(1,$targ))
          {
            $a->seen($q, "<self> avoids being hit by <other>.");
            $a = undef;
          # todo: damage $q
          # if($h->{force}->is($Adj::explosion))  # or damage to item destroys it
          # {
          #  $q = undef;
          # }
          }
        }
        if (defined $a and $a ne $self) # with respect to thing thrown
        {
          my $h = $q->{projectile_attacks} || $q->{melee_attacks};
          my $k;
          foreach $k (@{$h})
          {
            my $od = $k->{force}{dice};
            $k->{force}{dice} = $k->{force}{dice}->improve_faces($dmgscl);
            # $a->seen('', ' is hit by ', $q, '.');
            $a->hurt($k, $self, $Distribution::bp{random}->pick);
            # todo: damage $q
            if($k->{force}->is($Adj::explosion))  # or damage to item destroys it
            {
              $q = undef;
            }
            $k->{force}{dice} = $od;
          }
        }
        if (defined $q)
        {
          unshift @{$self->{location}{map}[$q->{x}][$q->{y}]}, $q;
          $self->{location}->draw_cell($q->{x}, $q->{y});
          $q->{location} = $self->{location};
          ::script $q->{on_land}, $q, $a;
        }
      } else
      {
        $self->seen("<self> has nothing to throw.");
      }
    } else
    {
      $self->view;
      return 0;
    }
    $self->view;
    return 1;
  },
  'examine_item' => sub
  {
    my $self = shift;
    if ($self->{blind})
    {
      $self->seen($self, "<self> is blind.");
      return 1;
    }
    if (not $self->{lit})
    {
      $self->seen($self, "<self> cannot see in the dark.");
      return 1;
    }
    my $q = $self->choose_item();
    if (defined($q))
    {
      if ($q)
      {
        if ($q->is($Adj::magic) or $q->is($Adj::curse))  # and intelligence roll?
        {
          $self->seen($q, "<self> notices something odd about <other>.");
        } else
        {
          $self->seen($q, "<self> sees nothing unusual about <other>.");
        }
      } else
      {
        $self->seen("<self> has no belongings which to inspect.");
      }
    } else
    {
      $leader->view;
      return 0;
    }
    $leader->view;
    return 1;
  },
  'consume_item' => sub
  {
    my $self = shift;
    my $q = $self->choose_item($Adj::edible, $Adj::liquid);  # or medicine: consumable
    if (defined($q))
    {
      if($q)
      {
        $self->seen($q, "<self> consumes <other>.");
        $self->relieve($q) if $q->useup($self);
      } else
      {
        $self->seen("<self> is not carrying anything consumable.");
      }
    } else
    {
      $self->view;
      return 0;
    }
    $self->view;
    return 1;
  },
  'read_item' => sub
  {
    my $self = shift;
    if ($self->{blind})
    {
      $self->seen($self, "<self> is blind.");
      return 1;
    }
    if (not $self->{lit})
    {
      $self->seen($self, "<self> cannot see to read in the dark.");
      return 1;
    }
    my $q = $self->choose_item($Adj::written);
    if (defined($q))
    {
      if ($q)
      {
        if ($self->{confused})
        {
          $self->seen($q, "<self> cannot make sense of the runes on <other>.");
          return 1;
        }
        if ($q->{on_read})
        {
          ::script $q->{on_read}, $q, $self;
        } else
        {
          if ($self->{dumb})
          {
            $self->seen($q, "<self> cannot speak the runes on <other>.");
            return 1;
          }
          $self->relieve($q) if $q->useup($self);
        }
      } else
      {
        $self->seen("<self> is not carrying any reading material.");
      }
    } else
    {
      $self->view;
      return 0;
    }
    $self->view;
    return 1;
  },
  'halve_item' => sub          ### DEPRECATED... but you can still keymap to it if you want
  {
    my $self = shift;
    my $q = $self->choose_item();
    if (defined($q))
    {
      if ($q)
      {
        if ($q->{count} > 1)
        {
          my $p = $q->clone;
          my $n = $p->{count} / 2;
          if ($n == int($n))
          {
            $p->{count} = $n;
            $q->{count} = $n;
          } else
          {
            $p->{count} = int($n);
            $q->{count} = int($n+1);
          }
          push @{$self->{belongings}}, $p;
          $self->review('inventory');
        } else
        {
          $self->seen($q, "<self> cannot split up <a other>.");
        }
      } else
      {
        $self->seen("<self> is empty-handed.");
      }
    } else
    {
      $self->view;
      return 0;
    }
    $leader->view;
    return 1;
  },

  'look_around' => sub
  {
    my $self = shift;
    my $arg  = shift;
    my @c;
    if (defined $arg and ref($arg) eq 'ARRAY' and $#{$arg} > -1)
    {
      @c = ::direction($arg->[0]);
    } else
    {
      @c = ::dirpad(::getdir());
    }
    if ($self->{confused})
    {
      $self->seen("<self> cannot make sense of <his> surroundings.");
    } else
    {
      $self->look_dir(@c);
    }
    return 1;
  },
  'vandalize' => sub
  {
    my $self = shift;
    my $q = ::getdir();
    my $x; my $y; ($x, $y) = ::dirpad($q); $x += $self->{x}; $y += $self->{y};
    $self->{location}->gel($x,$y);
    my $t = $self->{location}->get_terrain($x,$y);
    if (not $t->{indestructible})  # should compare compositions of the terrain vs. your burin
    {
      my $x = ::ask('What shall ' . $self->{name} . ' write?',25)
              || ($self->{name} . " was here");
      $x .= '. ';
      $t->{graffiti} .= $x;
      $self->seen($t, "<self> carves '$x' into <other>.");
    } else
    {
      $self->seen($t, "<self> has no effect on <other>.");
    }
    return 1;
  },
  'pull' => sub
  {
    my $self = shift;
    my ($x, $y) = ::dirpad(::getdir());
    $x += $self->{x}; $y += $self->{y};
    $self->{location}->gel($x,$y);
    my $t = $self->{location}->get_terrain($x,$y);
    if (defined $t->{on_pull} and $t->{on_pull})
    {
      ::script $t->{on_pull}, $self, $t;
    } else
    {
      $self->seen($t, "<self> can find nothing to pull on <other>.");
    }
    return 1;
  },
  'push' => sub
  {
    my $self = shift;
    my ($x, $y) = ::dirpad(::getdir());
    $x += $self->{x}; $y += $self->{y};
    $self->{location}->gel($x,$y);
    my $t = $self->{location}->get_terrain($x,$y);
    if (defined $t->{on_push} and $t->{on_push})
    {
      ::script $t->{on_push}, $self, $t;
    } else
    {
      $self->seen($t, "<self> pushes <other> to no avail.");
    }
    return 1;
  },
  'bash' => sub
  {
    my $self = shift;
    my $arg = shift;
    my @c; my $dir;
    if (defined $arg and ref($arg) eq 'ARRAY' and $#{$arg} > -1)
    {
      $dir = $arg->[0];
      @c = ::direction($arg->[0]);
    } else
    {
      $dir = ::getdir();
      @c = ::dirpad($dir);
    }
    my ($x, $y) = @c;
    if ($self->{confused})
    {
      $x = 0; $y = 0; while ($x == 0 and $y == 0)
      {
        $x = ::d(1,3)-2;
        $y = ::d(1,3)-2;
      }
    }
    $x += $self->{x}; $y += $self->{y};
    $self->{location}->gel($x,$y);
    my $ac = $self->{location}->actor_at($x,$y);
    if (defined $ac)
    {
      $self->attack($ac);
    } else
    {
      my $t = $self->{location}->get_terrain($x,$y);
      my $a; my $ar = $self->{melee_attacks};
      $ar = $self->{$self->{domhand}}{melee_attacks}
        if defined $self->{$self->{domhand}};
      foreach $a (@{$ar})
      {
        last if not defined $t->{location};
        $t->hurt($a, $self, 'torso');
      }
    }
    return 1;
  },
  'open_or_close' => sub
  {
    my $self = shift;
    my ($x, $y) = ::dirpad(::getdir); $x += $self->{x}; $y += $self->{y};
    $self->{location}->gel($x,$y);
    my $t = $self->{location}->get_terrain($x,$y);
    if ($t->{on_open})
    {
      ::script $t->{on_open}, $t, $self;
      $t->{location}->draw_cell($t->{x}, $t->{y});
    } else
    {
      $self->seen("<self> can find nothing to open or close there.");
    }
    return 1;
  },
  'enter' => sub
  {
    my $self = shift;
    my $t = $self->{location}->get_terrain($self->{x},$self->{y});
    if ($t->{_to_new} ne '')
    {
      my $newr = $t->{_to_new};
      $::regcnt{$newr}++;
      my $nn = "$newr $::regcnt{$newr}";
      $::reg{$nn} = $::reg{$newr}->copy;
      $::reg{$nn}->{name} = $nn;
      # $::reg{$nn}->{dungeonlevel}++;
      $::reg{$nn}->{itemd}->scale(1.3);
      $::reg{$nn}->{monsterd}->scale(1.4);
      my $sx = $::reg{$nn}->{sizex};
      my $sy = $::reg{$nn}->{sizey};
      $x1 = ::d(1,$sx-2);
      $y1 = ::d(1,$sy-2);
      $t->{to} = $nn;
      $t->{to_x} = $x1;
      $t->{to_y} = $y1;
    }
    if ($t->{to} ne '')
    {
      my $rg = $self->{location};
      my $x2 = $self->{x};
      my $y2 = $self->{y};
      $self->seen($t, "<self> exits via <other>.");
      $rg->queue_follow($self, $::reg{$t->{to}}, $t->{to_x}, $t->{to_y});
      $rg->relieve($self);
      $::reg{$t->{to}}->enter($self, $t->{to_x}, $t->{to_y});
      if ($t->{_to_new} ne '')
      {
        my $q = $::reg{$t->{to}}->{apropos_exit} || $Terrain::ascending_staircase;
        $q = $q->clone;
        $q->{to} = $rg->{name};
        $q->{to_x} = $x2;
        $q->{to_y} = $y2;
        $q->{x} = $t->{to_x};
        $q->{y} = $t->{to_y};
        $q->{location} = $::reg{$t->{to}};
        $t->{to_x} = $self->{x};
        $t->{to_y} = $self->{y};
        unshift @{$::reg{$t->{to}}->{map}[$self->{x}][$self->{y}]}, $q;
        $t->{_to_new} = '';
      }
      $self->{location}->display($self);
      $self->display;
    } else
    {
      $self->seen($self, "<self> can find no portal to enter.");
    }
    return 1;
  },
  'search' => sub
  {
    my $self = shift;
    my $i = 0; my $j = 0; my $t; my $f = 0;
    for($j = -1; $j <= 1; $j++)
    {
      for($i = -1; $i <= 1; $i++)
      {
        next if not $self->in_bounds($self->{x}+$i,$self->{y}+$j);
        $self->{location}->gel($self->{x}+$i,$self->{y}+$j);
        $t = $self->{location}->get_terrain($self->{x}+$i,$self->{y}+$j);
        if (defined $t->{conceals} and $t->{conceals} > 0)
        {
          my $r = ::d(1, 30) + $self->{op}{intelligence};
          if ($r >= $t->{conceals})
          {
            ::script $t->{on_reveal}, $t;
            $f = 1;
          }
        }
      }
    }
    if (not $f)
    {
      $self->seen("<self> searches the area but finds nothing interesting.");
    } else
    {
      $self->seen("<self> seems to have uncovered something!");
    }
    return 1;
  },

  'use_talent' => sub
  {
    my $self = shift;
    my $q = $self->choose_talent('');
    if (defined($q))
    {
      if ($q)
      {
        $q->use($self);
      } else
      {
        $self->seen("<self> possesses no talents of note.");
      }
    } else
    {
      $self->view;
      return 0;
    }
    $self->view;
    return 1;
  },

  'trade_places' => sub
  {
    my $self = shift;
    my ($x, $y) = ::dirpad(::getdir()); $x += $self->{x}; $y += $self->{y};
    $self->{location}->gel($x,$y);
    my $q = $self->{location}->actor_at($x,$y);
    if (defined $q)
    {
      if (defined $q->{party} and defined $self->{party} and $q->{party} eq $self->{party})
      {
        # little cheat, we don't have to change the _collmap.
        my $x = $self->{x}; my $y = $self->{y};
        $self->{x} = $q->{x}; $self->{y} = $q->{y};
        $q->{x} = $x; $q->{y} = $y;
        $self->display;
        $q->display;
        return 1;
      } else
      {
        $q->seen($self, "<self> resists being shoved around by <other>!");
        return 1;
      }
    }
    $self->seen("<self> sees no-one there.");
    return 1;
  },

  'sleep' => sub
  {
    my $self = shift;
    # todo: check comfort level of location
    $self->seen("<self> can't seem to get to sleep here.");
    # todo: $self->{asleep} = 1;
    return 1;
  },

  'interact' => sub
  {
    my $self = shift;
    my $arg = shift;
    my @c; my $dir;
    if (defined $arg and ref($arg) eq 'ARRAY' and $#{$arg} > -1)
    {
      $dir = $arg->[0];
      @c = ::direction($arg->[0]);
    } else
    {
      $dir = ::getdir();
      @c = ::dirpad($dir);
    }
    my ($x, $y) = @c; $x += $self->{x}; $y += $self->{y};
    my $q = $self->{location}->actor_at($x,$y);
    if (defined $q)
    {
      if ($self->{confused})
      {
        $self->seen("<self> can only manage to babble incoherently.");
        return 1;
      }
      # if ($q eq $self) { carp "Weird: cannot interact with yourself"; }
      if ($self eq $::leader and defined $q->{encounter})
      {
        my $e = $q->{encounter} || Encounter->new->auto($q);
        $e->begin($q);
        return 1;
      } elsif (defined $q->{on_interact} and $q->{on_interact})
      {
        ::script $q->{on_interact}, $self, $q;
        return 1;
      } else
      {
        my $e = Encounter->new->auto($q);
        $e->begin($q);
        return 1;
      }
    }
    $self->seen("<self> sees no-one there.");
    return 1;
  },

  'destroy_item' => sub
  {
    my $self = shift;
    my $q = $self->choose_item();
    if (defined($q))
    {
      if ($q)
      {
        if ($q->{count} > 1)
        {
          my $r = $q->bunch(1);
          $q->{count} -= 1;
          push @{$self->{belongings}}, $q = $r;
        }
        my $a; my $ar = $self->{melee_attacks};
        $ar = $self->{$self->{domhand}}{melee_attacks}
          if defined $self->{$self->{domhand}};
        foreach $a (@{$ar})
        {
          last if not defined $q->{location};
          $q->hurt($a, $self, 'torso');
        }
        if ($q->{condition} <= 0)
        {
          $self->relieve($q);
        }
        $self->view;
        return 1;
      } else
      {
        $self->seen("<self> has no possessions to destroy.");
        return 1;
      }
    }
    return 0;
  },

  'switch_stance' => sub
  {
    my $self = shift;
    if (not $self->{ambidextrous})
    {
      $self->seen("<self> isn't ambidextrous.");
      return 0;
    }
    if ($self->{domhand} eq 'rhand')
    {
      $self->{domhand} = 'lhand';
      $self->seen("<self> is now fighting left-handed.");
      $self->review('impression');
      return 1;
    }
    if ($self->{domhand} eq 'lhand')
    {
      $self->{domhand} = 'rhand';
      $self->seen("<self> is now fighting right-handed.");
      $self->review('impression');
      return 1;
    }
    return 0;
  }
);

1;
