#!/usr/bin/perl -w

use strict;

my $szInputFilename = "/tmp/tst.txt";

my $szSingleLineList = "";

open(INFILE, "<$szInputFilename") || die("EEE Unable to open file '$szInputFilename' : $!");

while(<INFILE>) {
  chomp;
  $szSingleLineList .= " $_";
}

close(INFILE);

print "AdditionalPackageListInsideLxc: '$szSingleLineList'\n";
