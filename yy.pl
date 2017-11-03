$from=1992;
$to=2004;
$extrapackage="\\usepackage{txfonts}";
$nendobun='年度分';
$pankyo='一般教育科目';
$pankyo2='一般教育科目（英語なし）';
$senmon='物理専門科目';

if(1){
for $y($from..$to){
	print "emitting ${y}pankyo\n";
	open(OUT,">${y}pankyo.tex");
	"$y" =~/..(..)/;
	$yy=$1;
print OUT <<EOF;
%=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% ${y}$nendobun
%=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*

\\documentclass[fleqn]{jbook}
\\usepackage{physpub}
$extrapackage
\\begin{document}
{
\\def\\exam{$pankyo}
\\chapter{$y}
EOF
for $p("engl","math","phys"){
	if(-e "$y$p.tex"){
		push @{$depend{"${y}pankyo"}}, "$y$p.tex";
		print OUT "\\inputquestion{$y$p.tex}\n"
	}
}
for $p("engl","math","phys"){
	if(-e "$y$p.tex"){
		print OUT "\\inputanswer{$y$p.tex}\n"
	}
}

print OUT <<EOF;
}
\\end{document}
EOF
close(OUT);


# 英語なしの一般教育を作るために足してみました
	print "emitting ${y}pankyo2\n";
	open(OUT,">${y}pankyo2.tex");
	"$y" =~/..(..)/;
	$yy=$1;
print OUT <<EOF;
%=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% ${y}$nendobun
%=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*

\\documentclass[fleqn]{jbook}
\\usepackage{physpub}
$extrapackage
\\begin{document}
{
\\def\\exam{$pankyo2}
\\chapter{$y}
EOF
for $p("math","phys"){
	if(-e "$y$p.tex"){
		push @{$depend{"${y}pankyo2"}}, "$y$p.tex";
		print OUT "\\inputquestion{$y$p.tex}\n"
	}
}
for $p("math","phys"){
	if(-e "$y$p.tex"){
		print OUT "\\inputanswer{$y$p.tex}\n"
	}
}

print OUT <<EOF;
}
\\end{document}
EOF
close(OUT);



	print "emitting ${y}senmon\n";
	open(OUT,">${y}senmon.tex");
	"$y" =~/..(..)/;
	$yy=$1;
print OUT <<EOF;
%=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% ${y}$nendobun
%=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*

\\documentclass[fleqn]{jbook}
\\usepackage{physpub}
$extrapackage
\\begin{document}
{

\\def\\exam{$senmon}
\\chapter{$y}
EOF
	for $f(<${y}phy?.tex>){
		if($f eq "${y}phys.tex"){
			print "rejected $f in senmon\n";
			next;
		}
		unshift @{$depend{"${y}senmon"}}, "$f";
		print OUT "\\inputquestion{$f}\n";
	}
	for $f(<${y}phy?.tex>){
		if($f eq "${y}phys.tex"){
			print "rejected $f in senmon\n";
			next;
		}
		print OUT "\\inputanswer{$f}\n";
	}
	print OUT <<EOF;
}
\\end{document}
EOF
close(OUT);
}
}

print "emitting Makefile\n";
open(OUT, ">Makefile");
print OUT "all: ";
for $i($from..$to){
for $c(("pankyo","pankyo2","senmon")){
for $e(("ps.gz","pdf")){
	print OUT "$i$c.$e ";
}}}
print OUT "\n\n";
print OUT "pdf: ";
for $i($from..$to){
for $c(("pankyo","pankyo2","senmon")){
for $e(("pdf")){
	print OUT "$i$c.$e ";
}}}
print OUT "\n\n";
print OUT "ps: ";
for $i($from..$to){
for $c(("pankyo","pankyo2","senmon")){
for $e(("ps.gz")){
	print OUT "$i$c.$e ";
}}}
print OUT "\n\n";
for $k($from..$to){
	for $l(("pankyo","pankyo2","senmon")){
		$i="$k$l";
		$files=sprintf "%s", "@{$depend{$i}}";
		print OUT <<EOF;
$i.dvi: $files
	platex $i.tex
	platex $i.tex
	platex $i.tex

$i.ps.gz: $i.dvi
	-rm $i.ps.gz
	dvipsk -z -D600 $i.dvi
	gzip -9 $i.ps

$i.pdf: $i.dvi
	dvipdfm $i.dvi

EOF
	}
}
close(OUT);
