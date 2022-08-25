#! /usr/bin/env bash

source "$HOMEgfs/ush/preamble.sh"

################################################################################
####  UNIX Script Documentation Block
#                      .                                             .
# Script name:         exgdas_vrfminmon.sh
# Script description:  Runs data extract/validation for GSI normalization diag data
#
# Author:        Ed Safford       Org: NP23         Date: 2015-04-10
#
# Abstract: This script runs the data extract/validation portion of the 
#           MinMon package.  
#
# Condition codes
#       0 - no problem encountered
#      >0 - some problem encountered
#
################################################################################


########################################
#  Set environment
########################################
export RUN_ENVIR=${RUN_ENVIR:-nco}
export NET=${NET:-gfs}
export RUN=${RUN:-gdas}
export envir=${envir:-prod}

########################################
#  Command line arguments
########################################
export PDY=${1:-${PDY:?}} 
export cyc=${2:-${cyc:?}}

########################################
#  Directories
########################################
export DATA=${DATA:-$(pwd)}


########################################
#  Filenames
########################################
gsistat=${gsistat:-$COMIN/gdas.t${cyc}z.gsistat}
export mm_gnormfile=${gnormfile:-${M_FIXgdas}/gdas_minmon_gnorm.txt}
export mm_costfile=${costfile:-${M_FIXgdas}/gdas_minmon_cost.txt}

########################################
#  Other variables
########################################
export MINMON_SUFFIX=${MINMON_SUFFIX:-GDAS}
export PDATE=${PDY}${cyc}
export NCP=${NCP:-/bin/cp}
export pgm=exgdas_vrfminmon.sh

if [[ ! -d ${DATA} ]]; then
   mkdir $DATA
fi
cd $DATA

######################################################################

data_available=0

if [[ -s ${gsistat} ]]; then

   data_available=1                                         

   #-----------------------------------------------------------------------
   #  Copy the $MINMON_SUFFIX.gnorm_data.txt file to the working directory
   #  It's ok if it doesn't exist; we'll create a new one if needed.
   #
   #  Note:  The logic below is to accomodate two different data storage
   #  methods.  Some parallels (and formerly ops) dump all MinMon data for
   #  a given day in the same directory (if condition).  Ops now separates
   #  data into ${cyc} subdirectories (elif condition).
   #-----------------------------------------------------------------------
   if [[ -s ${M_TANKverf}/gnorm_data.txt ]]; then
      $NCP ${M_TANKverf}/gnorm_data.txt gnorm_data.txt
   elif [[ -s ${M_TANKverfM1}/gnorm_data.txt ]]; then
      $NCP ${M_TANKverfM1}/gnorm_data.txt gnorm_data.txt
   fi


   #------------------------------------------------------------------
   #   Run the child sccripts.
   #------------------------------------------------------------------
   ${USHminmon}/minmon_xtrct_costs.pl ${MINMON_SUFFIX} ${PDY} ${cyc} ${gsistat} dummy
   rc_costs=$?
   echo "rc_costs = $rc_costs"

   ${USHminmon}/minmon_xtrct_gnorms.pl ${MINMON_SUFFIX} ${PDY} ${cyc} ${gsistat} dummy
   rc_gnorms=$?
   echo "rc_gnorms = $rc_gnorms"

   ${USHminmon}/minmon_xtrct_reduct.pl ${MINMON_SUFFIX} ${PDY} ${cyc} ${gsistat} dummy
   rc_reduct=$?
   echo "rc_reduct = $rc_reduct"

fi

#####################################################################
# Postprocessing

err=0
if [[ ${data_available} -ne 1 ]]; then
   err=1
elif [[ $rc_costs -ne 0 ]]; then
   err=$rc_costs
elif [[ $rc_gnorms -ne 0 ]]; then
   err=$rc_gnorms
elif [[ $rc_reduct -ne 0 ]]; then
   err=$rc_reduct
fi

exit ${err}
