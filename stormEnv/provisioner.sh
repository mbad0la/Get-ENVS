#!/usr/bin/env bash

apt-get update
apt-get install -y apache2
apt-get install -y openjdk-7-jdk
echo "Starting Zookeeper Setup ..."
wget -q http://a.mbbsindia.com/zookeeper/stable/zookeeper-3.4.8.tar.gz
tar -xvf zookeeper-3.4.8.tar.gz
rm zookeeper-3.4.8.tar.gz
mv zookeeper-3.4.8 zookeeper
mkdir /home/vagrant/zookeeper/data
ZOO_CONFIG="/home/vagrant/zookeeper/conf/zoo.cfg"
cat <<EOM >$ZOO_CONFIG
tickTime=2000
dataDir=/home/vagrant/zookeeper/data
clientPort=2181
EOM
echo "Zookeeper Done"
echo "Starting Storm Setup ..."
wget -q http://mirror.fibergrid.in/apache/storm/apache-storm-1.0.0/apache-storm-1.0.0.tar.gz
tar -xvf apache-storm-1.0.0.tar.gz
rm apache-storm-1.0.0.tar.gz
mv apache-storm-1.0.0 storm
mkdir /home/vagrant/storm/data
rm /home/vagrant/storm/conf/storm.yaml
STORM_CONFIG="/home/vagrant/storm/conf/storm.yaml"
cat <<EOM >$STORM_CONFIG
storm.zookeeper.servers:
  - "127.0.0.1"
storm.local.dir: "/home/vagrant/storm/data"
nimbus.seeds: ["127.0.0.1"]
supervisor.slots.ports:
    - 6700
    - 6701
    - 6702
    - 6703
EOM
echo "Environment Done"
