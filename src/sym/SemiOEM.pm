# SemiOEM.pm - Character set definitions for Corona, IBM OEM charset
#          without control characters (ASCII < 32), for SCO & Curses

# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

require "sym/OEM.pm";

%sc =
(
  %sc,
  'person' => '@',
  'tree'   => chr(140),
);

1;
