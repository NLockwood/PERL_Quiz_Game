$replay = "";
$correct = 0;
$rounds = 0;
$total_hints = 0;
$time0 = time;

%data = (
	'an alloy of iron and carbon', 'Steel',
	'the opposite of crystalline', 'Amorphous',
	'the ability to be pulled into a wire', 'Ductile',
	'the ability to be flattened/hammered into a flat sheet', 'Malleable',
	'an alloy of copper and tin', 'Bronze',
	'an alloy of copper and zinc', 'Brass',
	'an amorphous, transparent solid whose main ingredient is silicon dioxide', 'Glass',
	'the company that invented Gorilla Glass', 'Corning',
	'multiple forms/configurations of the same element', 'Allotrope',
	'mechanical strength resisting being pulled from opposite ends', 'Tensile Strength',
	'the type of mechanical force that scissors use', 'Shear Strength',
	'a physical mixture of two metals', 'Alloy',
	'Albania', 'Tirana',
	'Zimbabwe', 'Harare',
);

print "\n\t" . "*" x 58 . "\n";
print "\t\tWelcome to the Materials Science quiz game!\n";
print "\t\t\tType 'hint' for a hint or two...\n\t\t\tPS, don't worry about capitalization of answers!\n\n";

@questions = (keys(%data));
$question_count = @questions;
print "Checking... we have $question_count questions.\n\n";

while ($replay eq "") {
$question = $questions[int(rand(@questions))];
last if $question eq "";
$correct_answer = $data{$question};
$correct_answer =~ s/(\w+)/\u\L$1/g; # lower case, capital initial


print "What is $question?\t\t($question_count rounds until you win!)\n";
chomp ($answer = <STDIN>);
$rounds++;
$answer =~ s/(\w+)/\u\L$1/g; # lower case, capital initial

$hints = 0;
while ($answer eq "Hint") {
	print "The answer starts with " . substr ($data{$question}, 0, ($hints + 1)) . "\n";
	chomp ($answer = <STDIN>);
	$answer =~ s/(\w+)/\u\L$1/g; # lower case, capital initial
	$hints++;
}
$total_hints += $hints;

if ($answer eq $correct_answer) {
	print "That's right, $data{$question} is the answer to $question.\n";
	$correct++;
	delete $data{$question};
	@questions = ();
	@questions = (keys(%data));
	$question_count = @questions;
	if ($question_count == 0) {
		print "\n\t\t\t\tYou Win!!!\n\n";
		last;
	}
}
else {print "Sorry, that's wrong. $data{$question} is actually the answer to $question.\n";
	push @wrong, $correct_answer;
}

print "Press Enter to keep playing. To quit, type anything then press Enter.\n";
chomp ($replay = <STDIN>);
}

$time1 = time;
$seconds = ($time1-$time0);
print "You played $rounds rounds, you got $correct correct.\n";
print "Your total score is " . int(100*($correct/$rounds)) . "%.\nYou received $total_hints hints.\nYou took ", int(($seconds)/60), " minutes, ", ($seconds % 60), " seconds.\n";

undef %hash;
@hash{@wrong} = ();
@wrong = sort keys %hash;   # sorts "wrong" list, removes duplicate entries.

if (@wrong) {print "Work on these: " . join(", " , @wrong) . ".\n";}

print "\nThanks for playing, hope you enjoyed it!\n";
print "\tPS, feel free to share this program.     --Nate \n\n";
$null = <STDIN>;
