
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
  'L' => 'load_game',
  'Q' => 'quit_game',

  '?' => 'help',
  chr(12) => 'redraw_screen',
  chr(16) => 'review_messages',
  chr(11) => 'bind',
  chr(15) => 'debug',

  'O' => 'preferences',
  '!' => 'shell_escape',

  '.' => 'repeat_action',

  'A' => 'view all_parties',
  'P' => 'view party',
  'C' => 'view character',
  'E' => 'view equipment',
  'I' => 'view inventory',
  'G' => 'view guilds',
  'T' => 'view talents',
  'J' => 'view journal',
  'K' => 'view known_items',
  'R' => 'view resistances',
  'V' => 'view impression',
  'Y' => 'view messages',
  'W' => 'what_is',

  'N' => 'name_creature',
  'M' => 'name_item',

  'X' => 'exit_vehicle',
  'B' => 'board_vehicle',

  'Z' => 'switch_stance',

  "\t" => 'switch_leader',

  'j' => 'jump',

  'g' => 'take_item',
  'd' => 'drop_item',
  'w' => 'wield_item',
  't' => 'unwield_item',
  'x' => 'examine_item',
  'u' => 'use_item',
  # 'f' => 'dunno',
  # 'n' => 'dunno',
  'c' => 'consume_item',
  'r' => 'read_item',
  'h' => 'throw_item',

  'l' => 'look_around',
  'v' => 'vandalize',
  'b' => 'bash',
  'o' => 'open_or_close',
  'e' => 'enter',

  'f' => 'search',
  'n' => 'push',
  's' => 'climb',

  'a' => 'use_talent',

  'i' => 'interact',
  'k' => 'sleep',
  'm' => 'trade_places',
  'p' => 'pull',
  'y' => 'shout',

  'q' => 'run',
  'z' => 'destroy_item',

  '.' => 'repeat_action',
);

%mnemonic =
(
  'M' => 'Monogram Item',
  'q' => 'Quick (Run)',
  'y' => 'Yell (Shout)',
  'm' => 'Move Past',
  'k' => 'Kip (Sleep)',
  'a' => 'Apply Talent',
  'h' => 'Hurl Item',
  'g' => 'Get Item',
  't' => 'Take off Item',
  'f' => 'Find (Search)',
  'n' => 'Nudge (Push)',
  's' => 'Scale (Climb)',
);

1;
