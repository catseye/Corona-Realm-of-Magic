### RANGER

$identify_food = Talent->new('name'       => 'identify food',
                             'type'       => 'skill',
                             'onitem'     => 1,
                       'on_perform'=> <<'END',
    my ($self, $target, $talent) = @_;
    if (ref($target) eq 'Item' and $target->{food})
    {
      $self->relieve($target);
      $target->identify;
      my $x;
      foreach $x (@{$self->{belongings}})
      {
        if ($target->combinable($x))
        {
          $x->{count} += $target->{count};
          $self->review('inventory');
          $self->seen($target, "<self> identifies <other>.");
          return;
        }
      }
      push @{$self->{belongings}}, $target;
      $self->seen($target, "<self> identifies <other>.");
    } else
    {
      $self->seen($target, "<self> cannot seem to identify <other>.");
    }
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 0;
END
);

### MENTOR

sub train
{
  my $guild = shift;
  my $level = shift;

  my $self = Talent->new('name'       => "train $guild ($level)",
                         'type'       => 'skill',
                         'verbal'     => 1,
                         'somatic'    => 1,
                         'range'      => 1,
                         # 'moves'      => 30,
                         'on_perform' => <<'END',
    my ($self, $target, $talent) = @_;
    my $guild = 'XXX'; my $level = YYY;
    if (ref($target) eq 'Actor')
    {
      if (($target->{standing}{$guild} || 0) == $level-1)
      {
        my $p = $::guild->{$guild}->{basex};
        my $l = $level;
        while ($l > 1)
        {
          $l--;
          $p *= 2;
        }
        if ($target->{experience} >= $p)
        {
          $target->{experience} -= $p;
          $target->{spent_experience} += $p;
          $target->{standing}{$guild}++;

          my @a = ("Improve $::guild->{$guild}{prime}");
          my @b = ($::guild->{$guild}{prime});
          push @a, "Improve $::guild->{$guild}{second}" if defined $::guild->{$guild}{second};
          push @b, $::guild->{$guild}{second} if defined $::guild->{$guild}{second};

          my $i;
          for($i=0;$i<=$#{$::guild->{$guild}{skill}};$i+=2)
          {
            push @a, "Learn $::guild->{$guild}{skill}[$i]->{name}"
              if $::guild->{$guild}{skill}[$i+1] <= $level;
            push @b, $::guild->{$guild}{skill}[$i]
              if $::guild->{$guild}{skill}[$i+1] <= $level;
          }

          my $re = Menu->new('cancel'=>undef,
                             'display_help' => 1,
                             'value'=>[@b],
                             'label'=>[@a])->pick;

          if (ref($re) eq 'Talent')
          {
            my $bonus = int($target->{op}{intelligence} / 6);
            $target->seen("<self> learns how to perform $re->{name}.");
            $target->learn($re, ::d(3,6)+$bonus);
          } else
          {
            $target->seen("<self>'s $re increases.");
            $target->{max}{$re}++;
          }
          $target->seen("<self> is now a level $level $guild.");
        } else
        {
          my $q = $p - $target->{experience};
          $target->seen("<self> will require $q more experience points.");
          $::full_refund = 1;
        }
      } else
      {
        my $e = $level-1;
        if ($e)
        {
          $target->seen("<self> must be a level $e $guild to train.");
        } else
        {
          $target->seen("<self> must be a potential initiate to the $guild guild to train.");
        }
        $::full_refund = 1;
      }
    } else
    {
      $self->seen($target, "It seems <other> cannot be trained by <self>.");
      $::full_refund = 1;
    }
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 0;
END
  );
  $self->{on_perform} =~ s/XXX/$guild/s;
  $self->{on_perform} =~ s/YYY/$level/s;
  return $self;
}

# Talent::train('cleric',4);

### FIGHTER

$stretching_exercises = Talent->new('name'=> 'stretching exercises',
                             'type'       => 'skill',
                             'somatic'    => 1,
                             'moves'      => 3,
                       'on_perform'=> <<'END',
    my ($self, $target, $talent) = @_;
    $self->adjust('dexterity',::d(1,2)+1,$self);
    $self->seen($self, "<self> limbers up.");
    $self->review('status');
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) < 8
                                           and $caster->dist($caster->{target}) > 3;
    return 0;
END
);

$calisthenics =  Talent->new('name'       => 'calisthenics',
                             'type'       => 'skill',
                             'somatic'    => 1,
                             'moves'      => 3,
                       'on_perform'=> <<'END',
    my ($self, $target, $talent) = @_;
    $self->adjust('strength',::d(1,2),$self);
    $self->adjust('dexterity',::d(1,2),$self);
    $self->seen($self, "<self> works out.");
    $self->review('status');
END
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 1 if defined($caster->{target}) and $caster->dist($caster->{target}) < 8
                                           and $caster->dist($caster->{target}) > 3;
    return 0;
END
);

sub weapon_proficiency
{
  my $item = shift;
  my $adj; my $n = '';
  foreach $adj (@{$item->{implies}})
  {
    $n .= $adj->{name} . ' ' if $adj->is($Adj::weapon);
  }
  my $self = Talent->new('name' => $n . 'proficiency',
                                   'type'    => 'reflex',
                                   'somatic' => 1,
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 0;
END
                                  );
  return $self;
}

sub armour_proficiency
{
  my $part = shift;
  my $self = Talent->new('name' => "cover $part",
                                   'type'    => 'reflex',
                                   'somatic' => 1,
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 0;
END
                                  );
  return $self;
}

sub magic_theory
{
  my $sphere = shift;
  my $self = Talent->new('name' => "magic theory ($sphere)",
                                   'type'    => 'reflex',
                       'on_consider'=> <<'END',
    my ($self, $caster) = @_;
    return 0;
END
                                  );
  return $self;
}

### THIEF

# hide in shadows

# pick pockets

# etc

1;
