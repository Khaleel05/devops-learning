# NAVIGATION
cd- is used to change the directory. Moving forward up to the root or down the tree.
-- cd (~): will take you back to the root directory. 

cd /var/log : this will take you to the central folder and unix-like operating systems store systems, service and application log files. 

-- it holds activities, warnings and errors. 
-- Trouble shooting Hub: when a service crashes pr a hardware error occurs, administrators chech these files to find out why. 

# key roles in the Devops industry.
## 1.ROOT CAUSE ANALYSIS (DEBUGGING PRODUCTION)
-- when liv eapplications crashes, throws a 500 internal server error, or behaves unexpectedly, developers cannot pause the code. They check /var/log  (or specific application subdirectories within it like /var/log /nginx/ or /var/log/apache (like Systemd logs or syslog) to view tracees, database connection failures, unhandled exceptions. 

## 2.INFRASTRUCTURE & DEPLOYMENT VERIFICATION.
-- during CI/CD (Continuius integration/continuous development) pipelines, code is automatically deployed to staging or production server! if a deployment fails or aservice refuses to start,developers check system logs(liken Stemd logs or syslog) within this directory to see if dependenceis, environment variables, or permissions were misconfigured. 

## 3.PERFORMANCE & BOTTELNECK MONITORING. 
-- many logs track request and response times. for example web server access logs track how long a specific API endpoint takes to respond. Developers analyze these logs to identify slow databases queries, memory leaks, or end points that require optimization.  

## 4.SECURITY AUDITING & COMPLIANCE.
-- dEVsECoPS TEAM RELY HEAVILY ON FILES LIKR AUTH.LOG  OR SECURE TO TRACK WHO ACCESSED A SERVER WHEN THEY ACCED OT ADN WHAT COMMAND THEY RAN.This is vital for detecting brute-force attacks, unauthorized access and maintaining industry compliance standards (like PCI-DCC or HIPAA).   

## File operations
touch test.txt
mkdir -p projects/demo
cp test.txt projects/demo/
mv projects/demo/test.txt projects/demo/backup.txt
rm projects/demo/backup.txt

This set of operations, changes the name of the test.txt file to backup.txt.

## Viewing files
cat /etc/passwd - outputs the contents of passwd in the terminal 
less /var/log/syslog - allows you to read the syslog with opening itin editor
head -n 20 /etc/services - outpus the first 20 lines of the service document
tail -f /var/log/auth.log - it displays the last 10 line s of auth.log and because of the -f option it monitores the file in real time so it updates as the file is added to.  
