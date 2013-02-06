# _screen.pm: screen-handling stuff for CARPE DIEM

# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

BEGIN
{
  require "sym/$::pref{symbols}.pm";
  require "key/$::pref{keymap}.pm";
}

sub readstring
{
  my $l = shift;
  my $p = shift || '[a-zA-Z \'\-\&]';
  my $n = ''; my $m = '';
  while ($n ne chr(10) and $n ne chr(13))
  {
    $n = ::getkey();
    if($n =~ /^$p$/ and $n ne chr(8))
    {
      if (length($m) <= $l)
      {
        $m .= $n; ::display($n);
      }
    }
    if($n eq chr(8) and length($m) > 0)
    {
      $m =~ s/.$//o;
      ::display("\b \b");
    }
  }
  return $m;
}

# todo: take flag for accept_center (e.g. use item on self)
sub getdir
{
  my $n = '';
  my $ak = "$::padmap->[0][0]$::padmap->[0][1]$::padmap->[0][2]$::padmap->[1][0]$::padmap->[1][1]$::padmap->[1][2]$::padmap->[2][0]$::padmap->[2][1]$::padmap->[2][2]";
  my $m = "Which direction ($ak)?";
  gotoxy(1,$::setup{screen_height});
  ::color('white','black');
  ::display $m;
  ::clreol;
  my $bak = "[$ak]";
  while ($n !~ /^$bak$/)
  {
    $n = ::getkey();
  }
  return $n;
}

sub crosshairs
{
  my $range = shift || 1000;
  my $n = '';
  my $ak = "$::padmap->[0][0]$::padmap->[0][1]$::padmap->[0][2]$::padmap->[1][0]$::padmap->[1][2]$::padmap->[2][0]$::padmap->[2][1]$::padmap->[2][2]";
  my $m = "Use direction keys ($ak) to move cursor to target and press Enter.";
  my $sx = $leader->screenx;
  my $sy = $leader->screeny;
  gotoxy(1,$::setup{screen_height});
  ::color('white','black');
  ::display $m;
  ::clreol;
  ::gotoxy($sx,$sy);
  while ($n ne chr(13) and $n ne chr(10))
  {
    my $ox = $sx; my $oy = $sy; my $ch;
    # if ($::setup{display} eq 'Curses')
    # {
    #   $ch = mvinch($sx,$sy);
      ::update_display;
    # }
    $n = ::getkey;
    if    ($n eq $::padmap->[2][0]) { $sx--; $sy++; }
    elsif ($n eq $::padmap->[2][1]) {        $sy++; }
    elsif ($n eq $::padmap->[2][2]) { $sx++; $sy++; }
    elsif ($n eq $::padmap->[1][0]) { $sx--;        }  # ... 5...?
    elsif ($n eq $::padmap->[1][2]) { $sx++;        }
    elsif ($n eq $::padmap->[0][0]) { $sx--; $sy--; }
    elsif ($n eq $::padmap->[0][1]) {        $sy--; }
    elsif ($n eq $::padmap->[0][2]) { $sx++; $sy--; }
    # todo: bounds check!
    my $x = $::leader->screenx - $sx;
    my $y = $::leader->screeny - $sy;
    my $d = sqrt($x * $x + $y * $y);
    if ($d > $range or $sx < 1 or $sy < 1 or $sx > $::pref{map_width} or $sy > $::pref{map_height})
    {
      $sy = $oy; $sx = $ox;
    }
    gotoxy($sx,$sy);
  }
  # todo: allow cancel?
  return($sx-$leader->screenx,$sy-$leader->screeny);
}

sub blank_out
{
  my ($x1,$y1,$x2,$y2) = @_;
  while ($y1 <= $y2)
  {
    gotoxy($x1,$y1);
    ::display ' ' x ($x2-($x1+1)+2);
    $y1++;
  }
}

sub draw_box
{
  my ($x1,$y1,$x2,$y2) = @_;
  my $d = 1;
  while ($y1 <= $y2)
  {
    if ($y1 == $y2)
    {
      gotoxy($x1,$y1);
      ::display $sc{swbox};
      ::display $sc{sbox} x ($x2-($x1+1));
      ::display $sc{sebox};
    }
    elsif($d)
    {
      gotoxy($x1,$y1);
      ::display $sc{nwbox};
      ::display $sc{nbox} x ($x2-($x1+1));
      ::display $sc{nebox};
    }
    else
    {
      gotoxy($x1,$y1);
      ::display $sc{wbox};
      ::display ' ' x ($x2-($x1+1));
      ::display $sc{ebox};
    }
    $d = 0; $y1++;
  }
}

@message = ();
$pending = 0;

sub msg
{
  my $m = shift;
  my $n = '';
  my $r = quotemeta($m);
  if ($#message > -1 and $message[$#message] =~ /^$r/)
  {
    if ($message[$#message] =~ /\(x\d+\)$/)
    {
      $message[$#message] =~ s/\(x(\d+)\)/'(x'.($1+1).')'/e;
    } else
    {
      $message[$#message] .= " (x2)";
    } 
  } else
  {
    push @message, $m;
  }
  while ($m)
  {
    if ($pending)
    {
      moremsg();
    }
    gotoxy(1,$::pref{map_height}+1);
    ::color('grey','black');
    while (length($m) > $::setup{screen_width}-7)
    {
      if ($m =~ /\s+(\S+)$/)
      {
        $n = "$1 $n";
        $m = $`;
      } else
      {
        $n = substr($m, $::setup{screen_width}-7);
        $m = substr($m, 0, $::setup{screen_width}-8);
      }
    }
    ::display $m;
    ::clreol;
    $pending = 1;
    $m = $n;
    $n = '';
  }
  $::notice = 1;
  $::leader->review('messages') if defined $::leader;
}

sub moremsg
{
  gotoxy($::setup{screen_width}-7,$::setup{screen_height});
  ::color('black','grey');
  ::display("(more)");
  my $q = getkey();
}

sub clrmsg
{
  my $foo = shift || 0;
  $pending = 0;
  if ($foo)
  {
    gotoxy(1,$::setup{screen_height});
    ::color('grey','black');
    ::clreol;
  }
}


sub progress
{
  my $pct = shift;
  gotoxy($::setup{screen_width}-7,$::setup{screen_height});
  ::color('black','grey');
  ::display("[" . sprintf("%3d", int($pct * 100)) . "%]");
}

sub erase_progress
{
  gotoxy($::setup{screen_width}-7,$::setup{screen_height});
  ::color('grey','black');
  ::display("      ");
}

sub ask
{
  my $prompt = shift;
  my $maxlen = shift;
  my $p = shift;
  my $r = '';

  gotoxy(1,$::setup{screen_height});
  ::color('white','black');
  ::display $prompt;
  ::clreol();
  ::display ' ';
  $r = readstring($maxlen, $p);
  return $r;
}

sub game_frame
{
  ::color('sky','black');
  ::draw_box(1,1,$::setup{screen_width},$::setup{screen_height}-1);
  ::gotoxy($::setup{screen_width}-18,1);
  ::color('yellow','blue');
  ::display($::version);
  ::gotoxy(9,1);
  ::display("CARPE DIEM");
  ::color('grey','black');
}

sub center_text
{
  my $y = shift;
  my $text = shift;
  $text = ::fit($text,$::setup{screen_width}-2) if length($text) > $::setup{screen_width};
  ::gotoxy(int(($::setup{screen_width} - length($text)) / 2)+1, $y);
  ::display($text);
}

1;
