#wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-armv7l.sh

#sudo md5sum Miniconda3-latest-Linux-armv7l.sh

#sudo /bin/bash Miniconda3-latest-Linux-armv7l.sh

#conda create --name sky_eye3 python=3

#source activate sky_eye3

#pip install -U -r requirements.txt

#conda install anaconda-client
#conda install -c menpo opencv


echo -e "########################################################################################"
echo -e "#########                      Installation                                    #########"
echo -e "########################################################################################"

sudo apt-get update
sudo apt-get -y upgrade
sudo rpi-update

sudo apt-get install -y build-essential git cmake pkg-config
sudo apt-get install -y libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev
sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get install -y libxvidcore-dev libx264-dev
sudo apt-get install -y libgtk2.0-dev libgtk-3-dev
sudo apt-get install -y libatlas-base-dev gfortran
sudo apt-get install -y python3-dev

echo -e "########################################################################################"
echo -e "#########                      Download opencv source                          #########"
echo -e "########################################################################################"

cd ~
wget -O opencv.zip https://github.com/Itseez/opencv/archive/3.3.0.zip
unzip opencv.zip
wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.3.0.zip
unzip opencv_contrib.zip
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py


echo -e "########################################################################################"
echo -e "#########                      Set up virtualenv                               #########"
echo -e "########################################################################################"


sudo pip install virtualenv virtualenvwrapper
sudo rm -rf ~/.cache/pip


echo -e "\n# virtualenv and virtualenvwrapper" >> ~/.profile
echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.profile
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.profile
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.profile

source ~/.profile

mkvirtualenv sky_eye3 -p python3
workon sky_eye3
pip install numpy

echo -e "########################################################################################"
echo -e "#########     Successful! Please change the swap size, see:        #####################"
echo -e "https://www.pyimagesearch.com/2017/09/04/raspbian-stretch-install-opencv-3-python-on-your-raspberry-pi"
echo -e "########################################################################################"
