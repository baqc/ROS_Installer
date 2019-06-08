#!/bin/bash
#------------------------------------------------------------------------------------------#
#---This script will install ROS distribution that is suitable for your operating system---#
# ----------------------------------author:guidons-----------------------------------------#
# ----------------------------------data:2019.5.26-----------------------------------------#
#------------------------------------------------------------------------------------------#
echo "Setting sources.list"
sudo sh -c '. /etc/lsb-release && echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu/ $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list' && \
echo "deb http://archive.ubuntu.com/ubuntu/ trusty main universe restricted multiverse" > /etc/apt/sources.list  || (echo "Please check your sources.list";exit 0) 
echo "Setting key"
echo "First attempt......"
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
if [ $? != 0 ]
then
 echo "First attempt......"
 apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
 if [ $? != 0 ]
 then
  echo "Third attempt......"
  apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
  if [ $? != 0 ]
  then
   echo "Fail to set key"
   exit 0
  fi
 fi
fi
echo "Installing......"
apt-get update && apt-get install python-rosinstall python-rosinstall-generator python-wstool build-essential || (echo "Rosinstall installation failed";exit 0)
apt-get install ros-melodic-desktop-full || \
apt-get install ros-kinetic-desktop-full || \
apt-get install ros-jade-desktop-full || \
apt-get install ros-indigo-desktop-full || \
apt-get install ros-lunar-desktop-full || (echo "No ROS distribution for your operating system was found";exit 0)
echo "Initializing rosdep"
rosdep init && rosdep update || (echo "Initialization of rosdep failed";exit 0)
echo "Adding ROS environment variables" 
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc && source ~/.bashrc || (echo "Failure to add environment variables";exit 0)
echo "Successful installation"
