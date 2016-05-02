#!/bin/sh

version="1.1.17"
work_dir=`pwd`
output_dir="$work_dir/output"
temp_dir="$work_dir/temp"
tools_dir="$work_dir/tools"

# create dirs
mkdir -p $output_dir
mkdir -p $temp_dir
mkdir -p $tools_dir

# get intercom
curl -o $temp_dir/intercom-sdk-base-$version.aar "https://raw.githubusercontent.com/intercom/intercom-android/$version/aar/intercom-sdk-base/intercom-sdk-base-$version.aar"
curl -o $temp_dir/intercom-sdk-gcm-$version.aar "https://raw.githubusercontent.com/intercom/intercom-android/$version/aar/intercom-sdk-gcm/intercom-sdk-gcm-$version.aar"

# get jarjar
if [ ! -f $tools_dir/jarjar-1.4.jar ]; then
  curl -o $tools_dir/jarjar-1.4.jar 'https://jarjar.googlecode.com/files/jarjar-1.4.jar'
fi

# process base
cd $work_dir
unzip $temp_dir/intercom-sdk-base-$version.aar -d $temp_dir/intercom-sdk-base
cp $temp_dir/intercom-sdk-base/classes.jar $temp_dir
cp $temp_dir/intercom-sdk-base/libs/repackaged_dependencies.jar $temp_dir
java -Dverbose=true -jar $tools_dir/jarjar-1.4.jar process rules_classes.txt $temp_dir/intercom-sdk-base/classes.jar $temp_dir/classes.jar
java -Dverbose=true -jar $tools_dir/jarjar-1.4.jar process rules_repackaged_dependencies.txt $temp_dir/intercom-sdk-base/libs/repackaged_dependencies.jar $temp_dir/repackaged_dependencies.jar
java -Dverbose=true -jar $tools_dir/jarjar-1.4.jar process rules_repackaged_dependencies_zap.txt $temp_dir/repackaged_dependencies.jar $temp_dir/repackaged_dependencies_2.jar

mv $temp_dir/classes.jar $temp_dir/intercom-sdk-base/classes.jar
mv $temp_dir/repackaged_dependencies_2.jar $temp_dir/intercom-sdk-base/libs/repackaged_dependencies.jar

cd $temp_dir/intercom-sdk-base
zip -r -X $output_dir/intercom-sdk-base-$version-slim.aar *

# process gcm
cd $work_dir
unzip $temp_dir/intercom-sdk-gcm-$version.aar -d $temp_dir/intercom-sdk-gcm
cp $temp_dir/intercom-sdk-gcm/classes.jar $temp_dir
java -Dverbose=true -jar $tools_dir/jarjar-1.4.jar process rules_classes.txt $temp_dir/intercom-sdk-gcm/classes.jar $temp_dir/classes.jar

mv $temp_dir/classes.jar $temp_dir/intercom-sdk-gcm/classes.jar

cd $temp_dir/intercom-sdk-gcm
zip -r -X $output_dir/intercom-sdk-gcm-$version-slim.aar *

# clean up
cd $work_dir

rm -rf $temp_dir
