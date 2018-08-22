#wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-armv7l.sh

#sudo md5sum Miniconda3-latest-Linux-armv7l.sh

#sudo /bin/bash Miniconda3-latest-Linux-armv7l.sh

#conda create --name sky_eye3 python=3

#source activate sky_eye3

#pip install -U -r requirements.txt

#conda install anaconda-client
#conda install -c menpo opencv


echo -e "##############################"
echo -e "#########Installation#########"
echo -e "##############################"

sudo apt-get update
sudo apt-get -y upgrade
sudo rpi-update

sudo apt-get install -y build-essential git cmake pkg-config
sudo apt-get install -y libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev
sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get install -y libxvidcore-dev libx264-dev
sudo apt-get install -y libgtk2.0-dev
sudo apt-get install -y libatlas-base-dev gfortran
cd ~
git clone https://github.com/Itseez/opencv.git
cd opencv
git checkout 3.1.0
cd ~
git clone https://github.com/Itseez/opencv_contrib.git
cd opencv_contrib
git checkout 3.1.0

sudo apt-get install -y python3-dev
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
pip install numpy
cd ~/opencv
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=OFF \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
    -D ENABLE_PRECOMPILED_HEADERS=OFF \
    -D BUILD_EXAMPLES=ON ..
make -j4
sudo make install
sudo ldconfig

