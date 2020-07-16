#!/bin/bash

# if your script needs to access resources in the same folder that it is being run from, and you have it specified as relative paths, then your script will break. I always add a cd $(dirname $0) to the head of my script so the folder containing the script will be the root folder.
# Ref: https://askubuntu.com/questions/74780/how-to-execute-script-in-different-directory

cd $(dirname $0)


# echo "Running check 1"

# Ref: https://stackoverflow.com/questions/1521462/looping-through-the-content-of-a-file-in-bash


true > ./success.txt
true > ./failure.txt


while read destination; do
#    echo "Checking $destination"

    # https://stackoverflow.com/questions/4922943/test-if-remote-tcp-port-is-open-from-a-shell-script    
    nc -z $destination 22
    
    # Ref: https://stackoverflow.com/a/37475203  
    result1=$?

    if [  "$result1" != 0 ]; then
#	echo  'port 22 is closed'
	echo $destination  SUCCESS >> ./success.txt
    else
#	echo 'port 22 is open'
	echo $destination  FAILURE >> ./failure.txt
    fi
  
done <./destination-to-check.txt

# check size of failure file and if that is > 0 then mark test as failed.
# Ref: https://stackoverflow.com/questions/5920333/how-to-check-size-of-a-file-using-bash
actualsize=$(wc -c <"failure.txt")
if [ $actualsize -ge 1 ]; then
    printf "FAILED   ";
else
    printf "SUCCESS  ";
fi
