#!/bin/sh

work_dir=`pwd`
output_dir="$work_dir/output"
temp_dir="$work_dir/temp"
tools_dir="$work_dir/tools"

# create dirs
mkdir -p $output_dir
mkdir -p $temp_dir
mkdir -p $tools_dir

# get intercom
curl -o $temp_dir/intercom-sdk-base-1.1.9.aar 'https://raw.githubusercontent.com/intercom/intercom-android/1.1.9/aar/intercom-sdk-base/intercom-sdk-base-1.1.9.aar'

# get jarjar
if [ ! -f $tools_dir/jarjar-1.4.jar ]; then
  curl -o $tools_dir/jarjar-1.4.jar 'https://jarjar.googlecode.com/files/jarjar-1.4.jar'
fi

# process
unzip $temp_dir/intercom-sdk-base-1.1.9.aar -d $temp_dir/intercom-sdk-base
cp $temp_dir/intercom-sdk-base/classes.jar $temp_dir
cp $temp_dir/intercom-sdk-base/libs/repackaged_dependencies.jar $temp_dir
java -Dverbose=true -jar $tools_dir/jarjar-1.4.jar process rules_classes.txt $temp_dir/intercom-sdk-base/classes.jar $temp_dir/classes.jar
java -Dverbose=true -jar $tools_dir/jarjar-1.4.jar process rules_repackaged_dependencies.txt $temp_dir/intercom-sdk-base/libs/repackaged_dependencies.jar $temp_dir/repackaged_dependencies.jar
java -Dverbose=true -jar $tools_dir/jarjar-1.4.jar process rules_repackaged_dependencies_zap.txt $temp_dir/repackaged_dependencies.jar $temp_dir/repackaged_dependencies_2.jar

mv $temp_dir/classes.jar $temp_dir/intercom-sdk-base/classes.jar
mv $temp_dir/repackaged_dependencies_2.jar $temp_dir/intercom-sdk-base/libs/repackaged_dependencies.jar

cd $temp_dir/intercom-sdk-base
zip -r -X $output_dir/intercom-sdk-base-1.1.9-slim.aar *
cd $work_dir

rm -rf ./temp
