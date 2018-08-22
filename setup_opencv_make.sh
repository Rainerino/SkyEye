
echo -e "########################################################################################"
echo -e "#########                      building opencv                                 #########"
echo -e "########################################################################################"

cd ~/opencv-3.3.0/
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.3.0/modules \
    -D BUILD_EXAMPLES=ON ..


make -j4


sudo make install
sudo ldconfig

cd /usr/local/lib/python3.5/site-packages/
ln -s /usr/local/lib/python3.5/site-packages/cv2.so cv2.so

rm -rf ~/opencv-3.3.0 ~/opencv_contrib-3.3.0