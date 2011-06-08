$extkey = ';';  # can't be backslash because that's view known items
$helpkey = '?';

$padmap =
[
  ['y', 'k', 'u'],
  ['h', '.', 'l'],
  ['b', 'j', 'n'],
];

%keymap =
(
  'S' => 'save_game',
  'Q' => 'quit_game',
  '/' => 'what_is',
  '\\' => 'view_known_items',
  'i' => 'view_inventory',
  '$' => 'view_inventory',
  ')' => 'view_equipment',  # weapon
  ']' => 'view_equipment',  # armor
  '=' => 'view_equipment',  # ring
  chr(18) => 'redraw_screen',

  'a' => 'use_item',

  'I' => 'examine_item',
  ',' => 'take_item',
  'd' => 'drop_item',
  'D' => 'drop_item',

  'E' => 'vandalize',

  'q' => 'consume_item beverage',
  'e' => 'consume_item food',

  'w' => 'wield_item hand',
  'W' => 'wield_item',
  'T' => 'unwield_item',
  'P' => 'wield_item finger',
  'R' => 'unwield_item finger',

  'z' => 'use_item',
  '^' => 'look_around',
  ':' => 'look_around',
  't' => 'throw_item',
  'r' => 'read_item',
  's' => 'search',

  '>' => 'enter down',
  '<' => 'enter up',

  'C' => 'name_creature',
  'O' => 'preferences',

### Not Yet Implemented:

  'p' => 'pay',
  chr(20) => 'use_talent teleport',
  chr(26) => 'suspend',
  chr(16) => 'review_messages',
  '!' => 'shell_escape',

  'v' => 'view_about_game',

  'm' => 'move',  # stealthily?
  'f' => 'run',

  'c' => 'name_item',

  'H' => 'run west',
  'J' => 'run south',
  'K' => 'run north',
  'L' => 'run east',
  'Y' => 'run northwest',
  'U' => 'run northeast',
  'B' => 'run southwest',
  'N' => 'run southeast',
);

1;
