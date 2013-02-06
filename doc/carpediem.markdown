Game Engine Documentation
=========================

### CARPE DIEM v2000.12.04

Computer-Assisted Role Playing Engine for Diverse Interactive
Entertainment Modules

* * * * *

(c)2000 Cat's Eye Technologies. All rights reserved.  
This software is OSI Certified Open Source Software.  
See the file [license.txt](license.txt) for license information.

Table of Contents
-----------------

-   About CARPE DIEM
-   [Development Notes](development.html)
-   [Object Model Reference](object_model.html)

### About CARPE DIEM

CARPE DIEM is an engine and framework for games.

CARPE DIEM can be loosely described as a 'roguelike' game engine. It is
primarily keypress-controlled, but a menu-driven interface is also
employed, and players more comfortable with menus can use them
exclusively.

In this context, roguelike primarily means: the area surrounding the
currently active characters is displayed as a two-dimensional iconic map
on the computer or terminal's screen. This map may be larger than the
current screen (it will scroll as needed.)

First-person perspective is not supported.

You, as the player, can command an entire party of adventurers, both
those totally under your control (PC's) and those you have hired
(NPC's.)

Eventually management of multiple parties will be possible, so that a
party of more than one character can split into two parties, and two
parties can join to form a bigger party. Play may switch between parties
at any point.

Only turn-based gameplay is supported, not real-time.

The combat and talent systems need work, but show promise.

### The Implementation

CARPE DIEM is written entirely in Perl 5.x. It uses few external modules
so there should be little need to worry about obtaining the "right
extras"; as long as you have a stable, basic configuration of Perl
installed, it should run.

CARPE DIEM uses a display abstraction layer, so as long as you can
describe exactly how to render any given object (say, a dragon,) you
can, with enough work, make it display on any display device you could
possibly access via Perl.

By default, however, only generic, console-or-terminal based display
drivers are selected. Drivers are included for console input and output
under 32-bit Windows, terminal input under POSIX, and terminal output
under ANSI (or VT100); the output functionality includes colour modules
which support sixteen colours under 32-bit Windows and ANSI, and a crude
approximation on VT100 terminals which only support an intensity bit.

Curses is only used if it has already been installed as a library for
the Perl interpreter, so display refreshing is not guaranteed to be
particularly optimized, and it is recommended CARPE DIEM be run from a
console if Curses is not available.

In order to coexist with ANSI keypress sequences which begin with an
escape character, the escape key must be 'double-clicked' in order for
it to register as 'escape'.

This display/input abstraction layer has been tested on:

-   Windows 95: console
-   Windows 98 SE: console
-   Windows NT: console
-   FreeBSD 4.0-RELEASE: console (ANSI and Curses)
-   Linux 2.2.17: console, xterm (X), gsh-term (KDE)
-   SCO v3.x(?): console
-   Solaris SunOS 4: telnet

The \_screen module will select what kind of character set to assume
based on the current operating system - it assumes Windows, Linux, and
FreeBSD are running on hardware with the IBM PC OEM textmode font. When
the Mac version is done, it may use the Mac's built-in symbolset (if not
a set of dedicated graphical icons). If a dedicated font is one day
created, that may be invoked/configured here as well. In all other
cases, generic ASCII symbols are used to represent things. Because there
are more things than symbols, some things look the same in ASCII, and
the What Is...? command can be used to identify things on the screen.

The mappings which translate keypresses into actions are configurable.
The key/ directory contains keymaps for the game Corona, and ones
resembling Hack, Rogue, Larn, ADOM, and Angband (Roguelike), and of
course it offers the possibility of rolling your own custom keymapping.

### Thanks

Thanks go to:

Russell Bornschlegel, John Colagioia, Brian Connors, Matthias Giwer, Ben
Olmstead, Steve Mosher, Rafal Sulejman, Greg Velichansky, and anyone
else who chipped in their two cents whose name I've managed to forget...

Larry Wall

The Authors of Rogue, [Net]Hack, Moria, Angband, Alphaman, & ADOM

 

Chris Pressey  
Winnipeg, Manitoba, Canada  
Dec 4 2000
