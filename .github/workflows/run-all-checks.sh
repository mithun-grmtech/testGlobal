#!/bin/bash
computerName=`hostname`;
UserName=`whoami`;
postMessage="# Run from *$UserName@$computerName *\n=======================================\n";
echo "Category 1: Not open on any IP"
postMessage="$postMessage ## Category 1: *Not open on any IP* \n\`\`\`";
for file in $(find . -path "*any-ip*" -mindepth 2 -type f -name "*.sh" -print)
do
    outPut=`sh ./$file`;
    # echo "$file";
    # echo "Status: $outPut";
    # postMessage="$postMessage Name: $file, Status: $outPut \n";
    postMessage="$postMessage $outPut: $file \n";
done



echo "Category 2: Only open on trusted IP";
postMessage="$postMessage\`\`\` ## Category 2: *Only open on trusted IP* \n\`\`\`";
for file in $(find . -path "*trusted*" -mindepth 2 -type f -name "*.sh" -print)
do
    outPut=`sh ./$file`;
    # echo "$file";
    # echo "Status: $outPut";
    # postMessage="$postMessage Name: $file, Status: $outPut \n";
    postMessage="$postMessage $outPut: $file \n";
done

postMessage="$postMessage \`\`\`";
# echo "$postMessage";

echo "\n Post Message in Sc-chat \n";
aliasName="SECURITY";
chanelname="04-sc-dept-tech-dev"; # speed-team 04-sc-dept-tech-dev
message="Result output:  *success* 2";

body()
{
cat <<EOF
{
    "alias": "$aliasName", 
    "channel": "$chanelname", 
    "text": "$postMessage"
} 
EOF
}

# curlRequest=`curl -v -k -H 'Content-Type: application/json' -d '{"alias":"SECURITY", "channel":"speed-team", "text":"Result output:  *success*"}' http://72.52.93.10:3000/hooks/D8jbQDfFCdHXP2gbE/pQt3iYPoDbARqK3bCsciWRxqErG7tJv9afYZC3r8ZgMTsh9h`;

curlRequest=`curl -v -k -H 'Content-Type: application/json' -d "$(body)" http://72.52.93.10:3000/hooks/D8jbQDfFCdHXP2gbE/pQt3iYPoDbARqK3bCsciWRxqErG7tJv9afYZC3r8ZgMTsh9h`;
echo "$curlRequest";