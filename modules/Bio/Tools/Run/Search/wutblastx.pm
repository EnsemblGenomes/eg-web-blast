

# Let the code begin...
package Bio::Tools::Run::Search::wutblastx;
use strict;
use Storable qw(dclone);

use vars qw( @ISA 
	     $ALGORITHM $VERSION 
	     $PARAMETER_OPTIONS
	     $PROGRAM_NAME );

use Bio::Tools::Run::Search::WuBlast;

@ISA = qw( Bio::Tools::Run::Search::WuBlast );

BEGIN{

  $ALGORITHM     = 'TBLASTX';
  $VERSION       = '1.4.6';
  $PROGRAM_NAME  = 'tblastx';

  $PARAMETER_OPTIONS = dclone
    ( $Bio::Tools::Run::Search::WuBlast::PARAMETER_OPTIONS );

  delete( $PARAMETER_OPTIONS->{'-matrix'} ); # NA for blastn
  delete( $PARAMETER_OPTIONS->{'-T'} );      # NA for blastn

  delete( $PARAMETER_OPTIONS->{'-RepeatMasker'} ); # NA for ebi blast
  delete( $PARAMETER_OPTIONS->{'-W'} );       # NA ebi blast
  delete( $PARAMETER_OPTIONS->{'-hitdist'} ); # NA ebi blast
  delete( $PARAMETER_OPTIONS->{'-Q'} );       # NA ebi blast
  delete( $PARAMETER_OPTIONS->{'-R'} );       # NA ebi blast
  delete( $PARAMETER_OPTIONS->{'-nogap'} );   # NA ebi blast
  delete( $PARAMETER_OPTIONS->{'-X'} );       # NA ebi blast
  delete( $PARAMETER_OPTIONS->{'-M'} );    # NA ebi blast
  delete( $PARAMETER_OPTIONS->{'-wink'} );    # NA ebi blast




  # -filter, Program used to filter query sequence
  $PARAMETER_OPTIONS->{'-f'}{'default'} = 'seg';
  $PARAMETER_OPTIONS->{'-f'}{'options'} = [ 'none','seg' ];



#   $PARAMETER_OPTIONS->{'-W'}{'default_LOW'}    = 4;
#   $PARAMETER_OPTIONS->{'-W'}{'default_MEDIUM'} = 4;
#   $PARAMETER_OPTIONS->{'-W'}{'default_HIGH'}   = 3;
#   $PARAMETER_OPTIONS->{'-W'}{'default_EXACT'}  = 6;

#   $PARAMETER_OPTIONS->{'-hitdist'}{'default_LOW'}  = 40;
#   $PARAMETER_OPTIONS->{'-hitdist'}{'default_HIGH'} = 40;

#   $PARAMETER_OPTIONS->{'-matrix'}{'default_LOW'}   ='BLOSUM62';
#   $PARAMETER_OPTIONS->{'-matrix'}{'default_MEDIUM'}='BLOSUM62';
#   $PARAMETER_OPTIONS->{'-matrix'}{'default_HIGH'}  ='BLOSUM62';
#   $PARAMETER_OPTIONS->{'-matrix'}{'default_EXACT'} ='BLOSUM80';

#   $PARAMETER_OPTIONS->{'-T'}{'default_LOW'}    = 20;
#   $PARAMETER_OPTIONS->{'-T'}{'default_MEDIUM'} = 20;
#   $PARAMETER_OPTIONS->{'-T'}{'default_HIGH'}   = 15;
#   $PARAMETER_OPTIONS->{'-T'}{'default_EXACT'}  = 999;

#   $PARAMETER_OPTIONS->{'-X'   }{'default_EXACT'}  = 10;
#   $PARAMETER_OPTIONS->{'-nogap'}{'default_EXACT'}  = 1;

}

#----------------------------------------------------------------------
sub program_name{ 
  my $self = shift;
  my $pname = $self->SUPER::program_name(@_);
  return defined( $pname ) ?  $pname : $PROGRAM_NAME;
}
sub algorithm   { return $ALGORITHM }
sub version     { return $VERSION }
sub parameter_options{ return $PARAMETER_OPTIONS }
#----------------------------------------------------------------------
1;
