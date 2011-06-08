# vC::I::Win32.pm - Windows 95/98/NT raw console input
# v0.1 Jul 16 2000 Chris Pressey, Cat's Eye Technologies

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

BEGIN
{
  use Win32::Console;

  $::STDOUT = new Win32::Console(STD_OUTPUT_HANDLE);
  $::STDERR = new Win32::Console(STD_ERROR_HANDLE);
  $::STDIN  = new Win32::Console(STD_INPUT_HANDLE);

  sub getkey
  {
    my $key = '';
    my @event = ();
    $::STDOUT->Cursor(-1, -1, -1, 1);
    for(;;)
    {
      @event = $::STDIN->Input();
      if ($event[0] == 1 and $event[1] and $event[5] != 0)
      {
        $key = chr($event[5]);
        last;
      }
    }
    $::STDOUT->Cursor(-1, -1, -1, 0);
    return $key;
  }

}

END
{
  $::STDOUT->Cursor(-1, -1, -1, 1);
}

1;

### END ###
