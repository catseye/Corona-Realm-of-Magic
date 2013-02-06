package Supplement;

# Copyright (c)2000-2013, Chris Pressey, Cat's Eye Technologies.
# All rights reserved.
# Distributed under a BSD-style license; see the file LICENSE for more info.

use Carp;

BEGIN
{
  if ($^O eq 'MSWin32')
  {
    require Win32::Process;
    require Win32;
    require LWP::UserAgent;
  }
}

my %fields =
(
  'title'       => '',
  'media'       => undef,
  '_process'    => undef,
);

$::current_supplement = undef;

### UTILITY FUNCTIONS (do not take $self or $class arguement)

sub _WindowsErrorReport
{
  my $e = Win32::FormatMessage(Win32::GetLastError);
  $e =~ s/\n//gs;
  ::msg("Win32 error: $e");
  ::msg("Ensure that 'supplementary materials browser' is correctly set up in Preferences.");
  ::msg("Windows does not search your PATH variable for launching executables.");
  ::msg("An alternate solution is to copy your browser and it's configuration file(s) into the carpe directory.");
}

sub _webget
{
  my $file = shift;
  return 0 if -r "$::universe/sup/$file" and $::pref{supplementary} eq 'Cached';
  my $url = "http://www.catseye.mb.ca/games/carpe/$::universe/sup/$file";
  ::msg("Getting '$file' from www.catseye.mb.ca ...");
  ::clrmsg;
  my $ua = LWP::UserAgent->new;
  my $request = HTTP::Request->new(GET => $url);
  my $response = $ua->request($request);
  open WFILE, ">$::universe/sup/$file";
  binmode WFILE;
  if ($response->is_success)
  {
    print WFILE $response->content;
  } else
  {
    print WFILE $response->error_as_HTML;
  }
  close WFILE;
  return 1;
}

sub _spawn
{
  my $app = shift;
  my $foo = 1;
  if ($^O eq 'MSWin32')
  {
    my $arg = $app;
    $app =~ s/\s+(.*)$//gi;
    $arg =~ s/\.exe//gi;
    Win32::Process::Create($foo, $app, $arg, 0, 0, ".") || _WindowsErrorReport();
    #system "$app";
  } else
  {
    system "$app &";
  }
  return $foo;
}

### METHODS

sub new
{
  my $class = shift;
  my %params = @_;
  my $self =
  {
    '_permitted' => \%fields,
    %fields,
    'media' => [],
    %params,
  };
  bless $self, $class;
  return $self;
}

sub stop
{
  my $self = shift;
  return if $::pref{supplementary} eq 'Disabled';
  if ($^O eq 'MSWin32')
  {
    # if $self->{process} is still running...
    $self->{_process}->Kill(0);
    $::current_supplement = undef if $::current_supplement eq $self;
  } else
  {
    # ideally, kill pid of forked process
  }
}

sub browse
{
  my $self = shift;
  return if $::pref{supplementary} eq 'Disabled';
  $::current_supplement->stop if defined $::current_supplement;
  my $bg = ''; my $img = '';

  my $i; my @o = split (/,/, $self->{media});
  foreach $i (@o)
  {
    if ($i =~ /^(.*?)\/(.*?)$/)
    {
      my $ext = 'txt';
      my $type = $1;
      $ext = 'mid' if $type eq 'music';
      $ext = 'gif' if $type eq 'image';
      _webget "${i}.$ext" if $::pref{supplementary} ne 'Local';
      $img .= "<p><img src=\"$::universe/sup/${i}.$ext\">"  if $type eq 'image';
      $bg .= "<META HTTP-EQUIV=\"Refresh\" CONTENT=\"0; URL=$::universe/sup/${i}.$ext\">";
      # $bg .= "<bgsound src=\"$::universe/sup/${i}.$ext\">" if $type eq 'music';
    }
  }

  open FILE, ">temp.html";

  print FILE "<html><head><title>$self->{title}</title></head>\n";
  print FILE "<body bgcolor=#006000 text=#eeffff>\n";

  print FILE $bg;

  print FILE "<center><h1>$self->{title}</h1><hr width=33%>";

  print FILE "<table><tr><td>";
  print FILE $img;
  print FILE "</td><td valign=center align=center>";
  print FILE "<p>$self->{title}</td></tr></table><hr width=33%></center>";
  print FILE "</body></html>\n";
  close FILE;

  $self->{_process} =
    _spawn $::pref{browser};
  # _spawn "/progra~1/sympatico/communicator/program/netscape.exe c:/carpe/temp.html";
  # _spawn "/progra~1/intern~1/iexplore.exe temp.html";
  # _spawn "/progra~1/lynx/lynx.exe temp.html";

  $::current_supplement = $self;

}

END
{
  $::current_supplement->stop if defined $::current_supplement;
}

1;
