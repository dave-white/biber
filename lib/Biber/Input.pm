package Biber::Input;
use v5.24;
use strict;
use warnings;

use Biber::Input::file::biblatexml;
use Biber::Input::file::bibtex;

sub new {
  my $self = shift;
  my $ftype = shift;
  my $datatype = shift;
  if ($datatype eq "biblatexml") { return Biber::Input::file::biblatexml->new() }
  elsif ($datatype eq "bbl") { return Biber::Input::file::bibtex->new() }
  else { return Biber::Input::file::bibtex->new() }
}

1;
