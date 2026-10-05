#!/usr/bin/perl
# Date created : 2nd Nov 2009
# Last modified : 13th Jan 2025
# Author : Quek Hong Cheang (modified by Jeff Walling)
# This script adds power pins (VDD VSS VNW VPW) 
# to a verilog netlist
# Usage: addpower.pl input.v output.v
if(@ARGV<2) {
die("Please enter 2 inputs: E.g. addpower.pl input.v output.v\n")
} #if
if(!open(inPort, @ARGV[0])) {
die("Cannot open file @ARGV[0]\n")
} #if
if(!open(outPort, ">@ARGV[1]")) {
die("Cannot create file @ARGV[1]\n")
} #if
 
# Start of user customization
$pin1="VDD";
$pin2="VSS";
$pin3="VNW";
$pin4="VPW";
#Set value to 0 if pwr pins should not be added to instances
$addPwrToInstances=1;
# End of user customization

$pwrAdded=0;
print outPort "// Added power pins $pin1, $pin2, $pin3 and $pin4 on : ".`date`."\n";

while( chomp($inLine=<inPort>) ) {
  $inLine2 = $inLine;
  $inLine2 =~ s/^ *//;
  @myList=split / /, $inLine2;

  if( @myList[0] =~ /module/ ) {
    $inLine=~s/\(/\($pin1, $pin2, $pin3, $pin4, /;
    $pwrAdded = 0; #Reset the flag for new modules
  } #if

  if( @myList[0] =~ /input/ && $pwrAdded==0) {
    $inLine=~s/input/inout $pin1, $pin2, $pin3, $pin4;\n input/;
    $pwrAdded=1;
  } #if

  if ($addPwrToInstances == 1) {
    my $instanceLine = $inLine;
    my $multiLine = 0;
    
    # Check if it's the start of an instance
    if ($instanceLine =~ /^\s*(\S+)\s+([\w\[\]\(\)\\]+)\s*\(/ && $instanceLine!~ /^\s*module\b/ && $instanceLine!~ /^\s*\./) {
      $multiLine = 1; # Set the flag
    }

    # Handle multi-line instances, but only if it's a multi-line instance.
    if ($multiLine) {
      while ($instanceLine =~ /\($/ && chomp($nextLine = <inPort>)) {
        $instanceLine.= $nextLine;
      }

      # Match instance instantiation (multi-line or single-line), handling square brackets and whitespace
      if ($instanceLine =~ /^\s*(\S+)\s+([\w\[\]\(\)\\]+)\s*\(/) {
        my $instanceName = $1;
        my $moduleName = $2;

        # Escape special characters for use in the regex substitution
	$instanceName =~ s/([\[\]\(\)\\])/\\$1/g;
	$moduleName =~ s/([\[\]\(\)\\])/\\$1/g;

        my $powerPins = ".$pin1\($pin1\),.$pin2\($pin2\),.$pin3\($pin1\),.$pin4\($pin2\), ";

        # Insert power pins at the beginning of the port list, preserving indentation
        if ($instanceLine =~ s/^\s*$instanceName\s+$moduleName\s*\(/$instanceName $moduleName \($powerPins/) {
                    print outPort $instanceLine, "\n";
                    next;
        } else {
          print STDERR "Failed to match instance: $instanceLine\n"; # Debugging output
        }
      }
    }
  }


  print outPort $inLine, "\n";
} #while

print "Output file @ARGV[1] generated\n"
