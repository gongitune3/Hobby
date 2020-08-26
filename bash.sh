#!/bin/bash
DIR="/home/ec2-user/Hobby"
DIR_CURRENT=${DIR}/current
if [[ -d "$DIR_CURRENT" ]]; then
   cd $DIR_CURRENT
   echo $DIR_CURRENT
else
   cd $DIR
   echo $DIR
fi

T_DAY=`date +%Y%m%d --date '7 day ago'`
zip -r ./log/production/${T_DAY}.zip ./log/production/${T_DAY}
rm -r ./log/production/${T_DAY}