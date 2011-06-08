package Item;

## MODIFIERS

sub fine
{
  my $self = shift;
  my $n = $self->copy;
  $n->{identity} = "fine $n->{identity}";
  $n->{melee_attacks}[0]{force}{dice}->improve(+1);
  $n->{projectile}{dice}->improve(+1) if defined $n->{projectile};
  $n->{_defense}++ if exists $n->{_defense} and $n->{_defense} > 0;
  return $n;
}

sub crude
{
  my $self = shift;
  my $n = $self->copy;
  $n->{identity} = "crude $n->{identity}";
  $n->{melee_attacks}[0]{force}{dice}->improve(-1);
  $n->{projectile}{dice}->improve(-1) if defined $n->{projectile};
  $n->{_defense}-- if exists $n->{_defense} and $n->{_defense} > 0;
  return $n;
}

sub cursed
{
  my $self = shift;
  my $level = shift || 1;
  my $n = $self->copy;
  $n->{identity} =~ s/mundane //;
  $n->{identity} = "cursed $n->{identity}";
  $n->{melee_attacks}[0]{force}{dice}->improve(-$level);
  $n->{projectile}{dice}->improve(-$level) if defined $n->{projectile};
  $n->implies($Adj::curse);
  $n->{melee_attacks}[0]{force}->implies($Adj::curse);
  return $n;
}

sub magicked
{
  my $self = shift;
  my $level = shift || 1;
  my $n = $self->copy;
  $n->{identity} =~ s/mundane //;
  $n->{identity} = "$n->{identity} +$level";
  # print $n->{identity}, " ";
  $n->{melee_attacks}[0]{force}{dice}->improve(+$level);             # should actually add another force
  $n->{projectile_attacks}[0]{force}{dice}->improve(+$level) if defined $n->{projectile_attacks}[0];
  $n->{_defense} += $level if exists $n->{_defense} and $n->{_defense} > 0;
  $n->implies($Adj::magic);
  $n->{melee_attacks}[0]{force}->implies($Adj::magic);
  return $n;
}

sub enchant
{
  my $self = shift;
  my $t = shift;
  my $charges = shift || 1;
  my $i = $self->copy;
  $i->{identity} =~ s/mundane //;
  $i->{identity} =~ s/blank //;
  $i->{identity} = "$i->{identity} of $t->{name}";
  $i->{talent} = $t;
  $i->{charges} = $charges;
  $i->implies($Adj::magic);
  $i->{melee_attacks}[0]{force}->implies($Adj::magic); # if ref($n->{melee_attacks}[0]{damage}) eq 'Force';
  return $i;
}

sub red_hot
{
  my $self = shift;
  my $level = shift || 1;
  my $n = $self->copy;
  $n->{color} = 'red';
  $n->{identity} = "red hot $n->{identity}";
  $n->{melee_attacks}[0]{force}{dice}->improve(+1);
  $n->{melee_attacks}[0]{force}->implies($Adj::heat);
  return $n;
}

sub capture
{
  my $self = shift;
  my $s = shift;
  my $n = $self->copy;
  $n->{soul} = $s;
  $n->{identity} = $s->{name} . ' card';
  $n->implies($Adj::magic);
  return $n;
}

sub camoflaged
{
  my $self = shift;
  my $s = shift;
  my $n = $self->copy;
  $n->{soul} = $s;
  $n->{identity} = $s->{name} . ' camoflaged as ' . $n->{identity};
  $n->{on_pickup} = <<'END';
  {
    my ($self, $other) = @_;
    my $s = $self->{soul}->clone;
    $s->prep;
    $s->{target} = $other;
    $other->{location}->enter($s, $other);
    $self->seen($s, "<self> turns out to be <a other> in camoflage!");
    return 0;
  }
END
  return $n;
}

### for worn things

sub ofstat
{
  my $self = shift;
  my $stat = shift;
  my $s    = shift || +1;
  my $n = $self->copy;
  $n->{identity} =~ s/mundane //;
  $n->{identity} .= " of $stat +$s";
  $n->{on_wear} .= <<'END';
  {
     my ($self, $actor, $delta) = @_;
     $actor->{max}{XXX} += $delta * YYY;
     $actor->review('status');
     @_ = ($self, $actor, $delta);
  }
END
  $n->{on_wear} =~ s/XXX/$stat/s;
  $n->{on_wear} =~ s/YYY/$s/s;
  return $n;
}

sub oftalent
{
  my $self = shift;
  my $talstr = shift;
  my $talent = eval $talstr;
  my $s    = shift || +25;
  my $n = $self->copy;
  $n->{identity} =~ s/mundane //;
  $n->{identity} .= " of " . $talent->{name} . " +$s";
  $n->{on_wear} .= <<'END';
  {
     my ($self, $actor, $delta) = @_;
     $actor->learn(XXX, YYY * $delta);
     @_ = ($self, $actor, $delta);
  }
END
  $n->{on_wear} =~ s/XXX/$talstr/gs;
  $n->{on_wear} =~ s/YYY/$s/gs;
  return $n;
}

sub ofresist
{
  my $self = shift;
  my $element = shift;
  my $s    = shift || +25;
  my $n = $self->copy;
  $n->{identity} =~ s/mundane //;
  $n->{identity} .= " of resist $element +$s";
  $n->{on_wear} .= <<'END';
  {
     my ($self, $actor, $delta) = @_;
     $actor->alter_resistances(XXX, YYY * $delta);
     @_ = ($self, $actor, $delta);
  }
END
  $n->{on_wear} =~ s/XXX/$element/gs;
  $n->{on_wear} =~ s/YYY/$s/gs;
# print $n->{on_wear}; # sleep 30;
  return $n;
}

1;
