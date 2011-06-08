# vC.pm - settings for virtual Console
# v0.20 Nov 9 2000 Chris Pressey, Cat's Eye Technologies

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

### MODULES ###

BEGIN
{
  if (defined $::setup{input})
  {
    require "vC/I/$::setup{input}.pm";
  }
  elsif ($^O eq 'MSWin32')
  {
    require vC::I::Win32; # raw input module for Windows 95/98/NT
  }
  elsif ($^O eq 'freebsd' or $^O eq 'linux'  or $^O eq 'sunos'
      or $^O eq 'solaris' or $^O eq 'cygwin' or $^O =~ /^sco/)  # or any of a number of other POSIX systems I'm sure
  {
    $| = 1;
    require vC::I::POSIX; # raw input module for POSIX systems
  } else
  {
    die "Raw input not supported on operating system '$^O'";
  }

  if (defined $::setup{display})
  {
    require "vC/O/$::setup{display}.pm";
  }
  elsif ($^O eq 'MSWin32')
  {
    require vC::O::Win32; # console output module for Windows 95/98/NT
  }
  elsif ($^O ne '')
  {
    $| = 1;
    require vC::O::ANSI;  # generic screen output module
    # todo: termcap-based output module as well
  } else
  {
    die "Screen output not supported on operating system '$^O'";
  }
}

1;

### END ###
