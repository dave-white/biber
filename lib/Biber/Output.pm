package Biber::Output;
use v5.24;
use strict;
use warnings;

use Biber::Output::base;
use Biber::Output::bbl;
use Biber::Output::bblxml;
use Biber::Output::biblatexml;
use Biber::Output::bibtex;
use Biber::Output::dot;

sub new {
  my $self = shift;
  my $type = shift;
  if ($type eq "base") { return Biber::Output::base->new() }
  elsif ($type eq "bbl") { return Biber::Output::bbl->new() }
  elsif ($type eq "bblxml") { return Biber::Output::bblxml->new() }
  elsif ($type eq "biblatexml") { return Biber::Output::biblatexml->new() }
  elsif ($type eq "bibtex") { return Biber::Output::bibtex->new() }
  elsif ($type eq "dot") { return Biber::Output::dot->new() }
  else { return Biber::Output::base->new() }
}

1;
