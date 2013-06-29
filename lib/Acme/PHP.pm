package Acme::PHP;

use warnings;
use strict;
use Carp;

use version; our $VERSION = qv('0.0.3');

my $processed;

return if $processed;

BEGIN{
    print "Content-type: text/html\n\n";

    open my $fh, "<", $0;
    my $code;
    my $flag = 0;

    while (my $line = <$fh>) {
        if ($line =~ /(.*)<\?perl(.*)\?>(.*)/) {
            my $html1 = $1;
            my $perl = $2;
            my $html2 = $3;

            $html1 =~ s/\'/\\\'/g;
            $html2 =~ s/\'/\\\'/g;

            $code .= "print '$html1';\n$perl\nprint '$html2';\n";
            next;
        }

        if ($line =~ /(.*)<\?perl(.*)/) {
            $flag = 1;

            my $html = $1;
            my $perl = $2;

            $html =~ s/\'/\\\'/g;

            $code .= "print '$html';\n$perl\n";
            next;
        }

        if ($line =~ /(.*)\?>(.*)/) {
            $flag = 0;

            my $perl = $1;
            my $html = $2;

            $html =~ s/\'/\\\'/g;

            $code .= "$perl;\nprint '$html';\n";
            next;
        }

        if ($flag) {
            my $perl = $line;
            $code .= "$perl\n";
        } else {
            my $html = $line;

            $html =~ s/\'/\\\'/g;

            $code .= "print '$html';\n";
        }
    }

    eval $code;

    if ($@) {
        die $@;
    }

    $processed = 1;

    exit;
}


# Module implementation here


1; # Magic true value required at end of module
__END__

=head1 NAME

Acme::PHP - The Perl Hypertext Preprocessor


=head1 VERSION

This document describes Acme::PHP version 0.0.1


=head1 SYNOPSIS

    use Acme::PHP;

    <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
      <title>Test with HTML::Preprocessor</title>
    </head>

    <body>
      <?perl
      print "This text is printed with perl!\n";
      ?>
    </body>
    </html>


=head1 DESCRIPTION

I have always dreamed of using perl embedded in HTML.


=head1 INTERFACE 

Nothing. Just use it.


=head1 DIAGNOSTICS

None.


=head1 CONFIGURATION AND ENVIRONMENT

Acme::PHP requires no configuration files or environment variables.


=head1 DEPENDENCIES

None.


=head1 INCOMPATIBILITIES

None reported.


=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<t11080hi [at] sfc.keio.ac.jp>.



=head1 AUTHOR

Kotone Itaya  C<< <t11080hi [at] sfc.keio.ac.jp> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2013, Kotone Itaya C<< <t11080hi [at] sfc.keio.ac.jp> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
