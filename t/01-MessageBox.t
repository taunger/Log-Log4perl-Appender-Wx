use strict;
use warnings;

use Test::More;

use Log::Log4perl;

SKIP: {
	skip 'Test can only run manuelly', 1 if not $ENV{'log_log4perl_appender_wx_manuell_test'};
	
	eval {
		Log::Log4perl::init( \<<LOGGER_CONFIG );
log4perl.logger = TRACE, wx

log4perl.appender.wx                          = Log::Log4perl::Appender::Wx::MessageBox
log4perl.appender.wx.layout                   = Log::Log4perl::Layout::PatternLayout
log4perl.appender.wx.layout.ConversionPattern = %M %L:%n%n%m%n
LOGGER_CONFIG

		my $logger = Log::Log4perl->get_logger( );
		
		$logger->trace( 'trace' );
		$logger->debug( 'debug' );
		$logger->info( 'info' );
		$logger->warn( 'warn' );
		$logger->error( 'error' );
		$logger->fatal( 'fatal' );
		
	};
	
	if ( $@ ) {
		fail 'test MessageBox: ' . $@;		
	} else {
		pass 'test MessageBox';
	}
	
};

ok( 1 );

done_testing( );

1;