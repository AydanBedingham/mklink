#!/bin/bash

#############################################################################################
# sickrage-mslink.sh v1.0.0
#############################################################################################
# A wrapper for the mslink script that helps it play nicely with Sickrage Post-processing
#
# - Generates Output LNK Path in drop-zone-0 based on file name of Input Target Path
# - Replaces occurances of local directory paths in Input Target Path with corresponding network file paths
# - Replaces occurances of '/' in the Input Target Path with '\' to make the path Windows-compliant
# - Supplies ammended input file path and LNK file path to mslink.sh
#############################################################################################

#!/bin/bash

echo "">/config/linker/output.txt
echo "$0">>/config/linker/output.txt
echo "$1">>/config/linker/output.txt

INPUT_TARGET_PATH=$1

if [ -z "$INPUT_TARGET_PATH" ]; then
        echo "Missing Input Target Path" 1>&2;
        exit 1
fi

OUTPUT_LNK_PATH="/drop-zone-0/$(basename "$INPUT_TARGET_PATH").lnk"

INPUT_TARGET_PATH=`echo "$INPUT_TARGET_PATH" | sed -r 's#(^\/tv\/)+#\\\\\\\AYDANS-SERVER\\\TV Shows\\\#g'`
INPUT_TARGET_PATH=`echo "$INPUT_TARGET_PATH" | sed -r 's#(^\/anime\/)+#\\\\\\\AYDANS-SERVER\\\Anime\\\#g'`
INPUT_TARGET_PATH=`echo "$INPUT_TARGET_PATH" | sed -r 's#(\/)+#\\\#g'`

echo " ">>/config/linker/output.txt
echo "$INPUT_TARGET_PATH">>/config/linker/output.txt
echo "$OUTPUT_LNK_PATH">>/config/linker/output.txt

echo " ">>/config/linker/output.txt

$(/config/linker/mklink.sh -l "$INPUT_TARGET_PATH" -o "$OUTPUT_LNK_PATH" &>>/config/linker/output.txt)