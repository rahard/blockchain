#! /usr/bin/perl
# a blockchain demo
# Budi Rahardjo (@rahard)
# 2017
# HOW TO USE
# $ cat genesis.txt transaction1.txt | ./genchain.pl

use Digest::SHA qw(sha256_hex);
# read input (slurp it)
# cat transactions | this script
my $transactions = do { local $/; <STDIN> };
print $transactions;

# fine the proper chain
# this is just a demo to give it 100 tries
int $i; 
for ($i=0; $i<100; $i++) {
   # generate chain
   $chain = int(rand(10000));
   print "$i - chain: $chain\n";
   $transchain = $transactions . $chain;
   
   # calculate hash
   $result=sha256_hex($transchain);
   print "hash: $result\n";
   
   # do something about the hash; 
   # this is just an example for demo
   # take the 1st 5 digits and convert them to unsigned value
   $valuestr = substr $result, 0, 5;
   $value = hex($valuestr);
   print "$valuestr $value\n";

   # this is the deciding factor if you can find THE CHAIN
   # if the value is less than 5000, then you found the chain
   if ($value < 5000) { 
      print "THE CHAIN: $chain\n";
      exit(); 
   }
}

# if after 100 tries chain is not found, exit
# and perhaps run it again
print "CAN'T FIND THE PROPER CHAIN\n";
