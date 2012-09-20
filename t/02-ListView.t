use strict;
use warnings FATAL => 'all';

use Test::More;

use Log::Log4perl;
#use lib '../lib';

SKIP: {
	skip 'Test can only run manuelly', 1 if not $ENV{'log_log4perl_appender_wx_manuell_test'};
	
	eval {
		Log::Log4perl::init( \<<LOGGER_CONFIG );
log4perl.logger = TRACE, wx
log4perl.appender.wx                          = Log::Log4perl::Appender::Wx::ListView
log4perl.appender.wx.layout                   = Log::Log4perl::Layout::NoopLayout
log4perl.appender.wx.p1.header = Test123
log4perl.appender.wx.p1.layout = %m    
log4perl.appender.wx.p1.size = 150
log4perl.appender.wx.p1.format = right
LOGGER_CONFIG

		use Wx qw( :everything );
		
		# create a fast app
		my $app = Wx::SimpleApp->new;
		
		# a frame for the app and a panel for the frame
		my $frame = Wx::Frame->new( undef, wxID_ANY, 'Testframe' );
		my $panel = Wx::Panel->new( $frame, wxID_ANY );
		
		# a main sizer
		my $sizer = Wx::BoxSizer->new( wxHORIZONTAL );
		
		#
		my $appender = Log::Log4perl->appender_by_name( 'wx' );
		my $ctrl = $appender->create_control( $panel );
		$sizer->Add( $ctrl, 1, wxEXPAND | wxALL, 10 );
		$panel->SetSizer( $sizer );
		$panel->SetAutoLayout( 1 );
		
		my $logger = Log::Log4perl->get_logger( );
		
		$logger->trace( 'trace' ); 
		$logger->debug( 'debug' ); 
		$logger->info( 'info' );   
		$logger->warn( 'warn' );   
		$logger->error( 'error' ); 
		$logger->fatal( 'fatal' ); 
		
		$frame->Show;
		$app->MainLoop;			
	
	};
	
	if ( $@ ) {
		fail 'test ListView: ' . $@;		
	} else {
		pass 'test ListView';
	}
	
};

ok( 1 );

done_testing( );





1;