# Before `make install' is performed this script should be runnable with
# `make test'.

#########################

use Test::More tests => 6;
BEGIN { use_ok('Polycom::App::URI') };
BEGIN { use_ok('Polycom::App::Push') };

# Test that the appropriate methods exist
can_ok('Polycom::App::Push', qw(new address username password push_message));
can_ok('Polycom::App::URI', qw(a softkeys));

# Test generating a hyperlink
{
	is(Polycom::App::URI::a('Key:Directory', 'View the phonebook'), '<a href="Key:Directory">View the phonebook</a>');
}

# Test generating a softkey document
{
	my $message =
	 '<html><h1>Fire drill at 2:00pm!</h1>'
	. Polycom::App::URI::softkeys(
		{index => 1, label => 'More Info', action => 'SoftKey:Fetch;en.wikipedia.org/wiki/Fire_dril'},
		{index => 2, label => "Exit",  action => 'SoftKey:Exit'})
	. '</html>';

	my $expected_message = '<html><h1>Fire drill at 2:00pm!</h1><softkey index="1" label="More Info" '
						. 'action="SoftKey:Fetch;en.wikipedia.org/wiki/Fire_dril"/>'
						. '<softkey index="2" label="Exit" action="SoftKey:Exit"/>'
						. '</html>';

	is($message, $expected_message);
}


