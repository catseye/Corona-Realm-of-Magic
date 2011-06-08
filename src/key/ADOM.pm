# ADOM keymap... lagging behind!

$extkey = '\\';
$helpkey = '?';

$padmap =
[
  ['7', '8', '9'],
  ['4', '5', '6'],
  ['1', '2', '3'],
];

%keymap =
(
  'S' => 'save_game',

  '?' => 'help',
  chr(12) => 'redraw_screen',

  '$' => 'view_inventory',
  'A' => 'view_talents',

  'q' => 'view_journal',
  'l' => 'what_is',

  # 'j' => 'jump',

  ',' => 'take_item',
  'd' => 'drop_item',

  'i' => 'wield_item',
#  't' => 'unwield_item',

  'x' => 'examine_item',
  'u' => 'use_item',
  't' => 'throw_item',

  'D' => 'consume_item',
  'r' => 'read_item',

  'k' => 'bash',
  'o' => 'open_or_close',
  '>' => 'enter',
  's' => 'search',

  'a' => 'use_talent',

  ':'  => 'extended',
  ':m' => 'review_messages',
);

1;
