# pedantic version!
# it's missing so much, I'm not sure why anyone would want to use it,
# but here it is anyway... less-than-purists may want to uncomment
# the lines which are relevant to most Corona fare.

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
  'D' => 'view_known_items',
  'i' => 'view_inventory',

  # chr(18) => 'redraw_screen',

  'c' => 'use_talent spell',

  # 'I' => 'examine_item',
  # ',' => 'take_item',

  'd' => 'drop_item',

  'q' => 'consume_item beverage',
  'e' => 'consume_item food',

  'w' => 'wield_item hand',
  'W' => 'wield_item',
  'T' => 'unwield_item',

  # 'z' => 'use_item',

  '^' => 'look_around',
  # 't' => 'throw_item',
  'r' => 'read_item',
  's' => 'search',

  # '>' => 'enter down',
  # '<' => 'enter up',

### Not Yet Implemented:

  'g' => 'view_encumbrance',
  'P' => 'view_taxation',
  'A' => 'debug',
  'Z' => 'use_talent teleport',
  # chr(16) => 'review_messages',
  # 'O' => 'preferences',
  # '!' => 'shell_escape',

  'v' => 'view_about_game',

  # 'm' => 'move',  # stealthily?
  # 'f' => 'run',

  # 'H' => 'run west',
  # 'J' => 'run south',
  # 'K' => 'run north',
  # 'L' => 'run east',
  # 'Y' => 'run northwest',
  # 'U' => 'run northeast',
  # 'B' => 'run southwest',
  # 'N' => 'run southeast',
);

1;
