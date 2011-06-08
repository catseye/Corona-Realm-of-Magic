# Angband Roguelike keymap heavily modified by Chris Pressey
# Thanks to Greg Velichansky (hmaon@bumba.net) for supplying the original

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
  'i' => 'view_inventory',
  'e' => 'view_equipment',

  'd' => 'drop_item',
  chr(4) => 'destroy_item',  # not implemented!

  'w' => 'wield_item',
  't' => 'unwield_item',
  'T' => 'unwield_item',

  ';' => 'move',  # 'with pickup' not implemented
  '-' => 'move',  # 'flip pickup' not implemented

  # use shifted roguelike keys instead of these
  # '.' => 'run',
  # ',' => 'run',

  'H' => 'run west',
  'J' => 'run south',
  'K' => 'run north',
  'L' => 'run east',
  'Y' => 'run northwest',
  'U' => 'run northeast',
  'B' => 'run southwest',
  'N' => 'run southeast',

  '>' => 'enter down',
  '<' => 'enter up',

  '.' => 'rest',
  ',' => 'take_item',    # rest with pickup not implemented
  'g' => 'rest',         # flip pickup not implemented

  'R' => 'sleep',   # not yet implemented: 'k'ip in Corona mapping

  's' => 'search',

  '#' => 'toggle_search',  # not implemented

  'T' => 'bash',
  chr(20) => 'bash',

  'o' => 'open_or_close',
  'c' => 'open_or_close',

  'S' => 'use_item iron_spike',

  'f' => 'bash',

  'D' => 'use_talent disarm_trap',

  '+' => 'preferences bump',

  'P' => 'read_item book',
  'G' => 'read_item book',  # close 'nuff
  'm' => 'use_talent spell',
  'p' => 'use_talent prayer',
  'E' => 'consume_item food',
  'F' => 'use_item fuel',
  'q' => 'consume_item beverage',
  'r' => 'read_item',
  '{' => 'name_item',
  '}' => 'name_item forget',

  'A' => 'use_item artefact',
  'z' => 'use_item wand',
  'Z' => 'use_item staff',
  'a' => 'use_item rod',

  't' => 'throw_item',
  'v' => 'throw_item',
  '*' => 'throw_item',

  'M' => 'view_map',    # not yet implemented
  'W' => 'scroll_map',  # not yet implemented

  'x' => 'look_around',
  'I' => 'examine_item',

  chr(6) => 'review_messages feeling',
  chr(16) => 'review_messages',
  ':' => 'submit_message',

  'C' => 'view_character',
  '~' => 'view_known_items',
  '!' => 'debug',

  chr(24) => 'save_game;quit_game',
  chr(19) => 'save_game',
  'Q' => 'quit_game',

  '=' => 'preferences',
  '@' => 'preferences keymap',
  '%' => 'preferences symbolset',
  '&' => 'preferences color',

  '/' => 'what_is',
  'V' => 'view_about_game',

  chr(5) => 'toggle_width 80 60',  # not yet implemented
  chr(18) => 'redraw_screen',

  '(' => 'save_screen',  # not yet implemented
  ')' => 'load_screen',  # not yet implemented

);

1;
