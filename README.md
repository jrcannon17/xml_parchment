# xml_parcmehnt
Pull xml files from parchment server and transform them to desirable ERP standards for Banner 9. The xml files in question are transcripts. We mainly focus on college but we may be adding additional logic for High School (currently High School batch processing is obsolete). Please note, this only applies to Banner 9 and to our specific standards. 

---ALSO NOTE THIS IS A VERY BRIEF EXPLANATION

PHASE 1

First, we need to get the files. Simply run ./xml_downloader.shl or place in Cron tab. In our case, this will run everyday at 8 am. For each succession, an email will be sent; one to notify me when the process was ran and another email to see if we received any new files or not. 

PHASE 2

When phase 1 is completed and running, you will start to see files. A lot of them (depending on the circumstances). This gets messy quick and so I have a Python script that will now parse ONLY the XML files. These are what is needed, the rest we leave for now. 

PHASE 3

Now we have to combine phase 1 and 2 somehow and ultimately store the files where they can be processed. Given this is my own repo, I'm going to need a bash file just for that purpose.

PHASE 4

We set the new script to run 30 minutes AFTER the original xml_downloader. Although the process is relatively fast, I don't want to take any chances should every student in the country decide to transfer to our university.



