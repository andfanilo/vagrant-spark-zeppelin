#!/usr/bin/env bash

# APACHE ZEPPELIN
export ZEPPELIN_VERSION=0.7.0
export ZEPPELIN_PACKAGE=$ZEPPELIN_VERSION-bin-all
export ZEPPELIN_HOME=/usr/zeppelin-${ZEPPELIN_VERSION}-bin-all
export ZEPPELIN_CONF_DIR=${ZEPPELIN_HOME}/conf
export ZEPPELIN_NOTEBOOK_DIR=${ZEPPELIN_HOME}/notebook

apt-get install -y git wget net-tools unzip python npm

# # Fixing Debian/Jessie 8.2 has changed "node" to "nodejs"
ln -fs /usr/bin/nodejs /usr/bin/node

wget -c "http://archive.apache.org/dist/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_PACKAGE}.tgz"

tar zxvf zeppelin-${ZEPPELIN_PACKAGE}.tgz -C /usr/
ln -s ${ZEPPELIN_HOME} /usr/zeppelin

cd ${ZEPPELIN_HOME}

cat > ${ZEPPELIN_HOME}/conf/zeppelin-env.sh <<CONF
export ZEPPELIN_MEM="-Xmx1024m"
export ZEPPELIN_JAVA_OPTS="-Dspark.home=/usr/spark"
export ZEPPELIN_NOTEBOOK_DIR="/vagrant/notebook/"
export ZEPPELIN_PORT="8888"
CONF

ln -s ${ZEPPELIN_HOME}/bin/zeppelin-daemon.sh /etc/init.d/
update-rc.d zeppelin-daemon.sh defaults

echo "Starting Zeppelin..."
/etc/init.d/zeppelin-daemon.sh start

sudo echo 'export SPARK_HOME=/usr/spark' >> /usr/zeppelin/conf/zeppelin-env.sh

echo "Restarting Zeppelin..."
/etc/init.d/zeppelin-daemon.sh restart
