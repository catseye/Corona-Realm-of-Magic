# ASCII.pm - Character set definitions for a bare 7-bit ASCII terminal.

# Copyright (c)2000, Cat's Eye Technologies.
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 
#   Redistributions of source code must retain the above copyright
#   notice, this list of conditions and the following disclaimer.
# 
#   Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer in
#   the documentation and/or other materials provided with the
#   distribution.
# 
#   Neither the name of Cat's Eye Technologies nor the names of its
#   contributors may be used to endorse or promote products derived
#   from this software without specific prior written permission. 
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
# CONTRIBUTORS ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
# OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
# OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE. 

%sc =
(
  'nwbox'  => '+',
  'nbox'   => '-',
  'nebox'  => '+',
  'wbox'   => '|',
  'ebox'   => '|',
  'swbox'  => '+',
  'sbox'   => '-',
  'sebox'  => '+',

  'person' => '@',

  'brick'  => '#',
  'hut'    => 'A',
  'tree'   => 'T',
  'water'  => '~',
  'door'   => '/',
  'closed' => '+',
  'stair'  => '>',   # todo: stair images both up and down
  'floor'  => '.',
  'dark'   => ' ',
  'hole'   => 'o',

  'hill'   => '~',
  'mountain'=> '^',
  'marsh'  => '_',

  'cloak'  => ']',
  'halter' => ']',
  'jacket' => ']',
  'leggings' => ']',
  'helm'   => ']',
  'gloves' => ']',
  'clothing' => ']',
  'boots'  => ']',
  'sleeves' => ']',
  'necklace' => ']',
  'bracelet' => ']',
  'belt' => ']',
  'ring' => '=',

  'tiny'   => ",",
  'rock'   => '*',
  'boulder'=> 'O',
  'ash'    => ',',
  'crystal'=> '*',

  'food'   => '%',
  'fruit'  => '%',
  'vegetable' => '%',
  'fungus' => '%',
  'root'   => '%',
  'grass'  => '"',
  'stalk'  => '"',
  'web'    => '|',

  'gas'    => '&',
  'gate'   => '+',

  'bottle' => '!',
  'coin'   => '$',

  'circle' => '0',

  'sword'  => '(',
  'stick'  => '(',
  'mace'   => '(',
  'scythe' => '(',
  'arrow'  => '/',
  'bow'    => ')',
  'crossbow'=> '}',

  'scroll' => '?',
  'instrument' => '[',

  'carcass'=> '%',

  'ursine' => 'B',
  'spider' => 'x',
  'serpent'=> 'S',
  'worm'   => 's',

  'feline' => 'c',
  'canine' => 'd',
  'primate'=> 'M',
  'bovine' => 'u',
  'porcine'=> 'p',

  'dwark'  => 'k',
  'grue'   => 'G',
  'grumchik'=>'g',
  'traiple'=> 't',

  'nymph'  => 'N',
  'dryad'  => 'D',
  'fairy'  => 'f',

  'skeleton'=>'z',
  'zombie'  =>'z',

  'hag'    => 'h',
  'gator'  => 'y',
  'bird'   => 'v',

  'honeycomb' => '#',
  'tunnel'    => '.',
  'jelly'     => '%',
  'bee'       => 'b',
  'grasshopper' => 'i',
);

1;
