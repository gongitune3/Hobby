#!/bin/bash
# DIR="/home/ec2-user/Hobby"
# DIR_CURRENT=${DIR}/current
# if [[ -d "$DIR_CURRENT" ]]; then
#    cd $DIR_CURRENT
#    echo $DIR_CURRENT
# else
#    cd $DIR
#    echo $DIR
# fi

# T_DAY=`date +%Y%m%d --date '7 day ago'`
# zip -r ./log/production/${T_DAY}.zip ./log/production/${T_DAY}
# rm -r ./log/production/${T_DAY}

# T2_DAY=`date +%Y%m%d --date '14 day ago'`
# rm -r ./log/production/${T2_DAY}.zip

# 権限がない為、current下に配置した場合、権限を変更しなければ実行できない状態。カピストラーノに権限の変更を毎回行う記述ができなかった為、
# 一旦上の階層(Hobby)にあげて回避。編集する時は直接Hobby/bash.shを触る事！！！