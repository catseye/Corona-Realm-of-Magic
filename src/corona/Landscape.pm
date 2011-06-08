package Terrain;

### TERRAIN ELEMENTS ###

### FOREST: OBSTACLES ###

$clump_of_trees = Terrain->new('name' => 'clump of trees',
                               'climbable' => 5,
                               'condition' => 10,
                               'on_pull' => <<'END',
    my ($puller, $self) = @_;
    my $i = Distribution->new(0.05 => $Item::club->crude,
                              0.05 => $Item::quarterstaff->crude)->pick;
# handful of leaves
# handful of bark
    if(defined $i)
    {
      $i = $i->clone;
      $puller->take($i);
      $puller->seen($i, "<self> manages to tear <# other> from the clump of trees.");
# bash self
    } else
    {
      $puller->seen($self, "<self> can't manage to tear anything from <other>.");
    }
END
                               'color' => 'green',
                               'appearance' => 'tree')->implies($Adj::wood)->implies($Adj::obstacle);

#$dense_forest = Terrain->new('name' => 'dense forest',
#                             'indestructible' => 1,
#                             'color' => 'green',
#                             'appearance' => 'tree')->implies($Adj::wood)->implies($Adj::wall);

$concealed_stash = Terrain->new('name' => 'clump of trees',
                               'condition' => 10,
                               'conceals' => 20,
                               'color' => 'green',
                               'on_reveal' => <<'END',
    my ($self) = @_;
    my $i = Distribution->new(0.5 => $Item::broadsword->fine->magicked(+1),
                              0.5 => $Item::mundane_wand->enchant($Talent::lightning_bolt, ::d(2,4)))->pick->clone;
    shift @{$self->{location}{map}[$self->{x}][$self->{y}]};
    unshift @{$self->{location}{map}[$self->{x}][$self->{y}]}, $i;
    $self->{location}->draw_cell($self->{x}, $self->{y});
    ::msg("This clump of trees looks like a hidden stash!");
END
                               'appearance' => 'tree')->implies($Adj::wood)->implies($Adj::obstacle);

$giant_bluewood = Terrain->new('name' => 'giant bluewood',
                               'climbable' => 25,
                               'condition' => 50,
                               'color' => 'cyan',
                               'appearance' => 'tree')->implies($Adj::wood)->implies($Adj::obstacle);

$Actor::wood_sprite->learn(Talent::create_ring($Terrain::giant_bluewood), 88);

$whipper_tree  = Terrain->new('name' => 'whipper tree',
                               'climbable' => 10,
                               'condition' => 30,
                               'color' => 'lime',
                               'appearance' => 'tree')->implies($Adj::wood)->implies($Adj::obstacle);

$waxwork_wall = Terrain->new('name' => 'waxwork wall',
                               'opacity' => 90,
                               'climbable' => 5,
                               'condition' => 10,
                               'color' => 'yellow',
                               'appearance' => 'honeycomb')->implies($Adj::wax)->implies($Adj::wall);

$dense_wax = Terrain->new('name' => 'dense wax',
                               'indestructible' => 1,
                               'color' => 'brown',
                               'appearance' => 'honeycomb')->implies($Adj::wax)->implies($Adj::wall);

$bedrock = Terrain->new('name' => 'bedrock',
                             'indestructible' => 1,
                             'color' => 'grey',
                             'appearance' => 'rock')->implies($Adj::stone)->implies($Adj::wall);

### FOREST: FLOORS ###

$giant_beehive    = Terrain->new('name' => 'giant beehive',
                              'low' => 1,
                              'color' => 'yellow',
                              'condition' => 100,
                              'opacity' => 0,
                              'appearance' => 'door')->implies($Adj::wax);

$beehive_tunnel   = Terrain->new('name' => 'beehive tunnel',
                               'low' => 1,
                               'opacity' => 0,
                               'indestructible' => 1,
                               'color' => 'yellow',
                               'appearance' => 'tunnel')->implies($Adj::wax);

$forest_floor   = Terrain->new('name' => 'forest floor',
                               'low' => 1,
                               'opacity' => 0,
                               'indestructible' => 1,
                               'color' => 'green',
                               'appearance' => 'floor')->implies($Adj::earth);

### PLAINS: FLOORS ###

$grassy_flat    = Terrain->new('name' => 'grassy flat',
                               'low' => 1,
                               'opacity' => 0,
                               'indestructible' => 1,
                               'color' => 'lime',
                               'appearance' => 'floor')->implies($Adj::plant);

$cultivated_field  = Terrain->new('name' => 'cultivated field',
                               'low' => 1,
                               'opacity' => 0,
                               'indestructible' => 1,
                               'color' => 'yellow',
                               'appearance' => 'floor')->implies($Adj::plant);

$fallow_field  = Terrain->new('name' => 'fallow field',
                               'low' => 1,
                               'opacity' => 0,
                               'indestructible' => 1,
                               'color' => 'brown',
                               'appearance' => 'floor')->implies($Adj::earth);

$barren_field   = Terrain->new('name' => 'barren field',
                               'low' => 1,
                               'opacity' => 0,
                               'indestructible' => 1,
                               'color' => 'purple',
                               'appearance' => 'floor')->implies($Adj::earth);

### HILLS: FLOORS ###

$rocky_steppes   = Terrain->new('name' => 'rocky steppes',
                               'low' => 1,
                               'opacity' => 0,
                               'indestructible' => 1,
                               'color' => 'brown',
                               'appearance' => 'floor')->implies($Adj::earth);

$gully  = Terrain->new('name' => 'gully',
                               'low' => 1,
                               'opacity' => 0,
                               'indestructible' => 1,
                               'color' => 'brown',
                               'appearance' => 'floor')->implies($Adj::earth);

$low_hillside  = Terrain->new('name' => 'low hillside',
                               'low' => 1,
                               'opacity' => 10,
                               'indestructible' => 1,
                               'color' => 'brown',
                               'appearance' => 'hill')->implies($Adj::earth);

### MOUNTAINS: OBSTACLES ###

$rocky_cliff    = Terrain->new('name' => 'rocky cliff',
                               'low' => 0,
                               'opacity' => 100,
                               'indestructible' => 1,
                               'color' => 'brown',
                               'appearance' => 'mountain')->implies($Adj::stone)->implies($Adj::obstacle);

$icy_cliff      = Terrain->new('name' => 'icy cliff',
                               'low' => 0,
                               'opacity' => 100,
                               'indestructible' => 1,
                               'color' => 'white',
                               'appearance' => 'mountain')->implies($Adj::stone)->implies($Adj::obstacle);

### MOUNTAINS: OBSTACLES ###

$mountain_pass  = Terrain->new('name' => 'mountain pass',
                               'low' => 1,
                               'opacity' => 0,
                               'indestructible' => 1,
                               'color' => 'brown',
                               'appearance' => 'floor')->implies($Adj::earth);

### DESERT: FLOORS ###

$alkali_flat    = Terrain->new('name' => 'alkali flat',
                               'low' => 1,
                               'opacity' => 0,
                               'indestructible' => 1,
                               'color' => 'grey',
                               'appearance' => 'floor')->implies($Adj::earth);

$hardpan        = Terrain->new('name' => 'hardpan',
                               'low' => 1,
                               'opacity' => 0,
                               'indestructible' => 1,
                               'color' => 'brown',
                               'appearance' => 'floor')->implies($Adj::earth);

$sandy_expanse  = Terrain->new('name' => 'sandy expanse',
                               'low' => 1,
                               'opacity' => 0,
                               'indestructible' => 1,
                               'color' => 'yellow',
                               'appearance' => 'floor')->implies($Adj::earth);

$sand_dune      = Terrain->new('name' => 'sand dune',
                               'low' => 1,
                               'opacity' => 25,
                               'indestructible' => 1,
                               'color' => 'yellow',
                               'appearance' => 'hill')->implies($Adj::earth);

### WATER: OBSTACLES ###

$ocean = Terrain->new('name' => 'ocean',
                                'opacity' => 0,
                                'indestructible' => 1,
                                'color' => 'aqua',
                                'appearance' => 'water')->implies($Adj::water);

### WATER: FLOORS ###

$freshwater_pool = Terrain->new('name' => 'freshwater pool',
                                'low' => 1,
                                'opacity' => 0,
                                'indestructible' => 1,
                                'color' => 'sky',
                                'appearance' => 'water')->implies($Adj::water);

$marsh = Terrain->new('name' => 'marsh',
                      'low' => 1,
                      'opacity' => 25,
                      'indestructible' => 1,
                      'color' => 'aqua',
                      'appearance' => 'marsh')->implies($Adj::mud);

### WILDERNESS: PORTALS ###

$small_hole    = Terrain->new('name' => 'small hole',
                              'low' => 1,
                              'opacity' => 0,
                              'indestructible' => 1,
                              'color' => 'grey',
                              'appearance' => 'hole')->implies($Adj::mud);


### AIR: FLOORS ###

$fog             = Terrain->new('name' => 'fog',
                                'opacity' => 66,
                                'low' => 1,
                                'indestructible' => 1,
                                'color' => 'grey',
                                'appearance' => 'gas')->implies($Adj::gas);

$Actor::swamp_hag->learn(Talent::create_cloud($Terrain::fog), 100);

$mist            = Terrain->new('name' => 'mist',
                                'opacity' => 33,
                                'low' => 1,
                                'indestructible' => 1,
                                'color' => 'white',
                                'appearance' => 'gas')->implies($Adj::gas);

$smoke           = Terrain->new('name' => 'smoke',
                                'opacity' => 90,
                                'low' => 1,
                                'indestructible' => 1,
                                'color' => 'black',
                                'appearance' => 'gas')->implies($Adj::gas);

### ARTIFICE: OBSTACLES ###

$ancient_ruins = Terrain->new('name' => 'ancient ruins',
                              'climbable' => 10,
                              'condition' => 75,
                              'color' => 'grey',
                              'appearance' => 'brick')->implies($Adj::stone)->implies($Adj::obstacle);

$city_wall = Terrain->new('name' => 'city wall',
                              'climbable' => 60,
                              'condition' => 500,
                              'color' => 'grey',
                              'appearance' => 'brick')->implies($Adj::stone)->implies($Adj::obstacle);

$iron_portcullis = Terrain->new('name' => 'iron portcullis',
                              'opacity' => 33,
                              'climbable' => 50,
                              'condition' => 400,
                              'color' => 'blue',
                              'appearance' => 'gate')->implies($Adj::iron)->implies($Adj::wall);

$building_wall = Terrain->new('name' => 'building wall',
                              'climbable' => 40,
                              'condition' => 200,
                              'color' => 'red',
                              'appearance' => 'brick')->implies($Adj::stone)->implies($Adj::obstacle);

$small_farmhouse  = Terrain->new('name' => 'small farmhouse',
                               'indestructible' => 1,
                               'color' => 'grey',
                               'appearance' => 'hut')->implies($Adj::wood)->implies($Adj::obstacle);

$stonework_wall = Terrain->new('name' => 'stonework wall',
                             'condition' => 325,
                             'color' => 'grey',
                             'appearance' => 'brick')->implies($Adj::stone)->implies($Adj::wall);

$wooden_signpost = Terrain->new('name' => 'wooden signpost',
                              'climbable' => 80,
                              'condition' => 100,
                              'color' => 'red',
                              'appearance' => 'stair')->implies($Adj::wood)->implies($Adj::obstacle);

### ARTIFICE: STAIRS ###

$ascending_staircase = Terrain->new('name' => 'ascending staircase',
                              'low' => 1,
                              'opacity' => 0,
                              'indestructible' => 1,
                              'color' => 'white',
                              'appearance' => 'stair')->implies($Adj::stone);

$descending_staircase = Terrain->new('name' => 'descending staircase',
                              'low' => 1,
                              'opacity' => 0,
                              'indestructible' => 1,
                              'color' => 'grey',
                              'appearance' => 'stair')->implies($Adj::stone);

### ARTIFICE: PORTALS ###

$stone_archway = Terrain->new('name' => 'stone archway',
                              'low' => 1,
                              'opacity' => 12,
                              'color' => 'grey',
                              'climbable' => 60,
                              'condition' => 200,
                              'appearance' => 'door')->implies($Adj::stone);

$wooden_doorway = Terrain->new('name' => 'wooden doorway',
                              'low' => 1,
                              'opacity' => 12,
                              'color' => 'brown',
                              'climbable' => 60,
                              'condition' => 200,
                              'appearance' => 'door',
                              'on_open' => <<'END',
{
  my ($self, $actor) = @_;
  shift @{$self->{location}{map}[$self->{x}][$self->{y}]};
  my $t = $Terrain::closed_wooden_door->clone;
  $t->{x} = $self->{x};
  $t->{y} = $self->{y};
  $t->{location} = $self->{location};
  unshift @{$self->{location}{map}[$self->{x}][$self->{y}]}, $t;
}
END
)->implies($Adj::wood);

$closed_wooden_door = Terrain->new('name' => 'closed wooden door',
                              'color' => 'brown',
                              'climbable' => 60,
                              'condition' => 200,
                              'appearance' => 'closed',
                              'on_open' => <<'END',
{
  my ($self, $actor) = @_;
  shift @{$self->{location}{map}[$self->{x}][$self->{y}]};
  my $t = $Terrain::wooden_doorway->clone;
  $t->{x} = $self->{x};
  $t->{y} = $self->{y};
  $t->{location} = $self->{location};
  unshift @{$self->{location}{map}[$self->{x}][$self->{y}]}, $t;
}
END
)->implies($Adj::wood)->implies($Adj::obstacle);

### ARTIFICE: FLOORS ###

$cobblestone_road   = Terrain->new('name' => 'cobblestone road',
                               'low' => 1,
                               'opacity' => 0,
                               'color' => 'grey',
                               'appearance' => 'floor')->implies($Adj::stone);

$dirt_road   = Terrain->new('name' => 'dirt road',
                               'low' => 1,
                               'opacity' => 0,
                               'indestructible' => 1,
                               'color' => 'brown',
                               'appearance' => 'floor')->implies($Adj::earth);

$wooden_docks = Terrain->new('name' => 'wooden docks',
                              'low' => 1,
                              'opacity' => 0,
                              'indestructible' => 1,
                              'color' => 'brown',
                              'appearance' => 'stair')->implies($Adj::wood);

$marble_steps = Terrain->new('name' => 'marble steps',
                              'low' => 1,
                              'opacity' => 0,
                              'indestructible' => 1,
                              'color' => 'pink',
                              'appearance' => 'stair')->implies($Adj::marble);

$stonework_floor = Terrain->new('name' => 'stonework floor',
                                'low' => 1,
                                'opacity' => 0,
                                'indestructible' => 1,
                                'color' => 'grey',
                                'appearance' => 'floor')->implies($Adj::stone);

sub diseased
{
  my $self = shift;
  my $disease = shift;
  my $n = $self->copy;
  $n->{_disease} = $disease;
  $n->{on_enter} = <<'END';
{
  my ($self, $actor) = @_;
  my $d = $self->{_disease};
  $d = $d->pick if ref($d) eq 'Distribution');
  $d->clone->poison($actor);
}
END
  return $n;
}

$magic_circle    = Terrain->new('name' => 'magic circle',
                                'low' => 1,
                                'opacity' => 0,
                                'indestructible' => 1,
                                'on_enter' => <<'END',
{
  my ($self, $actor) = @_;
  $actor->seen($self, "<self> is protected from demons by <other>.");
  $actor->alter_resistances('demon' => 1.00);
}
END
                                'on_exit' => <<'END',
{
  my ($self, $actor) = @_;
  $actor->seen($self, "<self> is no longer protected by <other>.");
  $actor->alter_resistances('demon' => -1.00);
}
END
                                'color' => 'white',
                                'appearance' => 'circle')->implies($Adj::magic);

1;
