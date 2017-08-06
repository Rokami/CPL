#!/usr/bin/perl
open IN,"vocabulary_list.txt"or die $!;
@file=<IN>;
chomp @file;
foreach(@file)
{
    s/\r//g;
}
%word=map{/(.*),(.*)/;lc($1)=>lc($2)}map{/(.*) -> (.*)/;map{$_.",".$1}split /,/,$2}@file;
undef @file;
close IN;
open IN,shift or die $!;
@file=<IN>;
%file=map{lc($_)=>++$file{lc($_)}}map{/\b[\w'-]+\b/g}@file;
close IN;
foreach $key(keys %file)
{
    if($word{$key})
    {
        $w{$word{$key}}+=$file{$key};
    }
    elsif($key=~/'(\w+)/&& $word{"'$1"})
    {
        $w{$word{"'$1"}}+=$file{$key};
    }
}
$i=0;
$pure_number=keys %w;
grep{$i+=$_}values %file;
print "Total word number: $i\n";
print "vocabulary number: $pure_number\n";
