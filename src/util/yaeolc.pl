#!/usr/local/bin/perl -w

# yaeolc.pl - Yet Another End Of Line Converter
# v2000.07.18 Chris Pressey, Cat's Eye Technologies

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
#   Neither name of Cat's Eye Technologies nor the names of its
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

# Why yaeolc.pl?
# - Need script to massage Befunge source files to sensible EOLs.
# - Need conversion for mounting MS-DOS partition under FreeBSD/Linux.
# - For both of these tasks it is extremely useful to have a script
#   which just "readjusts" all text files in the current directory
#   to the EOL convention which makes the most sense locally.

# How yaeolc.pl differs from other utilities like it:
# - if no file names are given, converts every file in the current dir
# - recurses into directories if -r switch is given
# - auto-detects file types - will not convert files which look like
#   binary or directory files unless they're explicitly forced with -f
# - always converts files to what it considers the current native EOL
# - -crcrlf looks for and xlates the mangled marker 'CR CR LF' => EOL

# usage: [perl] yaeolc[.pl] [-f] [-q] [-r] [-crcrlf] {files}

# history:
#  v0.7  Jul 17 2000 - hacked together in primary form.
#  v2000.07.18       - added recursive operation into subdirs.
#                    - improved (GNUified) switches somewhat.

### GLOBALS ###

my $switch = '';
my $force  = 0;
my $crcrlf = 0;
my $quiet  = 0;
my $recur  = 0;

my $file   = '';
my $count  = 0;

### SUBS ###

sub convert
{
  my $file = shift;
  my @char = ();
  my $q; my $i;
  open FILE, $file;
  binmode FILE;
  while (read(FILE, $q, 1))
  {
    push @char, ord($q);
  }
  close FILE;

  $i = 0;
  while ($i <= $#char)
  {
    if($char[$i] == 13)      # Mac or MS-DOS EOL
    {
      if($char[$i+1] == 10)  # MS-DOS EOL
      {
        $char[$i] = -2; $i++;
      } else                 # Mac or Mangled EOL
      {
        if($char[$i+1] == 13 and $char[$i+2] == 10 and $crcrlf)
        {                    # Mangled EOL
          $char[$i] = -3; $i += 2;
        } else               # Mac EOL
        {
          $char[$i] = -1;
        }
      }
    } elsif($char[$i] == 10) # Unix EOL
    {
      $char[$i] = -1;
    }
    $i++;
  }

  open FILE, ">$file";  # overwrite file
  while (defined($q = shift @char))
  {
    if ($q < 0)
    {
      print FILE "\n";
      if ($q == -2)
      {
        $q = shift @char;  # ignore second char in EOL
      }
      elsif ($q == -3)
      {
        $q = shift @char;  # ignore second and third chars
        $q = shift @char;
      }
    } else
    {
      print FILE chr($q);
    }
  }
  close FILE;
}

sub convertdir
{
  my $dir = shift;
  my $fh = shift;
  my $file;
  print "Processing directory: $dir\n";
  opendir $fh, $dir;
  while (defined($file = readdir $fh))
  {
    next if $file eq '..' or $file eq '.';
    if (-d "$dir/$file")
    {
      convertdir("$dir/$file", "_$fh") if $recur;
      next;
    }
    if(not -T "$dir/$file")
    {
      print "* $dir/$file does not look like a text file\n" if not $quiet;
      next if not $force;
    }
    print "Converting $dir/$file...\n" if not $quiet;
    convert "$dir/$file";  $count++;
  }
  closedir $fh;
}

### MAIN ###

while (defined($ARGV[0]) and $ARGV[0] =~ /^\-\-?(\w+?)$/)
{
  $switch = $1; shift @ARGV;
  if    ($switch eq 'f' or $switch eq 'force') { $force = 1 }
  elsif ($switch eq 'q' or $switch eq 'quiet') { $quiet = 1 }
  elsif ($switch eq 'r' or $switch eq 'recurse') { $recur = 1 }
  elsif ($switch eq 'crcrlf') { $crcrlf  = 1 }
  else
  {
    die "Usage: [perl] yaeolc[.pl] [-q] [-f] [-r] [-crcrlf] {files}\n";
  }
}

print "yaeolc.pl v2000.07.18 Chris Pressey, Cat's Eye Technologies\n" if not $quiet;

if (defined $ARGV[0])
{
  while (defined $ARGV[0])
  {
    $file = shift @ARGV;
    if (-d $file)
    {
      convertdir($file, 'DIR') if $recur;
      next;
    }
    if(not -T $file)
    {
      print "* $file does not look like a text file\n" if not $quiet;
      next if not $force;
    }
    print "Converting $file...\n" if not $quiet;
    convert $file;  $count++;
  }
} else
{
  convertdir('.', 'DIR');
}
print "Done processing, $count files converted.\n" if not $quiet;

### END ###