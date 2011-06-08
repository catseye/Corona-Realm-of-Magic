
%::meta =
(
  'preferences' => sub
  {
    my $self = shift;
    preferences();
    $self->view;
    return 0;
  },
  'save_game' => sub
  {
    my $self = shift;
    my $t;
    my $fn = ::ask("File name (without extension)?", 20);
    ::msg("Saving '$fn.rpg', please wait...");
    ::clrmsg();
    $t = time;
    open(FILE, ">$fn.rpg");
    print FILE "\$::leader = \n";
    $::saved_objects = 0;
    $self->save('::FILE');
    print FILE "\$::leader->{location} = \n";
    $self->{location}->save('::FILE');
    $party->save('::FILE');
    print FILE "1; 1;\n";
    close(FILE);
    # system("gzip -a -9 $fn.rpg");
    $t = time - $t; $t = 1 if $t <= 0;
    my $r = sprintf("%3.2f", $::saved_objects/$t);
    ::msg("Done, saved $::saved_objects objects in $t seconds ($r obj/sec.)");
    return 0;
  },
  'load_game' => sub
  {
    my $self = shift;
    my $fn = ::ask("File name (without extension)?", 20);
    ::msg("Loading '$fn.rpg', please wait...");
    ::clrmsg();
    # system("gzip -d -a $fn.rpz");
    my $t = time;
    my $q = do "$fn.rpg"; # yoiks!
    if (not defined $q)
    {
      ::msg("Error: $@");
    }
    # system("gzip -a -9 $fn.rpg");

    # this has to be handled better in the future!

    {
      my $i = 0; my $j = 0; my $k = 0;
      for($i = 0; $i < $::leader->{location}{sizex}; $i++)
      {
        for($j = 0; $j < $::leader->{location}{sizey}; $j++)
        {
          $::leader->{location}{_collmap}[$i][$j] = 0;
          if ($::leader->{location}{gelled}[$i][$j])
          {
            for($k = 0; $k <= $#{$::leader->{location}{map}[$i][$j]}; $k++)
            {
              $::leader->{location}{map}[$i][$j][$k]->{location} = $::leader->{location};
            }
          }
        }
      }
    }

    my $a;
    foreach $a (@{$::leader->{location}->{actors}})
    {
      $a->{location} = $::leader->{location};
      $::leader->{location}{_collmap}[$a->{x}][$a->{y}] = 1;
    }
    $::leader->{location}->enter($::leader,$::leader->{x},$::leader->{y});

    $t = time - $t; $t = 1 if $t <= 0;
    ::msg("Done, loaded '$fn.rpg' in $t seconds.");

    $::leader->{location}->display($::leader);

    $::leader->view;
    return 0;
  },
  'quit_game' => sub
  {
    my $self = shift;
    # are you sure?
    $quit_flag = 1;
    return 1;
  },

  'help' => sub
  {
    my $self = shift;
    ::clrscr;
    ::game_frame;
    ::color('yellow','black');
    ::center_text(2,"Corona: Realm of Magic --- Help Screen");  # should be game title ***
    ::color('white','black');
    ::center_text(4,"  $::padmap->[0][0] $::padmap->[0][1] $::padmap->[0][2]                               ESC ESC Show Menu   ");
    ::center_text(5,"  $::padmap->[1][0] $::padmap->[1][1] $::padmap->[1][2]  Move/Attack                  $::extkey       Command Line");
    ::center_text(6,"  $::padmap->[2][0] $::padmap->[2][1] $::padmap->[2][2]                               $::helpkey       Show Help   ");
    ::color('grey','black');
    my $c; my @s;
    my $kline = sub
    {
      my $c = shift;
      my $o = shift;
      my $q = $::keymap{chr($c+$o)};
      my $mn = $::mnemonic{chr($c+$o)};
      if (defined $q)
      {
        my $o = $q;
        $q =~ s/\_/ /g;
        $q =~ s/(\W)(\w)/$1 . uc $2/ge;
        $q =~ s/^(\w)/uc $1/ge;
        $o =~ s/^(\w+)\s+.*?$/$1/;
        $q = $mn if defined $mn;
        if (exists $::action{$o})
        {
          $q = " $q";
          ::color('white','black');
        } else
        {
          $q = "*$q";
          ::color('grey','black');
        }
      } else
      {
        $q = "*(unbound)";
        ::color('grey','black');
      }
      my $d = ' ' . chr($c+$o);
      $d = "^" . chr(ord('@')+$c+$o) if $c+$o < 32;
      ::display($d . ::fitpad($q, 17));
      return "";
    };
    for($c = 0; $c <= 12; $c++)
    {
      ::gotoxy(2,$c+8);
      ::display(&$kline($c,ord('a')) .
                &$kline($c,ord('n')) .
                &$kline($c,ord('A')) .
                &$kline($c,ord('N')));
    }
    ::color('grey','black');
    ::gotoxy(2,22);
    ::display(' * = unimplemented');
    ::gotoxy(1,$::setup{screen_height});
    ::display('Press any key to continue: ');
    my $q = getkey();
# display next page
    for($c = 0; $c <= 12; $c++)
    {
      ::gotoxy(2,$c+8);
      ::display(&$kline($c,1) .
                &$kline($c,14) .
                &$kline($c,ord(' ')) .
                &$kline($c,ord('0')));
    }
    ::gotoxy(1,$::setup{screen_height});
    ::display('Press any key to continue: ');
    $q = getkey();
    $self->{location}->display($self);
    $self->view;
    return 0;
  },
  'redraw_screen' => sub
  {
    my $self = shift;
    $self->{location}->display($self);
    $self->view;
    return 0;
  },
  'review_messages' => sub
  {
    my $self = shift;
    my $i = $#message;
    my $s = 24;
    ::clrscr;
    ::color('white', 'black');

    my $t;
    while ($i >= 0 and $s > 1)
    {
      $t = ::wordwrap($message[$i], $::setup{screen_width}-1);
      while ($s >= 1 and $#{$t} > -1)
      {
        ::gotoxy(1, $s);
        ::display(::fitpad(pop @{$t},$::setup{screen_width}-1));
        $s--;
      }
      $i--;
    }
    while ($s >= 1)
    {
      ::gotoxy(1, $s);
      ::display(::fitpad(' ', $::setup{screen_width}-1));
      $s--;
    }
    # @message = $message[$i .. $#message];

    ::gotoxy(1,$::setup{screen_height});
    ::color('grey', 'black');
    ::display("[Press Any Key to Continue] ");
    ::getkey;

    $self->{location}->display($self);
    $self->view;
    return 0;
  },
  'debug' => sub
  {
    my $self = shift;
    my @l = @{$::fuses->{list}};
    my $i;
    for($i=0;$i<=$#l;$i++)
    {
      ::gotoxy(1,$i+1);
      ::display($l[$i]{length});
      ::gotoxy(10,$i+1);
      ::display(join(',', @{$l[$i]{args}}));
    }
    ::gotoxy(1,$::setup{screen_height});
    ::color('grey', 'black');
    ::display("[Press Any Key to Continue] ");
    ::getkey;

    $self->{location}->display($self);
    $self->view;
    return 0;
  },

  'view' => sub
  {
    my $self = shift;
    my $arg  = shift;
    if (defined $arg and ref($arg) eq 'ARRAY' and $#{$arg} > -1)
    {
      $self->view($arg->[0]);
    } else
    {
      # pop up menu asking for view
    }
    return 0;
  },
  'what_is' => sub
  {
    my $self = shift;
    my @at = ::crosshairs(); my $x;
    $at[0] += $self->{x};
    $at[1] += $self->{y};
    my $a = $self->{location}->actor_at(@at);
    my $i = $self->{location}->get_top(@at);
    my $t = $self->{location}->get_terrain(@at);
    if (not $self->{location}{lit}[$at[0]][$at[1]])
    {
      ::msg("That is darkness.");
    }
    elsif (defined $a)
    {
      ::msg("That is a " . $a->{name} . " on a " . $t->{name} . ".");
    } elsif ($i eq $t)
    {
      ::msg("That is a " . $t->{name} . ".");
    } else
    {
      ::msg("That is a " . $i->{name} . " on a " . $t->{name} . ".");
    }
    return 0;
  },

  'bind' => sub
  {
    my $self = shift;
    my $arg  = shift;
    my ($a, $b);
    if (defined $arg and ref($arg) eq 'ARRAY' and $#{$arg} > -1)
    {
      $a = shift @{$arg};
      $b = join(' ', @{$arg});
    } else
    {
      ::msg("Press key to bind:");
      $a = ::getkey();
      $b = ::ask("Command (long form)?", 59, '[\S ]');
    }
    $::keymap{$a} = $b;
    ::msg("Key '$a' bound to command '$b'.");
    return 0;
  },
  'switch_leader' => sub
  {
    my $self = shift;
    my $p = $self->{party};
    my @r = @{$p->{actors}};
    my $r;
    foreach $r (@r) { $r = $r->{name}; }
    $::leader = Menu->new('value'  => [@{$p->{actors}}],
                          'cancel' => $::leader,
                          'label'  => [@r])->pick;
    $::leader->{location}->display($::leader);
    $::leader->view('character');
    return 0;
  },
  'name_creature' => sub
  {
    my $self = shift;
    my @at = ::crosshairs(); my $x;
    $at[0] += $self->{x};
    $at[1] += $self->{y};
    my $a = $self->{location}->actor_at(@at);
    if (not $self->{location}{lit}[$at[0]][$at[1]])
    {
      ::msg("Only darkness there.");
    }
    elsif (defined $a)
    {
      if ($a->{proper})
      {
        ::msg("$a->{name} already has a given name.");
      } else
      {
        my $d = $a->{name};
        $a->{name} = ::ask("What do you want to call the $a->{name}?", 30) || $a->{name};
        $a->{proper} = 1 if $d ne $a->{name};
        $a->seen("The $d is now called <self>.");  # msg?
      }
    } else
    {
      ::msg("No-one there to name.");
    } 
    return 0;
  },
  'name_item' => sub
  {
    my $self = shift;
    my $i = $self->choose_item;
    $self->view;
    return 0 if not defined $i or not $i;
    $i->{monogram} = ::ask("What do you want to call the $i->{name}?", 1) || '';
    $i->seen("<self> is now associated with the letter '$i->{monogram}' in menus.") if $i->{monogram};
    $i->seen("<self> is no longer associated with any particular letter in menus.") if not $i->{monogram};
    return 0;
  },
  'repeat_action' => sub
  {
    my $self = shift;
    ::msg("Press key to repeat:");
    clrmsg();
    my $char = ::getkey;

    if (not exists $::keymap{$char})
    {
      my $z = $char;
      $z = 'Tab' if ord($z) == 9;
      $z = 'LF' if ord($z) == 10;
      $z = 'FF' if ord($z) == 12;
      $z = 'CR' if ord($z) == 13;
      ::msg("Key '$z' (" . ord($char) . ") is not currently bound to any command.  Press '$::helpkey' for help.");
    } else
    {
      $::repeated_action = $::keymap{$char};
    }
    return 0;
  },
);

1;
