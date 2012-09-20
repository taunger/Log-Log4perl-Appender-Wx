package Log::Log4perl::Appender::Wx::ListView;

=head1 DESCRIPTION

=head1 USAGE

=cut

use 5.12.0;
use warnings;

use Wx qw( wxID_ANY wxLIST_FORMAT_LEFT wxLIST_FORMAT_RIGHT wxLIST_FORMAT_CENTRE );

use parent -norequire => 'Log::Log4perl::Appender';

my %appender;

sub new {
    my( $class, %p ) = @_;

	my $this = { 
		name              => $p{name} // 'wxListViewLogger',
		independent_frame => $p{independent_frame} // 1,
		ctrl              => undef,
		params            => $p{params}
	};
	
	for my $param ( keys %p ) {
		if ( $param =~ /^p(.+)$/ ) { 
			$this->{params}{ $1 } = $p{ $param };
		}
	}
	
	# params.0.header
	# params.0.layout
	# params.0.size
	# params.0.format

	my $i  = 0;
	for my $pnum ( sort { $a <=> $b } keys %{ $this->{params} } ) {
		$this->{col}[ $i ] = 
			#Log::Log4perl::Layout::PatternLayout->new( {
				#ConversionPattern => { value  => $p{params}{ $pnum }{layout} }
			#} );
			Log::Log4perl::Layout::PatternLayout->new( $this->{params}{ $pnum }{ layout} );
		$i++;
	}
	
	$appender{ $this->{name} } = $this;

    return bless $this, $class;
}

=head2 create_control

    create_control( parent ) -> Wx::ListView;



=cut

sub create_control {
	my ( $this, $parent ) = @_;

	die 'control already created' if $this->is_ctrl_created;
	
	my %format = (
		left   => wxLIST_FORMAT_LEFT, 
		right  => wxLIST_FORMAT_RIGHT, 
		centre => wxLIST_FORMAT_CENTRE,
	);
	
	my $c = Wx::ListView->new( $parent, wxID_ANY );
	
	my $i = 0;
	for my $p ( sort { $a <=> $b } keys %{ $this->{params} } ) {
		$c->InsertColumn( 
			$i, 
			$this->{params}{ $p }{header}            // '',
			$format{ $this->{params}{ $p }{format} } // $format{left},
			$this->{params}{ $p }{size}              // 30,
		);
		$i++;
	}
	
	return $this->{ctrl} = $c;
}

=head2 is_ctrl_created

    is_ctrl_created( ) -> ;



=cut

sub is_ctrl_created {
	my $this = shift;
	
	return $this->{ctrl} ? 1 : 0;
}

sub log {
	my ( $this, %p ) = @_;
use Data::Dumper;
print Dumper \%p;
	return if not $this->{ctrl};
	
	$this->{ctrl}->InsertStringItem( 0, "test" );
	
	1;
}

1;
