#!/bin/bash

# if your script needs to access resources in the same folder that it is being run from, and you have it specified as relative paths, then your script will break. I always add a cd $(dirname $0) to the head of my script so the folder containing the script will be the root folder.
# Ref: https://askubuntu.com/questions/74780/how-to-execute-script-in-different-directory

cd $(dirname $0)

# echo "Running check 2"

# Ref: https://stackoverflow.com/questions/1521462/looping-through-the-content-of-a-file-in-bash


true > success.txt
true > failure.txt


while read destination; do
#    echo "Checking $destination"

#     echo $(wget $destination);

    # https://superuser.com/questions/272265/getting-curl-to-output-http-status-code    
    outPut=$(curl -s -o /dev/null -w "%{http_code}" "$destination");
    # # outPut=`curl -LI $destination -o /dev/null -w '%{http_code}\n' -s`;
    if [ "$outPut" = "200" ]
    then
        # echo  'url is open';
        echo $destination  SUCCESS >> success.txt;
    else
        # echo 'url is not open';
        echo $destination  FAILURE >> failure.txt;
    fi
  
done <destination-to-check.txt

# check size of failure file and if that is > 0 then mark test as failed.
actualsize=$(wc -c <"failure.txt")
if [ $actualsize -ge 1 ]; then
    printf "FAILED   "
else
    printf "SUCCESS  "
fi
