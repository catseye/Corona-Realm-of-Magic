# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see file LICENSE for more info.

package Talent;

### BUILT IN POISONS ###

$orange_poison  = Talent->new('name'       => 'orange poison',
                              'type'       => 'poison',
                              'on_perform' => <<'END',
  {
    my ($self, $target, $talent) = @_;
    $target->seen($talent, "<self> is poisoned with <other>!");
    $target->adjust('strength',-1,$talent);
    $::fuses->add(<<'END_FUSE', ::d(1,6,+1), [$target, $talent]);
    {
      my ($target, $talent) = @_;
      my $r = ::d(1,6,+2);
      $target->seen($target, "Poison courses through <self>'s veins!");
      $target->adjust('constitution',-1,$talent);
      $target->review('status');
      if (::d(1,4) == 1)
      {
        $r = 0;
        $target->seen($target, "The poison in <self>'s body wears off.");
      }
      $r;
    }
END_FUSE
    $target->review('status');
  }
END
);

$death_poison   = Talent->new('name'       => 'death poison',
                              'type'       => 'poison',
                              'on_perform' => <<'END',
  {
    my ($self, $target, $talent) = @_;
    $target->seen($talent, "<self> is poisoned with <other>!");
    $::fuses->add(<<'END_FUSE', ::d(1,6,+1), [$target, $talent]);
    {
      my ($target, $talent) = @_;
      my $r = 4;
      $target->seen($target, "Poison courses through <self>'s veins!");
      $target->adjust('constitution',-1,$talent);
      $target->review('status');
      $r;
    }
END_FUSE
    $target->review('status');
  }
END
);

### BUILT IN DISEASES ###

$common_cold  = Talent->new('name'       => 'common cold',
                            'type'       => 'disease',
                            'on_perform' => <<'END',
  {
    my ($self, $target, $talent) = @_;
    $target->seen($talent, "<self> comes down with <other>!");
    $::fuses->add(<<'END_FUSE', ::d(5,6), [$target, 10, $talent]);
    {
      my ($target, $count, $talent) = @_;
      my $r = ::d(1,30,+30);
      if ($count == 0)
      {
        $target->seen($target, "<self>'s cold clears up.");
        $r = 0;
      }
      elsif (::d(1,2)==1)
      {
        $target->seen($target, "<self> sniffles and groans.");
        $target->adjust('spirit',-::d(1,2),$talent);
      } else
      {
        $target->seen($target, "<self> coughs and sneezes.");
        $target->adjust('charisma',-::d(1,2),$talent);
      }
      $target->review('status');
      $::fuses->current->{args}[1]--;  # decrease count
      $r;
    }
END_FUSE
    $target->review('status');
  }
END
);

$rotting_disease   = Talent->new('name'       => 'rotting disease',
                                 'type'       => 'disease',
                                 'on_perform' => <<'END',
  {
    my ($self, $target, $talent) = @_;
    $target->seen($talent, "<self> comes down with <other>!");
    $::fuses->add(<<'END_FUSE', ::d(5,8,+4), [$target, $talent]);
    {
      my ($target, $talent) = @_;
      my $r = ::d(4,8,+5);
      $target->seen($target, "Bits of <self> rot away!");
      $target->{max}{constitution} -= 1;
      $target->review('status');
      $r;
    }
END_FUSE
    $target->review('status');
  }
END
);


sub poison
{
  my $self = shift;
  my $victim = shift;
  ::script $self->{on_perform}, $self, $victim, $self;
}

1;
