=head1 NAME

Bio::Tools::Run::Search::EnsemblBlast - Base class for Ensembl BLAST searches

=head1 SYNOPSIS

  see Bio::Tools::Run::Search::WuBlast

=head1 DESCRIPTION

An extension of Bio::Tools::Run::Search::WuBlast to cope with the
ensembl blast farm. E.g. uses the bsub job submission system to
dispatch jobs. The jobs themselves are wrapped in the
utils/runblast.pm perl script.

=cut

# Let the code begin...
package Bio::Tools::Run::Search::EnsemblBlast;
use strict;
use File::Copy qw(mv);
use Data::Dumper qw(Dumper);

use vars qw( @ISA 
	     $BSUB_QUEUE $BSUB_RESOURCE
	     $MAX_BLAST_CPUS
	     $SPECIES_DEFS );

use Bio::Tools::Run::Search::WuBlast;
use EnsEMBL::Web::SpeciesDefs;
use Sys::Hostname qw(hostname);
#use warnings;


@ISA = qw( Bio::Tools::Run::Search::WuBlast );

BEGIN{
  $SPECIES_DEFS = EnsEMBL::Web::SpeciesDefs->new;

#  $BSUB_QUEUE    = "-q basement";
  $BSUB_QUEUE    = "-q fast";
  $BSUB_RESOURCE = "-R 'ncpus>1'";

  # Set default blast cpus flag for SMP boxes
  $MAX_BLAST_CPUS = 1;

}

#----------------------------------------------------------------------

=head2 run

  Arg [1]   : none
  Function  : Dispatches the blast job using the dispatch_bsub method
  Returntype: 
  Exceptions: 
  Caller    : 
  Example   : 

=cut

sub run {
  my $self = shift;

  if( $self->status ne 'PENDING' and
      $self->status ne 'DISPATCHED' ){
    $self->warn( "Wrong status for run: ". $self->status );
  }

  # Apply environment variables, keeping a backup copy
  my %ENV_TMP = %ENV;
  foreach my $env(  $self->environment_variable() ){
    my $val = $self->environment_variable( $env );
    if( defined $val ){ $ENV{$env} = $val }
    else{ delete( $ENV{$env} ) }
  }


  eval {

      my $command = $self->command;

      warn "\nCOMMAND:\n$command\n\n";

      $command = qq(echo '$command 2>/dev/null' | at now );
      $self->debug( "BLAST COMMAND: "  .$command."\n" );
      # Do the deed
      system ($command) == 0 or die $?;
	#system "$command >& /nas/panda/ensembl/ensembl-genomes/www-dev/kwwwtestcpy/tmp/blastout";
	#  $self->dispatch_bsub( $command );

    }; if ($@){ 
	warn "ERROR: $@";
	$self->status('FAILED');
    }


  # Restore environment
  %ENV = %ENV_TMP;
  return 1;
}



sub command{
  my $self = shift;

  #if( $self->seq->length < 30 ){ # Nasty hack to fudge blast stats
  #  $self->option( '-E'=>'100000' );
  #}

  if( ! -f $self->fastafile ){ $self->throw("Need a query sequence!") }

  my $res_file = $self->reportfile;
  if( -f $res_file ){ 
    $self->warn("A result already exists for $res_file" );
    unlink( $self->reportfile );
  }

  my $res_file_local = '/tmp/blast_$$.out';

  # Build a list of blast-specific environment variables and set these 
  # explicitly in the command. Apache(2)-safe.
  my $env_command = '';
#   foreach my $env qw( PATH BLASTMAT BLASTFILTER BLASTDB ){
   foreach my $env qw( PATH  ){
     my $val = $self->environment_variable( $env );
     $val = $ENV{$env} unless defined( $val );
     $val or  $self->warn( "$env variable not set" ) && next;
     $env_command .= sprintf( 'export %s=%s; ', $env, $val );
   }

  my $database
