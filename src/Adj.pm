package Adj;
@ISA = qw( Saveable );

# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

use Carp;

my %fields =
(
  'name'     => '',
  'implies'  => [],
);

sub new
{
  my $class = shift;
  my $name = shift;
  my $self =
  {
    '_permitted' => \%fields,
    %fields,
    'name' => $name,
    'implies'  => [],
  };
  bless $self, $class;
}

sub implies
{
  my $self = shift;
  my $other = shift;
  carp "$other should be ref, $self, $self->{name}" if not ref $other;
  # my $f = 0;
  # grep { $f = 1 if $_ eq $other } @{$self->{implies}};
  # if (not $f)
  # {
  $self->{implies} = [] if not defined $self->{implies};
  $other->{implies} = [] if not defined $other->{implies};
  $self->{implies} = [ @{$self->{implies}}, $other, @{$other->{implies}} ];
  # }
  return $self;
}

sub is
{
  my $self = shift;
  my $other = shift;
  grep { return 1 if $_ eq $other } @{$self->{implies}};
  return 0;
}

sub equal_adjectival
{
  my $self = shift;
  my $other = shift;
  grep { return 0 if not $other->is($_) } @{$self->{implies}};
  return 1;
}

sub composition
{
  my $self = shift;
  my $f; my $s = '';
  foreach $f (@{$self->{implies}})
  {
    $s .= $f->{name} . ', ';
  }
  return $s;
}

### ADJECTIVALS

$earth = Adj->new('earth');

$metal = Adj->new('metal')->implies($earth);
$platinum = Adj->new('platinum')->implies($metal);
$gold  = Adj->new('gold')->implies($metal);
$silver  = Adj->new('silver')->implies($metal);
$copper  = Adj->new('copper')->implies($metal);
$iron  = Adj->new('iron')->implies($metal);
$bronze  = Adj->new('bronze')->implies($metal);
$meteoric_iron  = Adj->new('meteoric-iron')->implies($iron);
$steel  = Adj->new('steel')->implies($iron);
$lead  = Adj->new('lead')->implies($metal);
$tin  = Adj->new('tin')->implies($metal);

$stone = Adj->new('stone')->implies($earth);
$gem   = Adj->new('gem')->implies($stone);
$opal  = Adj->new('opal')->implies($gem);

$limestone = Adj->new('limestone')->implies($stone);
$granite = Adj->new('granite')->implies($stone);
$marble = Adj->new('marble')->implies($stone);

$mud = Adj->new('mud')->implies($earth);
$clay = Adj->new('clay')->implies($earth);

$gas = Adj->new('gas');
$air = Adj->new('air')->implies($gas);

$water = Adj->new('water');

$heat = Adj->new('heat');
$fire = Adj->new('fire')->implies($heat);

$steam = Adj->new('steam')->implies($heat)->implies($air)->implies($water);

$cold = Adj->new('cold');
$ice  = Adj->new('ice')->implies($cold)->implies($water);

$acid = Adj->new('acid');
$electricity = Adj->new('electricity');

$plant = Adj->new('plant');
$garlic = Adj->new('garlic')->implies($plant);
$mint = Adj->new('mint')->implies($plant);
$holly = Adj->new('holly')->implies($plant);
$wood = Adj->new('wood')->implies($plant);

$flesh = Adj->new('flesh');
$leather = Adj->new('leather')->implies($flesh);

$bone  = Adj->new('bone');
$wax   = Adj->new('wax');
$jelly = Adj->new('jelly');
$silk  = Adj->new('silk');
$canvas= Adj->new('canvas');
$fur   = Adj->new('fur');

$kinetic = Adj->new('kinetic');
$crushing = Adj->new('crushing')->implies($kinetic);
$cutting  = Adj->new('cutting')->implies($kinetic);
$piercing = Adj->new('piercing')->implies($kinetic);

$explosion = Adj->new('explosion');

$magic = Adj->new('magic');
$curse = Adj->new('curse');
$blessing = Adj->new('blessing');  # to do: much more complex in the future, I swear

$written = Adj->new('written');
$edible  = Adj->new('edible');
$liquid  = Adj->new('liquid');

$weapon = Adj->new('weapon');
$bolt = Adj->new('bolt')->implies($weapon);
$arrow = Adj->new('arrow')->implies($weapon);
$round = Adj->new('round')->implies($weapon);
$knife = Adj->new('knife')->implies($weapon);  # includes daggers
$club = Adj->new('club')->implies($weapon);
$card = Adj->new('card')->implies($weapon);
$axe = Adj->new('axe')->implies($weapon);

$bow = Adj->new('bow')->implies($weapon);
$crossbow = Adj->new('crossbow')->implies($weapon);

$hammer = Adj->new('hammer')->implies($weapon);  # includes maces
$sword = Adj->new('sword')->implies($weapon);
$flail = Adj->new('flail')->implies($weapon);
$two_handed = Adj->new('two-handed')->implies($weapon);

$flute    = Adj->new('flute');
$reed     = Adj->new('reed');
$horn     = Adj->new('horn');
$harp     = Adj->new('harp');
$keyboard = Adj->new('keyboard');
$lute     = Adj->new('lute');
$viol     = Adj->new('viol');
$drum     = Adj->new('drum');

$wall     = Adj->new('wall');
$obstacle = Adj->new('obstacle');

$ethereal = Adj->new('ethereal');
$aquatic  = Adj->new('aquatic');
$airborne = Adj->new('airborne');

1;
