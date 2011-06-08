package Attack;

$flame    = Attack->new('attemptverb' => 'singes',
                        'successverb' => 'burns',
                        'force' => Force->new(Dice->new(1,3), $Adj::fire),
                        'followup' => 1,
);

$bee_sting = Attack->new('attemptverb' => 'lunges at',
                         'successverb' => 'stings',
                         'force' => Force->new(Dice->new(1,2), $Adj::piercing, $Adj::bone),
                         'accuracy' => -2,
                         'on_strike' => <<'END',
{
  my ($self, $attacker, $victim) = @_;
  $victim->adjust('strength',-(::d(1,2)-1),'bee sting');
  $victim->review('status');
  $victim->seen("<self> shudders in pain.");
  $self->{force} = Force->new(Dice->new(1,6,-5), $Adj::crushing, $Adj::flesh);
  $self->{successverb} = 'bumps';
  $self->{on_strike} = '';
  @_ = ($self, $attacker, $victim);
}
END
);

$talon    = Attack->new('attemptverb' => 'swipes at',
                        'successverb' => 'digs into',
                        'force' => Force->new(Dice->new(1,1), $Adj::piercing, $Adj::bone),
);

$beak     = Attack->new('attemptverb' => 'pecks at',
                        'successverb' => 'pecks into',
                        'force' => Force->new(Dice->new(1,2), $Adj::piercing, $Adj::bone),
                        'autofollow' => 2,
);

$insect_kick = Attack->new('attemptverb' => 'leaps at',
                        'successverb' => 'kicks',
                        'force' => Force->new(Dice->new(1,2,-1), $Adj::crushing, $Adj::flesh),
);

$cat_bite = Attack->new('attemptverb' => 'tries to bite',
                        'successverb' => 'bites',
                        'force' => Force->new(Dice->new(1,2), $Adj::piercing, $Adj::bone),
);

$cat_claw = Attack->new('attemptverb' => 'swipes at',
                        'successverb' => 'claws',
                        'force' => Force->new(Dice->new(1,1), $Adj::piercing, $Adj::bone),
);

$bear_claw = Attack->new('attemptverb' => 'swipes at',
                         'successverb' => 'mauls',
                         'force' => Force->new(Dice->new(1,2), $Adj::piercing, $Adj::bone),
);

$bear_hug  = Attack->new('attemptverb' => 'tries to crush',
                         'successverb' => 'hugs',
                         'force' => Force->new(Dice->new(2,3,+1), $Adj::flesh, $Adj::crushing),
                         'autofollow' => 2,
);

$gator_grip = Attack->new('attemptverb' => 'gnashes at',
                          'successverb' => 'clamps down on',
                          'force' => Force->new(Dice->new(3,2,+1), $Adj::bone, $Adj::crushing),
                          'accuracy' => +1,
);


$sylvan_snake_bite = Attack->new('successverb' => 'bites',
                         'attemptverb' => 'lashes out at',
                         'force' => Force->new(Dice->new(1,1), $Adj::bone, $Adj::piercing),
                         'on_strike' => <<'END',
{
  my ($self, $attacker, $victim) = @_;
  if (::d(1,3)==1)
  {
    my $poison = $Talent::orange_poison->clone;
    $poison->poison($victim);
  }
  @_ = ($self, $attacker, $victim);
}
END
);

$blue_spider_bite = Attack->new('successverb' => 'bites',
                         'attemptverb' => 'crawls on',
                         'force' => Force->new(Dice->new(1,1), $Adj::bone, $Adj::piercing),
                         'accuracy' => -2,
                         'on_strike' => <<'END',
{
  my ($self, $attacker, $victim) = @_;
  if (::d(1,20)==1)
  {
    my $poison = $Talent::death_poison->clone;
    $poison->poison($victim);
  }
  @_ = ($self, $attacker, $victim);
}
END
);

$punch = Attack->new('attemptverb' => 'swings at',
                     'successverb' => 'punches',
                     'force' => Force->new(Dice->new(1,1), $Adj::flesh, $Adj::crushing),
);

$branch_rake = Attack->new('attemptverb' => 'rakes',
                     'successverb' => 'scrapes',
                     'force' => Force->new(Dice->new(1,2), $Adj::wood, $Adj::crushing),
);

$icy_touch = Attack->new('attemptverb' => 'tries to touch',
                     'successverb' => 'touches',
                     'force' => Force->new(Dice->new(1,3,+1), $Adj::flesh, $Adj::cold),
);

$dog_bite = Attack->new('attemptverb' => 'gnashes at',
                        'successverb' => 'bites',
                        'force' => Force->new(Dice->new(1,3), $Adj::bone, $Adj::cutting));

$skull_ram = Attack->new('attemptverb' => 'flies at',
                         'successverb' => 'rams',
                         'force' => Force->new(Dice->new(1,1), $Adj::bone, $Adj::magic),
);

$bone_punch = Attack->new('attemptverb' => 'swings at',
                     'successverb' => 'punches',
                     'force' => Force->new(Dice->new(1,1), $Adj::bone, $Adj::crushing),
);

1;
