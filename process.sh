#!/bin/sh

# get intercom
curl -o ./intercom-sdk-base-1.1.6.aar 'https://raw.githubusercontent.com/intercom/intercom-android/1.1.6/aar/intercom-sdk-base-1.1.6.aar'

# get jarjar
curl -o ./jarjar-1.4.jar 'https://jarjar.googlecode.com/files/jarjar-1.4.jar'

# cleanup
rm -f ./intercom-sdk-base-1.1.6-processed.aar
rm -rf ./intercom-sdk-base
rm -rf ./temp

# process
unzip ./intercom-sdk-base-1.1.6.aar -d ./intercom-sdk-base
mkdir ./temp
cp ./intercom-sdk-base/classes.jar ./temp/
cp ./intercom-sdk-base/libs/repackaged_dependencies.jar ./temp/
java -jar ./jarjar-1.4.jar process rules_classes.txt ./intercom-sdk-base/classes.jar ./temp/classes.jar
java -jar ./jarjar-1.4.jar process rules_repackaged_dependencies.txt ./intercom-sdk-base/libs/repackaged_dependencies.jar ./temp/repackaged_dependencies.jar
java -jar ./jarjar-1.4.jar process rules_repackaged_dependencies_zap.txt ./temp/repackaged_dependencies.jar ./temp/repackaged_dependencies_2.jar

mv ./temp/classes.jar ./intercom-sdk-base/classes.jar
mv ./temp/repackaged_dependencies_2.jar ./intercom-sdk-base/libs/repackaged_dependencies.jar

cd ./intercom-sdk-base
zip -r -X ../intercom-sdk-base-1.1.6-processed.aar *
cd ..
