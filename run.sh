#!/bin/bash

domain="testdomain"
classes="testclass1 testclass2"

sleep 5 #wait for node to start

sudo -u mogile mogilefsd --daemon -c /etc/mogilefs/mogilefsd.conf

mogadm --trackers=127.0.0.1:7001 host add mogilestorage --ip=mogile-node --port=7500 --status=alive
mogadm --trackers=127.0.0.1:7001 device add mogilestorage 1
mogadm --trackers=127.0.0.1:7001 device add mogilestorage 2

if [ "$domain" != "" ]
then
  mogadm --trackers=127.0.0.1:7001 domain add $domain
  mogadm class modify sbf default --replpolicy='MultipleDevices()'

  # Add all given classes
  if [ "$classes" != "" ]
  then
    for class in $classes
    do
      mogadm --trackers=127.0.0.1:7001 class add $domain $class --replpolicy="MultipleDevices()"
    done
  fi
fi

mogadm check

git clone https://github.com/mogilefs-moji/moji.git
cd moji
echo "Inital complete. Now you can run 'mvn integration' to ensure everything is right."
bash
