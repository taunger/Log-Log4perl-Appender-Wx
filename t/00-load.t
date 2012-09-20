use Test::More tests => 1;

BEGIN {
    use_ok( 'Log::Log4perl::Appender::Wx' ) || print "Bail out!\n";
}

diag( "Testing Log::Log4perl::Appender::Wx $Log::Log4perl::Appender::Wx::VERSION, Perl $], $^X" );
