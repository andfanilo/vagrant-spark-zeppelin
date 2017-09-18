#!/usr/bin/env bash

echo "Cleaning up ..."
apt-get clean
rm -rf /var/lib/apt/lists/*

rm /home/vagrant/spark-2.1.0-bin-hadoop2.7.tgz
rm /home/vagrant/zeppelin-0.7.0-bin-all.tgz