#!/usr/bin/perl

use strict;

use warnings;



unless ( @ARGV ) {

    die "Usage: $0 <filename>\n";

}



my $filename = $ARGV[0];



open my $in_fh, '<', $filename

  or die "Could not open '$filename' for reading: $!";



my $temp_filename = "$filename.tmp";

open my $out_fh, '>', $temp_filename

  or die "Could not open '$temp_filename' for writing: $!";



my $deleted_count = 0;



while ( my $line = <$in_fh> ) {

    chomp $line;



    # More precise regex to match the exact pattern

    if ( $line =~ /^\s*\+ ROUTED M6 TAPERRULE DEFAULT_M6_70 \( \d+ \d+ 0 \) \( \d+ \* 0 \) ;/ ) {

        $deleted_count++;

        next;

    }



    print $out_fh "$line\n";

}



close $in_fh;

close $out_fh;



rename $temp_filename, $filename

  or die "Could not rename '$temp_filename' to '$filename': $!";



print "Deleted $deleted_count lines.\n";
