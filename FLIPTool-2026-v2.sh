#!/bin/env bash

# FLIPTool-2026-v2.sh -  This command provides a clear, sorted list of the largest packages installed on your Fedora/CentOS system. 

# shellcheck disable=SC2034

###############################################################################################################################################################
### Command Breakdown ###																      #
###############################################################################################################################################################
#    rpm -qa: Lists all installed RPM packages.
#    --queryformat '%{SIZE} %{NAME}\n': Formats the output to show the package size in bytes followed by the package name, each on a new line.
#    | sort -nr: 	Pipes the output to the sort command, which sorts the packages numerically (-n) and in reverse order (-r, largest first).
#    | head -n 25: 	Displays only the top 25 results.

#    | awk '{printf "%.2f MB - %s\n", $1/1048576, $2}': Uses awk to convert the size from bytes (the %{SIZE} output) to megabytes 
#    							(by dividing by 1048576, which is 1024*1024) and formats the output to two decimal places. 
###############################################################################################################################################################

# TODO: Enable Cecho.
#	    Enable SplitConfig.
#		Create CASE Statement for Query Options (Temporary).
#		Create CASE Statement to allow for specifying $NumberOfPkgs via --pkgs.
	
###############################################################################################################################################################
## Define Variables ##																	      #
###############################################################################################################################################################

 FLIPTool_Version="08.26-r3"

 RPM_Cmd="rpm"
 RPM_Cmd_Args=" -qa --queryformat"
 RPM_Cmd_QueryFmt=" '%{SIZE} %{NAME}\n' | sort -n -r | head -n 25"

 QueryFmt_Size="%{SIZE}"
 QueryFmt_Name="%{NAME}\n"

 QueryFmt_All="sort -nr | head -n"
 QueryFmt_Sort="sort -nr"
 QueryFmt_Head="head -n"

 NumberOfPkgs="25"


# Awk Definitions #
# FIXME: None of these work, probably due to the need to figure out how to properly specify variables that contain double quotes, commas, etc.

 Printf_Args_All="\"%.2f MB - %s\\n\", \$1/1048576, \$2" # Corrected by Google AI on Aug 4, 2026.

 Printf_Args1="%.2f MB - %s\n" # Corrected by Google AI on Aug 4, 2026.
 Printf_Args2="\$1/1048576, \$2"

# FIXME: This won't work due to the variable having quotes while enclosed within quotes.
# Awk_Args="printf "Printf_Args1 $Printf_Args2"

### This command throws an error.  
#   FIXME: Encapsulate variables correctly.
 Awk_Args='awk '\''{printf "%.2f MB - %s\n", $1/1048576, $2}'\''' # Corrected by Google AI on Aug 4, 2026.


## NOTE ##
# The awk command changes the output from 'bytes' to 'megabytes' akin to using 'ls -hl' vs 'ls -l'

####################################################################################################################################
# DISPLAY FUNCTIONS #                                                                                                                #
####################################################################################################################################

function DisplayBanner() {
	echo "FLIPTool-2026 - Version $FLIPTool_Version."
	echo " Number Of Packages To Display: $NumberOfPkgs"
	echo " Finding Largest Installed Packages... "
	echo " "
}

function DisplayFunctions() {
	echo "FLIPTool-2026-v2 Options: "
	echo "--------------------------------------------------------------"
	echo "  Static_Query_1:	No variables, sizes in BYTES." 
	echo "  Static_Query_1:	No variables, sizes in MB."
	echo "--------------------------------------------------------------"
	echo "  Hybrid_Query_1:	Currently BROKEN. "
	echo "  Hybrid_Query_2:	Works, superceded by Hybrid_Query_3. "
	echo "  Hybrid_Query_3:	Works, current best option. "
	echo "--------------------------------------------------------------"
	echo "  Dynamic_Query_1:	All variables, currently BROKEN. "
	echo "  Dynamic_Query_2:	All variables, currently BROKEN. "
	echo "  Dynamic_Query_3:	All variables, currently BROKEN. "
	echo "  Dynamic_Query_4:	All variables, currently BROKEN. "
	echo "--------------------------------------------------------------"
	echo "  "
}


####################################################################################################################################
# QUERY FUNCTIONS #														   #
####################################################################################################################################

#--------------------------------------------------------------------------------------------------------------------------------------#
# Static Query Functions #
#--------------------------------------------------------------------------------------------------------------------------------------#

function Static_Query_1() {
#  Original Command - WITHOUT Awk #
 	rpm -qa --queryformat '%{SIZE} %{NAME}\n' | sort -nr | head -n 25
}

function Static_Query_2() {
# Original Command - WITH Awk #
	 rpm -qa --queryformat '%{SIZE} %{NAME}\n' | sort -nr | head -n 25 | awk '{printf "%.2f MB - %s\n", $1/1048576, $2}'
}

#--------------------------------------------------------------------------------------------------------------------------------------#
# Hybrid Query Functions #
#--------------------------------------------------------------------------------------------------------------------------------------#

# As of Aug 4, 2026, this function is BROKEN.
function Hybrid_Query_1() {
	# $RPM_Cmd "$RPM_Cmd_Args" '%{SIZE} %{NAME}\n' | $QueryFmt_Sort | $QueryFmt_Head $NumberOfPkgs | awk '{printf "%.2f MB - %s\n", $1/1048576, $2}'
	# $RPM_Cmd "$RPM_Cmd_Args" '%{SIZE} %{NAME}\n' | sort -nr | head -n 25 | awk '{printf "%.2f MB - %s\n", $1/1048576, $2}'
	 $RPM_Cmd "$RPM_Cmd_Args" "$RPM_Cmd_QueryFmt" | $QueryFmt_Sort | $QueryFmt_Head $NumberOfPkgs | awk '{printf "%.2f MB - %s\n", $1/1048576, $2}'
}

# As of Aug 4, 2026, this function works perfectly.  It has been superceded by function Hybrid_Query_2.
function Hybrid_Query_2() {
	$RPM_Cmd "$RPM_Cmd_Args" '%{SIZE} %{NAME}\n' | sort -nr | head -n 25 | awk '{printf "%.2f MB - %s\n", $1/1048576, $2}'
}


# As of Aug 4, 2026, this is the best function, and works perfectly.
function Hybrid_Query_3() {
	### $RPM_Cmd $RPM_Cmd_Args '%{SIZE} %{NAME}\n' | $QueryFmt_Sort | head -n 25 | awk '{printf "%.2f MB - %s\n", $1/1048576, $2}'
	$RPM_Cmd "$RPM_Cmd_Args" '%{SIZE} %{NAME}\n' | $QueryFmt_Sort | $QueryFmt_Head $NumberOfPkgs | awk '{printf "%.2f MB - %s\n", $1/1048576, $2}'
}

#--------------------------------------------------------------------------------------------------------------------------------------#
# Dynamic Query Functions #
#--------------------------------------------------------------------------------------------------------------------------------------#

function Dynamic_Query_1() {
### Final Query To Fix ###
	$RPM_Cmd "$RPM_Cmd_Args" '$QueryFmt_Size $QueryFmt_Name' | $QueryFmt_Sort | $QueryFmt_Head $NumberOfPkgs
}

function Dynamic_Query_2() {
### This one works
	$RPM_Cmd "$RPM_Cmd_Args" '%{SIZE} %{NAME}\n' | $QueryFmt_Sort | $QueryFmt_Head $NumberOfPkgs | awk '{printf "%.2f MB - %s\n", $1/1048576, $2}'
}

function Dynamic_Query_3() {
## Latest Test
	$RPM_Cmd "$RPM_Cmd_Args" '%{SIZE} %{NAME}\n' | $QueryFmt_Sort | $QueryFmt_Head $NumberOfPkgs | awk '{printf "$Printf_Args1 $Printf_Args2"}'
}

function Dynamic_Query_4() {
# This doesn't work
	$RPM_Cmd "$RPM_Cmd_Args" '%{SIZE} %{NAME}\n' | $QueryFmt_Sort | $QueryFmt_Head $NumberOfPkgs | awk '{$Awk_Args}'
}



###############################################################################################################################################################
# Main Program #																	      #
###############################################################################################################################################################

 DisplayBanner
 DisplayFunctions

## Hybrid_Query_3

