package Log::Log4perl::Appender::Wx::MessageBox;

=head1 DESCRIPTION

code inspiriert von
Log::Dispatch::Wx
und 
Log::Log4perl::Appender::Screen

=head1 USAGE

=cut

use 5.12.0;
use warnings;

use Wx qw( wxOK wxICON_ERROR wxICON_EXCLAMATION wxICON_INFORMATION );

use parent -norequire => 'Log::Log4perl::Appender';

sub new {
    my( $class, %p ) = @_;

    my $this = { name => $p{name} // 'wxMessageBoxLogger' };

    return bless $this, $class;
}

my %level_map = (
	'TRACE' => sub { Wx::MessageBox( $_[0], 'TRACE', wxOK | wxICON_INFORMATION ) },
    'DEBUG' => sub { Wx::MessageBox( $_[0], 'DEBUG', wxOK | wxICON_INFORMATION ) },
    'INFO'  => sub { Wx::MessageBox( $_[0], 'INFO' , wxOK | wxICON_INFORMATION ) },
    'WARN'  => sub { Wx::MessageBox( $_[0], 'WARN' , wxOK | wxICON_EXCLAMATION ) },
    'ERROR' => sub { Wx::MessageBox( $_[0], 'ERROR', wxOK | wxICON_ERROR       ) },
    'FATAL' => sub { Wx::MessageBox( $_[0], 'FATAL', wxOK | wxICON_ERROR       ) },
);

sub log {
	my ( $this, %p ) = @_;

	&{ $level_map{ $p{log4p_level} } }( $p{message} );
	
	1;
}

1;
