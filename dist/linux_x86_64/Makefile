BINSITEPERL = /usr/bin/site_perl
#LIBCOREPERL = $(shell for inc in $( perl -e "print qq(@INC)" ); do echo $inc; done | sed -n '/lib.*core/p')/
#LIBSITEPERL != for inc in $$( perl -e "print qq(@INC)" ); do echo $$inc; done | sed -n '/lib.*site/p'
#LIBCOREPERL = /usr/lib/perl5/5.34/core_perl/
#LIBSITEPERL = /usr/lib/perl5/5.34/site_perl
#SHARESITEPERL = /usr/share/perl5/site_perl

# BIBERSRC = $(wildcard ../../lib/*.pm ../../lib/*/*.pm ../../lib/*/*/*.pm ../../lib/*/*/*/*.pm ../../lib/*/*/*.xml)
OUTPUTNM = biber-linux_x86_64
INSTALLDIR = /usr/local/bin
INSTALLNM = biber

# UCPATH != perl -MUnicode::Collate -e 'print substr($$INC{"Unicode/Collate.pm"}, 0, -3)'
# MOZCAPATH != perl -MMozilla::CA -e 'print substr($$INC{"Mozilla/CA.pm"}, 0, -3)'
# PERLIOPATH != perl -MPerlIO::utf8_strict -e 'print substr($$INC{"PerlIO/utf8_strict.pm"}, 0, -3)'
# BUSISBNPATH != perl -MBusiness::ISBN -e 'print substr($$INC{"Business/ISBN.pm"}, 0, -3)'

.PHONY: all install uninstall dist clean

all: $(OUTPUTNM)

$(OUTPUTNM): $(BINSITEPERL)/biber
	@echo "Running PAR::Packer pp to package $(BINSITEPERL)/biber into $(OUTPUTNM)."
	@PAR_VERBATIM=1 $(BINSITEPERL)/pp \
		--addfile="../../data/schemata/bcf.rng;lib/Biber/bcf.rng" \
		--addfile="../../data/bcf.xsl;lib/Biber/bcf.xsl" \
		--addfile="../../lib/Biber/LaTeX/recode_data.xml;lib/Biber/LaTeX/recode_data.xml" \
		--cachedeps=scancache \
		--output=$(OUTPUTNM) \
		$<

# ../../bin/biber: ../../Build $(BIBERSRC)
# 	$< installdeps
# 	sudo $< install

# ../../Build: ../../Build.PL
# 	perl $<

install: $(OUTPUTNM)
	sudo cp $(OUTPUTNM) $(INSTALLDIR)/$(INSTALLNM)

uninstall:
	sudo rm $(INSTALLDIR)/$(INSTALLNM)/$(OUTPUTNM)

dist: $(OUTPUTNM)
	tar -czf $(OUTPUTNM).tar.gz $(OUTPUTNM)

clean:
	rm $(OUTPUTNM)


		# --module=deprecate \
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
		# --link=libbtparse.so \
		# --link=libxml2.so \
		# --link=libz.so \
		# --link=libxslt.so \
		# --link=libexslt.so \
		# --link=libssl.so \
		# --link=libcrypto.so \
		# --addfile="../../data/biber-tool.conf;lib/Biber/biber-tool.conf" \
		# --addfile="../../data/schemata/config.rnc;lib/Biber/config.rnc" \
		# --addfile="../../data/schemata/config.rng;lib/Biber/config.rng"\
		# --addfile="../../data/schemata/bcf.rnc;lib/Biber/bcf.rnc" \
		# --addfile="$(UCPATH)/Locale;lib/Unicode/Collate/Locale" \
		# --addfile="$(UCPATH)/CJK;lib/Unicode/Collate/CJK" \
		# --addfile="$(UCPATH)/allkeys.txt;lib/Unicode/Collate/allkeys.txt" \
		# --addfile="$(UCPATH)/keys.txt;lib/Unicode/Collate/keys.txt" \
		# --addfile="$(MOZCAPATH)/cacert.pem;lib/Mozilla/CA/cacert.pem" \
		# --addfile="/usr/local/perl/lib/${perlv}/x86_64-linux-thread-multi/PerlIO;lib/PerlIO" \
		# --addfile="/usr/local/perl/lib/${perlv}/x86_64-linux-thread-multi/auto/PerlIO;lib/auto/PerlIO" \
		# --addfile="$(BUSISBNPATH)/RangeMessage.xml;lib/Business/ISBN/RangeMessage.xml" \
