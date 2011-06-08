$extkey = '\\';
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
  'i' => 'view_inventory',
  ')' => 'view_equipment',  # weapon
  ']' => 'view_equipment',  # armor
  '=' => 'view_equipment',  # ring
  chr(1) => 'view_character',  # hitpoint raise avg
  chr(18) => 'redraw_screen',

  'I' => 'examine_item',
  ',' => 'take_item',
  'd' => 'drop_item',

  'q' => 'consume_item beverage',
  'e' => 'consume_item food',

  'w' => 'wield_item hand',
  'W' => 'wield_item',
  'T' => 'unwield_item',
  'P' => 'wield_item finger',
  'R' => 'unwield_item finger',

  'z' => 'use_item',
  '^' => 'look_around',
  't' => 'throw_item',
  'r' => 'read_item',
  's' => 'search',

  '>' => 'enter down',
  '<' => 'enter up',

  chr(16) => 'review_messages',
  'o' => 'preferences',

### Not Yet Implemented:

  '&' => 'save_screen',
  '!' => 'shell_escape',

  'v' => 'view_about_game',

  'm' => 'move',  # stealthily?
  'c' => 'name_item',

  'H' => 'run west',
  'J' => 'run south',
  'K' => 'run north',
  'L' => 'run east',
  'Y' => 'run northwest',
  'U' => 'run northeast',
  'B' => 'run southwest',
  'N' => 'run southeast',

  'f' => 'fight',
  'F' => 'kamikaze',

);

1;
