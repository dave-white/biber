CELLAR = /usr/local/Cellar
BINPERL = $(CELLAR)/perl/5.34.0/bin
LIBPERL = $(CELLAR)/perl/5.34.0/lib
#LIBCOREPERL = $(shell for inc in $( perl -e "print qq(@INC)" ); do echo $inc; done | sed -n '/lib.*core/p')/
#LIBSITEPERL != for inc in $$( perl -e "print qq(@INC)" ); do echo $$inc; done | sed -n '/lib.*site/p'
#LIBCOREPERL = /usr/lib/perl5/5.34/core_perl/
#LIBSITEPERL = /usr/lib/perl5/5.34/site_perl
#SHARESITEPERL = /usr/share/perl5/site_perl

# BIBERSRC = $(wildcard ../../lib/*.pm ../../lib/*/*.pm ../../lib/*/*/*.pm ../../lib/*/*/*/*.pm ../../lib/*/*/*.xml)
OUTPUTNM = biber-darwin_x86_64
INSTALLDIR = /usr/local/bin
INSTALLNM = biber

UCPATH = $(LIBPERL)/perl5/5.34.0/Unicode/Collate
#UCPATH != perl -MUnicode::Collate -e 'print substr($$INC{"Unicode/Collate.pm"}, 0, -3)'
# MOZCAPATH != echo $$( perl -MMozilla::CA -e 'print substr($$INC{"Mozilla/CA.pm"}, 0, -3)' )
#PERLIOPATH != perl -MPerlIO::utf8_strict -e 'print substr($$INC{"PerlIO/utf8_strict.pm"}, 0, -3)'
# BUSISBNPATH != echo $$( perl -MBusiness::ISBN -e 'print substr($$INC{"Business/ISBN.pm"}, 0, -3)' )

all: $(OUTPUTNM)

$(OUTPUTNM): $(BINPERL)/biber
	sudo cp $< /tmp/biber-darwin
	@echo "Running PAR::Packer pp to package $(BINPERL)/biber into $(OUTPUTNM)."
	@PAR_VERBATIM=1 $(BINPERL)/pp \
		--module=Biber::Output::bbl \
		--module=Biber::Input::file::bibtex \
		--addfile="../../lib/Biber/LaTeX/recode_data.xml;lib/Biber/LaTeX/recode_data.xml" \
		--addfile="../../data/schemata/bcf.rng;lib/Biber/bcf.rng" \
		--addfile="../../data/bcf.xsl;lib/Biber/bcf.xsl" \
		--cachedeps=scancache \
		--output=$(OUTPUTNM) \
		/tmp/biber-darwin
	sudo rm -f /tmp/biber-darwin

  # --module=deprecate \
  # --module=Biber::Input::file::biblatexml \
  # --module=Biber::Output::dot \
  # --module=Biber::Output::bblxml \
  # --module=Biber::Output::bibtex \
  # --module=Biber::Output::biblatexml \
  # --module=Pod::Simple::TranscodeSmart \
  # --module=Pod::Simple::TranscodeDumb \
  # --module=List::MoreUtils::XS \
  # --module=List::SomeUtils::XS \
  # --module=List::MoreUtils::PP \
  # --module=HTTP::Status \
  # --module=HTTP::Date \
  # --module=Encode:: \
  # --module=File::Find::Rule \
  # --module=IO::Socket::SSL \
  # --module=IO::String \
  # --module=PerlIO::utf8_strict \
  # --module=Text::CSV_XS \
  # --module=DateTime \
  # --link=$(CELLAR)/libxml2/2.9.12/lib/libxml2.dylib \
  # --link=$(CELLAR)/libxslt/1.1.35/lib/libxslt.dylib \
  # --link=$(CELLAR)/libxslt/1.1.35/lib/libexslt.dylib \
  # --link=$(LIBPERL)/libbtparse.dylib \
  # --link=$(CELLAR)/openssl@1.1/1.1.1m/lib/libssl.dylib \
  # --link=$(CELLAR)/openssl@1.1/1.1.1m/lib/libcrypto.dylib \
  # --link=$(CELLAR)/libiconv/1.16/lib/libiconv.dylib \
  # --addfile="../../data/biber-tool.conf;lib/Biber/biber-tool.conf" \
  # --addfile="../../data/schemata/config.rnc;lib/Biber/config.rnc" \
  # --addfile="../../data/schemata/config.rng;lib/Biber/config.rng" \
  # --addfile="../../data/schemata/bcf.rnc;lib/Biber/bcf.rnc" \
  # --addfile="$(UCPATH)/CJK;lib/Unicode/Collate/CJK;lib/Unicode/Collate/CJK" 
  #  \
  # --addfile="$(UCPATH)/allkeys.txt;lib/Unicode/Collate/allkeys.txt" \
  # --addfile="$(UCPATH)/keys.txt;lib/Unicode/Collate/keys.txt" \
  # --addfile="$(UCPATH)/Locale;lib/Unicode/Collate/Locale" \
  # --addfile="$(LIBPERL)/perl5/site_perl/5.34.0/darwin-thread-multi-2level/auto/Unicode/LineBreak/LineBreak.bundle;lib/auto/Unicode/LineBreak/LineBreak.bundle" \
  # --addfile="$(shell perl -MMozilla::CA -e 'print substr($$INC{"Mozilla/CA.pm"}, 0, -3)' )/cacert.pem;lib/Mozilla/CA/cacert.pem" \
  # --addfile="$(shell perl -MBusiness::ISBN -e 'print substr($$INC{"Business/ISBN.pm"}, 0, -3)' )/RangeMessage.xml;lib/Business/ISBN/RangeMessage.xml" \

install: $(OUTPUTNM)
	sudo cp $(OUTPUTNM) $(INSTALLDIR)/$(INSTALLNM)

uninstall:
	sudo rm $(INSTALLDIR)/$(INSTALLNM)/$(OUTPUTNM)

dist: $(OUTPUTNM)
	tar -czf $(OUTPUTNM).tar.gz $(OUTPUTNM)

clean:
	rm $(OUTPUTNM)
