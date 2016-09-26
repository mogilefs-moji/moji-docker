#!/bin/bash

trackers="127.0.0.1:7001"
domain="testdomain"
classes="testclass1 testclass2"

sleep 5 #wait for node to start

sudo -u mogile mogilefsd --daemon -c /etc/mogilefs/mogilefsd.conf

mogadm --trackers=$trackers host add mogilestorage --ip=mogile-node --port=7500 --status=alive
mogadm --trackers=$trackers device add mogilestorage 1
mogadm --trackers=$trackers device add mogilestorage 2

if [ "$domain" != "" ]
then
  mogadm --trackers=$trackers domain add $domain
  mogadm class modify sbf default --replpolicy='MultipleDevices()'

  # Add all given classes
  if [ "$classes" != "" ]
  then
    for class in $classes
    do
      mogadm --trackers=$trackers class add $domain $class --replpolicy="MultipleDevices()" --mindevcount=1
    done
  fi
fi

mogadm --trackers=$trackers check

git clone https://github.com/mogilefs-moji/moji.git
cd moji
echo "Inital complete. Now you can run 'mvn integration-test' to ensure everything is right."
bash
