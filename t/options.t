# -*- cperl -*-
use strict;
use warnings;
use utf8;
no warnings 'utf8' ;

use Test::More tests => 9;
use Test::Differences;
unified_diff;

use Biber;
use Biber::Output::bbl;
use Log::Log4perl;
chdir("t/tdata") ;

# Set up Biber object
my $biber = Biber->new(noconf => 1);
my $LEVEL = 'ERROR';
my $l4pconf = qq|
    log4perl.category.main                             = $LEVEL, Screen
    log4perl.category.screen                           = $LEVEL, Screen
    log4perl.appender.Screen                           = Log::Log4perl::Appender::Screen
    log4perl.appender.Screen.utf8                      = 1
    log4perl.appender.Screen.Threshold                 = $LEVEL
    log4perl.appender.Screen.stderr                    = 0
    log4perl.appender.Screen.layout                    = Log::Log4perl::Layout::SimpleLayout
|;
Log::Log4perl->init(\$l4pconf);

$biber->parse_ctrlfile('options.bcf');
$biber->set_output_obj(Biber::Output::bbl->new());

# Options - we could set these in the control file but it's nice to see what we're
# relying on here for tests

# Biber options
Biber::Config->setoption('sortlocale', 'en_GB.UTF-8');

# Testing customg xsv format sep
Biber::Config->setoption('xsvsep', '\s*\|\s*');

# Biblatex options
Biber::Config->setblxoption(undef,'labeldatespec', [ {content => 'date', type => 'field'} ]);

# Now generate the information
$biber->prepare;
my $out = $biber->get_output_obj;
my $section = $biber->sections->get_section(0);
my $main = $biber->datalists->get_list('nty/global//global/global');
my $bibentries = $section->bibentries;

my $dmv =  [
              [
               {'presort'    => {}},
               {'mm'         => {}},
              ],
              [
               {'sortkey'    => {'final' => 1}}
              ],
              [
               {'sortname'   => {}},
               {'author'     => {}},
               {'editor'     => {}},
               {'translator' => {}},
               {'sorttitle'  => {}},
               {'title'      => {}}
              ],
              [
               {'sorttitle'  => {}},
               {'title'      => {}}
              ],
              [
               {'sortyear'   => {}},
               {'year'       => {}}
              ],
              [
               {'volume'     => {}},
               {'0000'       => {}}
              ]
             ];

my $bln = [ {content => 'author'}, {content => 'editor'} ];

my $l1 = q|    \entry{L1}{book}{}
      \name[default][en-us]{author}{1}{}{%
        {{un=0,uniquepart=base,hash=bd051a2f7a5f377e3a62581b0e0f8577}{%
           family={Doe},
           familyi={D\bibinitperiod},
           given={John},
           giveni={J\bibinitperiod},
           givenun=0}}%
      }
      \namepartms{author}{1}{%
          familydefaulten-us={Doe},
          familydefaulten-usi={D\bibinitperiod},
          givendefaulten-us={John},
          givendefaulten-usi={J\bibinitperiod}
      }
      \list[default][en-us]{publisher}{1}{%
        {Oxford}%
      }
      \listitemms{publisher}{1}{%
        defaulten-us={Oxford}
      }
      \strng{namehash}{bd051a2f7a5f377e3a62581b0e0f8577}
      \strng{fullhash}{bd051a2f7a5f377e3a62581b0e0f8577}
      \strng{bibnamehash}{bd051a2f7a5f377e3a62581b0e0f8577}
      \strng{authordefaulten-usbibnamehash}{bd051a2f7a5f377e3a62581b0e0f8577}
      \strng{authordefaulten-usnamehash}{bd051a2f7a5f377e3a62581b0e0f8577}
      \strng{authordefaulten-usfullhash}{bd051a2f7a5f377e3a62581b0e0f8577}
      \field{sortinit}{D}
      \strng{sortinithash}{6f385f66841fb5e82009dc833c761848}
      \field{extradatescope}{labelyear}
      \field{labeldatesource}{}
      \fieldmssource{labelname}{author}{default}{en-us}
      \fieldmssource{labeltitle}{title}{default}{en-us}
      \field{day}{5}
      \field{month}{4}
      \field{origday}{30}
      \field{origmonth}{10}
      \field{origyear}{1985}
      \field[default][en-us]{title}{Title 1}
      \field{year}{1998}
      \field{dateera}{ce}
      \field{origdateera}{ce}
      \keyw{one,two,three}
    \endentry
|;

my $l2 = q|    \entry{L2}{book}{maxalphanames=10,maxbibnames=3,maxcitenames=3,maxitems=2}
      \name[default][en-us]{author}{1}{}{%
        {{un=0,uniquepart=base,hash=19eec87c959944d6d9c72434a42856ba}{%
           family={Edwards},
           familyi={E\bibinitperiod},
           given={Ellison},
           giveni={E\bibinitperiod},
           givenun=0}}%
      }
      \namepartms{author}{1}{%
          familydefaulten-us={Edwards},
          familydefaulten-usi={E\bibinitperiod},
          givendefaulten-us={Ellison},
          givendefaulten-usi={E\bibinitperiod}
      }
      \list[default][en-us]{publisher}{1}{%
        {Oxford}%
      }
      \listitemms{publisher}{1}{%
        defaulten-us={Oxford}
      }
      \strng{namehash}{19eec87c959944d6d9c72434a42856ba}
      \strng{fullhash}{19eec87c959944d6d9c72434a42856ba}
      \strng{bibnamehash}{19eec87c959944d6d9c72434a42856ba}
      \strng{authordefaulten-usbibnamehash}{19eec87c959944d6d9c72434a42856ba}
      \strng{authordefaulten-usnamehash}{19eec87c959944d6d9c72434a42856ba}
      \strng{authordefaulten-usfullhash}{19eec87c959944d6d9c72434a42856ba}
      \field{sortinit}{E}
      \strng{sortinithash}{8da8a182d344d5b9047633dfc0cc9131}
      \field{extradatescope}{labelyear}
      \field{labeldatesource}{}
      \fieldmssource{labelname}{author}{default}{en-us}
      \fieldmssource{labeltitle}{title}{default}{en-us}
      \field{day}{5}
      \field{month}{4}
      \field[default][en-us]{title}{Title 2}
      \field{year}{1998}
      \field{dateera}{ce}
    \endentry
|;

my $l3 = q|    \entry{L3}{book}{blah=10}
      \name[default][en-us]{author}{1}{}{%
        {{un=0,uniquepart=base,hash=490250da1f3b92580d97563dc96c6c84}{%
           family={Bluntford},
           familyi={B\bibinitperiod},
           given={Bunty},
           giveni={B\bibinitperiod},
           givenun=0}}%
      }
      \namepartms{author}{1}{%
          familydefaulten-us={Bluntford},
          familydefaulten-usi={B\bibinitperiod},
          givendefaulten-us={Bunty},
          givendefaulten-usi={B\bibinitperiod}
      }
      \list[default][en-us]{publisher}{1}{%
        {Oxford}%
      }
      \listitemms{publisher}{1}{%
        defaulten-us={Oxford}
      }
      \strng{namehash}{490250da1f3b92580d97563dc96c6c84}
      \strng{fullhash}{490250da1f3b92580d97563dc96c6c84}
      \strng{bibnamehash}{490250da1f3b92580d97563dc96c6c84}
      \strng{authordefaulten-usbibnamehash}{490250da1f3b92580d97563dc96c6c84}
      \strng{authordefaulten-usnamehash}{490250da1f3b92580d97563dc96c6c84}
      \strng{authordefaulten-usfullhash}{490250da1f3b92580d97563dc96c6c84}
      \field{sortinit}{B}
      \strng{sortinithash}{d7095fff47cda75ca2589920aae98399}
      \field{extradatescope}{labelyear}
      \field{labeldatesource}{}
      \fieldmssource{labelname}{author}{default}{en-us}
      \fieldmssource{labeltitle}{title}{default}{en-us}
      \field{day}{5}
      \field{month}{4}
      \field[default][en-us]{title}{Title 3}
      \field{year}{1999}
      \field{dateera}{ce}
    \endentry
|;

ok(Biber::Config->getblxoption(undef,'uniquename') eq 'init', "Single-valued option") ;
is_deeply(Biber::Config->getblxoption(undef,'labelnamespec'), [ {content => 'author'} ], "Multi-valued options");
ok(Biber::Config->getoption('mincrossrefs') == 88, "Setting Biber options via control file");
ok(Biber::Config->getblxoption(undef,'useprefix', 'book') == 1 , "Per-type single-valued options");
is_deeply(Biber::Config->getblxoption(undef,'labelnamespec', 'book'), $bln, "Per-type multi-valued options");
eq_or_diff($bibentries->entry('L1')->get_labeldate_info->{field}{year}, 'year', 'Global labelyear setting' ) ;
eq_or_diff( $out->get_output_entry('L1', $main), $l1, 'Global labelyear setting - labelyear should be YEAR') ;
eq_or_diff( $out->get_output_entry('L2', $main), $l2, 'Entry-local biblatex option mappings - 1') ;
eq_or_diff( $out->get_output_entry('L3', $main), $l3, 'Entry-local biblatex option mappings - 2') ;
