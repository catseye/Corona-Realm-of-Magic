package Item;

### WANDS

$wand   =    Item->new('name' => 'stick',
                       'identity' => 'wand',
                       'appearance' => 'stick',
                       'color' => 'brown',
                       'weight' => 2,
                       'talent' => undef,
                       'charges' => 0,
                       'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2,-1), $Adj::crushing), ],
                      );

$staff  =    Item->new('name' => 'staff', # weapon, cudgel?
                       'identity' => 'staff',
                       'appearance' => 'stick',
                       'color' => 'brown',
                       'weight' => 8,
                       'talent' => undef,
                       'charges' => 0,
                       'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,1), $Adj::crushing), ],
                      );

$sceptre =   Item->new('name' => 'staff',
                       'identity' => 'sceptre',
                       'appearance' => 'stick',
                       'color' => 'grey',
                       'weight' => 5,
                       'talent' => undef,
                       'charges' => 0,
                       'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,1), $Adj::crushing), ],
                      );

$rod = Item->new('name' => 'rod',
                 'identity' => 'rod',
                 'appearance' => 'stick',
                 'weight' => 3,
                 'melee_attacks' => [ Attack->weapon(0, Dice->new(1,2), $Adj::crushing), ],
                );

$sphere = Item->new('name' => 'stone',
                 'identity' => 'sphere',
                 'appearance' => 'stone',
                 'weight' => 2,
                 'melee_attacks' => [ Attack->weapon(0, Dice->new(1,1), $Adj::crushing), ],
                );

### SCROLLS

$blank_scroll = Item->new('name' => 'scroll',
                          'identity' => 'blank scroll',
                          'appearance' => 'scroll',
                          'color' => 'white',
                          'weight' => 1,
                          'talent' => undef,
                          'charges' => 1,
                          'written' => 1,
                          'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2,-1), $Adj::wood, $Adj::cutting), ],
                          )->implies($Adj::written);

$blank_card = Item->new('name' => 'card',
                          'isa' => 'card',
                          'identity' => 'blank card',
                          'appearance' => 'scroll',
                          'color' => 'white',
                          'weight' => 1,
                          'charges' => 1,
                          'melee_attacks' => [ Attack->weapon(0, Dice->new(1,3,-2), $Adj::wood, $Adj::cutting), ],
                          'on_land' => <<'END',
  my ($self, $victim) = @_;
  my $s = $self->{soul};
  if (defined $s)
  {
    $self->{soul} = undef;
    $self->{name} = 'card';
    $self->{identity} = 'blank card';
    $s->heal_all;
    $s->{target} = $victim;
    $self->{location}->enter($s, $self->{x}, $self->{y});
    $s->seen($self, "<self> emerges from <other>!");
  }
END
                          )->implies($Adj::card);

$blank_manual = Item->new('name' => 'manual',
                          'identity' => 'blank manual',
                          'appearance' => 'scroll',
                          'color' => 'white',
                          'weight' => 100,
                          'written' => 1,
                          'charges' => 4,
                          'melee_attacks' => [ Attack->weapon(-1, Dice->new(1,2), $Adj::wood, $Adj::crushing), ],
                          'on_read' => <<'END',
  my ($self, $reader) = @_;
  my $t;
  if ($t = $reader->has($self->{talent}))
  {
    if ($t->{prof} > 12)
    {
      $reader->seen($self, "<self> can learn no more from <other>.");
    } else
    {
      $t->{prof} += ::d(1,4);
      $reader->seen($self->{talent}, "<self> learns something new about <other>!");
    }
  } else
  {
    # make intelligence roll...
    $reader->learn($self->{talent}, ::d(2,6));
    $reader->seen($self->{talent}, "<self> acquires the talent of <other>!");
  }
END
                          )->implies($Adj::written);

1;
