#!/bin/sh

# 
# It sends a summary e-mail to the following admin (Admissions) process-specific listserv e-mail address: 
# ADMS-TRANS-DNL-ADMIN-L@listserv.indstate.edu
#
# Otherwise, all technical-specific e-mails get sent to the following e-mail address:
# ADMS-TRANS-DNL-TECH-L@listserv.indstate.edu
#
# This runs using the following CRONTAB:
# 30 8 * * * /home/ccavow/nightly/admissions/xml_download/xml_downloader.shl > /dev/null 2>&1
# run at 8:30 
# Set source and destination paths

#STEP 0

rm downloads/*
rm archive/*
rm file_output/*

#STEP 1
#Transfer parchment files from ccavow to DEVL under /student/xml_transcript/

SOURCE_DIR="/u02/banner/datahome/DEVL/student/"
DESTINATION_USER="ccavow"
DESTINATION_SERVER="b-prod-uapp-1"
DESTINATION_DIR="/home/ccavow/nightly/admissions/xml_college/archive"
DEVL_CCAVOW_DIR="~ccavow/nightly/admissions/"


#Calculate the date for files received for todays date (adjust as needed)
TODAY=$(date +"%m_%d_%Y")
echo "$TODAY"
# Run sftp to transfer data

# SFTP command to transfer files
#For now, only grab from current month (Sept)
#downloads_from_09_01_2023_
#cd /u02/banner/datahome/DEVL/student/xmltranscript/ || exit 1
#sudo -iu ccavow
echo "$PWD"
cd "$DEVL_CCAVOW_DIR" || exit 1
echo "Transferring Files from CCAVOW"
sftp -p "$DESTINATION_USER@$DESTINATION_SERVER" -oConnectTimeout=10mget << EOF  
cd "$DESTINATION_DIR" || exit 1
mget *$TODAY*.zip

exit 
EOF
for i in $DEVL_CCAVOW_DIR; do 
echo "$i"; 
done

printf "\n\n============================="
echo "Files Transferred on $(date +%m/%d/%Y)"
printf "\n\n============================="
#STEP 1.2 
#Extract zip files in source dir
for zip_file in *.zip; do
    echo "$zip_file";
    if [ -f "$zip_file" ]; then
        unzip -q "$zip_file"; #-d "$DEVL_CCAVOW_DIR";
    # Optionally, remove the zip file after extraction
        rm "$zip_file";
    echo "$zip_file";
    fi
done
cd ~ccavow/nightly/admissions/downloads || exit 1


#Run Python Script to convert all xml files to appropiate format for processing


python3 ../xml_conversion.py

# cp ../file_output/*.xml "$SOURCE_DIR"

# for file in *.xml; do
#     echo "$file";
#     if [ -f "$file" ]; then
#     # Optionally, remove the zip file after extraction
#         rm "$file";
#     echo "$file";
#     fi
# done

echo "Transforming parchment files"
 
#python ../b.py

#STEP3
#REMOVE ORIGINALS FROM /XMLTRANSCRIPT 

#STEP4
