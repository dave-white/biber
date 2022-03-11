PERLVER = 5.34.0
PERLDIR = /usr/local/Cellar/perl/$(PERLVER)/
LIBPERL = $(PERLDIR)lib/
LIBPERLSVER = $(PERLDIR)lib/perl5/
LIBPERLVER = $(LIBPERLSVER)$(PERLVER)/
LIBSITEPERL = $(LIBPERLSVER)site_perl/
INSTALLDIR = /usr/local/bin/
INSTALLNM = biber
BINSITEPERL = /usr/bin/site_perl/

.DEFAULT: pack
.PHONY: pack install

install: pack
	cp biber-linux_x86_64 $(INSTALLDIR)$(INSTALLNM)

pack: $(BINSITEPERL)biber
	PAR_VERBATIM = 1; \
	pp \
		--module=deprecate \
		--module=Biber::Input::file::bibtex \
		--module=Biber::Input::file::biblatexml \
		--module=Biber::Output::dot \
		--module=Biber::Output::bbl \
		--module=Biber::Output::bblxml \
		--module=Biber::Output::bibtex \
		--module=Biber::Output::biblatexml \
		--module=Pod::Simple::TranscodeSmart \
		--module=Pod::Simple::TranscodeDumb \
		--module=List::MoreUtils::XS \
		--module=List::SomeUtils::XS \
		--module=List::MoreUtils::PP \
		--module=HTTP::Status \
		--module=HTTP::Date \
		--module=Encode:: \
		--module=File::Find::Rule \
		--module=IO::Socket::SSL \
		--module=IO::String \
		--module=PerlIO::utf8_strict \
		--module=Text::CSV_XS \
		--module=DateTime \
		--link=libbtparse.so \
		--link=libxml2.so \
		--link=libz.so \
		--link=libxslt.so \
		--link=libexslt.so \
		--link=libssl.so \
		--link=libcrypto.so \
		--addfile="../../data/biber-tool.conf;lib/Biber/biber-tool.conf" \
		--addfile="../../data/schemata/config.rnc;lib/Biber/config.rnc" \
		--addfile="../../data/schemata/config.rng;lib/Biber/config.rng"\
		--addfile="../../data/schemata/bcf.rnc;lib/Biber/bcf.rnc" \
		--addfile="../../data/schemata/bcf.rng;lib/Biber/bcf.rng" \
		--addfile="../../lib/Biber/LaTeX/recode_data.xml;lib/Biber/LaTeX/recode_data.xml" \
		--addfile="../../data/bcf.xsl;lib/Biber/bcf.xsl" \
		--addfile="${ucpath}/Locale;lib/Unicode/Collate/Locale" \
		--addfile="${ucpath}/CJK;lib/Unicode/Collate/CJK" \
		--addfile="${ucpath}/allkeys.txt;lib/Unicode/Collate/allkeys.txt" \
		--addfile="${ucpath}/keys.txt;lib/Unicode/Collate/keys.txt" \
		--addfile="$(LIBSITEPERL)Mozilla/CA/cacert.pem;lib/Mozilla/CA/cacert.pem" \
		--addfile="/usr/local/perl/lib/${perlv}/x86_64-linux-thread-multi/PerlIO;lib/PerlIO" \
		--addfile="/usr/local/perl/lib/${perlv}/x86_64-linux-thread-multi/auto/PerlIO;lib/auto/PerlIO" \
		--addfile="$(LIBSITEPERL)Business/ISBN/RangeMessage.xml;lib/Business/ISBN/RangeMessage.xml" \
		--cachedeps=scancache \
		--output=biber-linux_x86_64 \
		$(BINSITEPERL)biber

$(BINSITEPERL)biber:
	sudo ../../Build install
