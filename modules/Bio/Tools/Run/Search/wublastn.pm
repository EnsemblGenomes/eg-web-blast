
# Let the code begin...
package Bio::Tools::Run::Search::wublastn;
use strict;
use Storable qw(dclone);

use vars qw( @ISA 
             $ALGORITHM $VERSION 
             $PARAMETER_OPTIONS 
             @PARAMETER_SENSITIVITIES
             $PROGRAM_NAME);

use Bio::Tools::Run::Search::WuBlast;

@ISA = qw( Bio::Tools::Run::Search::WuBlast );

BEGIN{
  $ALGORITHM     = 'BLASTN';
  $VERSION       = 'Unknown';
  $PROGRAM_NAME  = 'blastn';

  $PARAMETER_OPTIONS = dclone
    ( $Bio::Tools::Run::Search::WuBlast::PARAMETER_OPTIONS );

  @PARAMETER_SENSITIVITIES =
    ( @Bio::Tools::Run::Search::WuBlast::PARAMETER_SENSITIVITIES );


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


  # Turn off filtering for OLIGOs
#  $PARAMETER_OPTIONS->{'-filter'}{'default_OLIGO'}  = 'none';

#   $PARAMETER_OPTIONS->{'-M'} = # blastn only
#     {
#      default        => undef, #default: 5
#      default_LOW    => 1,
#      default_MEDIUM => 1,
#      default_HIGH   => 1,
#      default_EXACT  => 1,
#      default_OLIGO  => 1,
#      order          => 145,
#      options        => [ undef, 1,2,3,4,5 ],
#      description    => 'Match score',
#     };

#   $PARAMETER_OPTIONS->{'-N'} = # blastn only
#     {
#      default        => undef, #default: -4,
#      default_LOW    => -3,
#      default_MEDIUM => -1,
#      default_HIGH   => -1,
#      default_EXACT  => -3,
#      default_OLIGO  => -3,
#      order          => 146,
#      options        => [ undef, -1,-2,-3,-4,-5 ],
#      description    => 'Missmatch score',
#     };

 #  -W; Word size for seeding alignments
 #  $PARAMETER_OPTIONS->{'-W'}{'default_EXACT'}  = 15;
 #  $PARAMETER_OPTIONS->{'-W'}{'default_OLIGO'}  = 11;
 #  $PARAMETER_OPTIONS->{'-W'}{'default_LOW'}    = 15;
 #  $PARAMETER_OPTIONS->{'-W'}{'default_MEDIUM'} = 11;
 #  $PARAMETER_OPTIONS->{'-W'}{'default_HIGH'}   =  9;

  # -wink; Step-size for sliding-window used to seed alignments
#  $PARAMETER_OPTIONS->{'-wink'}{'default_EXACT'} = 15;

  # -Q, Cost of first gap character
#   $PARAMETER_OPTIONS->{'-Q'}{'default_EXACT'}  = 10;
#   $PARAMETER_OPTIONS->{'-Q'}{'default_OLIGO'}  = 3;
#   $PARAMETER_OPTIONS->{'-Q'}{'default_LOW'}    = 3;
#   $PARAMETER_OPTIONS->{'-Q'}{'default_MEDIUM'} = 2;
#   $PARAMETER_OPTIONS->{'-Q'}{'default_HIGH'}   = 2;

  # -R, Cost of second and remaining gap characters
 #  $PARAMETER_OPTIONS->{'-Q'}{'default_EXACT'}  = 10;
#   $PARAMETER_OPTIONS->{'-R'}{'default_OLIGO'}  = 3;
#   $PARAMETER_OPTIONS->{'-R'}{'default_LOW'}    = 3;
#   $PARAMETER_OPTIONS->{'-R'}{'default_MEDIUM'} = 1;
#   $PARAMETER_OPTIONS->{'-R'}{'default_HIGH'}   = 1;

  # -nogap; Turns off gapped alignments
#  $PARAMETER_OPTIONS->{'-nogap'}{'default_EXACT'} = 1;

  # -X; Alignment extension cutoff
#  $PARAMETER_OPTIONS->{'-X'}{'default_EXACT'} = 5;

  # -filter, Program used to filter query sequence
  $PARAMETER_OPTIONS->{'-f'}{'default'} = 'dust';
  $PARAMETER_OPTIONS->{'-f'}{'options'} = [ 'none','dust' ];

}

#----------------------------------------------------------------------
sub program_name{ 
  my $self = shift;
  my $pname = $self->SUPER::program_name(@_);
  return defined( $pname ) ?  $pname : $PROGRAM_NAME;
}
sub algorithm   { return $ALGORITHM }
sub version     { return $VERSION }
sub parameter_options { return $PARAMETER_OPTIONS }

#----------------------------------------------------------------------
1;
