sub main_menu
{
  my $cmd;

  my $option = Menu->new('label'=>['Move','Action','Item','View','Game'])->pick;
  if ($option eq 'Move')
  {
    $cmd = Menu->new('cancel'=>'', 'indent'=>1,
                     'value'=>['move north','move northeast','move east','move southeast','move south','move southwest','move west','move northwest','run','climb','jump'],
                     'label'=>['North','Northeast','East','Southeast','South','Southwest','West','Northwest','Run','Climb','Jump'])->pick;
  }
  elsif ($option eq 'Action')
  {
    $cmd = Menu->new('cancel'=>'', 'indent'=>1,
                     'value'=>['use_talent','look_around','search','pull','push','bash','vandalize'],
                     'label'=>['Talent','Look','Search','Pull','Push','Bash','Vandalize'])->pick;
  }
  elsif ($option eq 'Item')
  {
    $cmd = Menu->new('cancel'=>'', 'indent'=>1,
                     'value'=>['examine_item','take_item','drop_item','wield_item','unwield_item','consume_item','read_item','use_item'],
                     'label'=>['Examine','Take','Drop','Wield','Remove','Consume','Read','Use'])->pick;
  }
  elsif ($option eq 'View')
  {
    $cmd = Menu->new('cancel'=>'', 'indent'=>1,
                     'value'=>['view_all_parties','view_party','view_character','view_equipment','view_inventory','view_talents','view_journal','what_is'],
                     'label'=>['All Parties','Party','Character','Equipment','Inventory','Talents','Journal','What Is...?'])->pick;
  }
  elsif ($option eq 'Game')
  {
    $cmd = Menu->new('cancel'=>'', 'indent'=>1,
                     'value'=>['preferences', 'save_game','load_game','quit_game'],
                     'label'=>['Prefs', 'Save','Load','Quit'])->pick;
  }
  return $cmd;

}

1;
