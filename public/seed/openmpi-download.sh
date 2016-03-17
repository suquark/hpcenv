! source /public/config/env-load.sh && exit 1

echo "Trying to download. If it fail to start, try wlt.sh "

cd $download
ver=openmpi-1.10.2
fver=$ver.tar.gz
wget https://www.open-mpi.org/software/ompi/v1.10/downloads/$fver
tar -xf $fver
cd $ver
./configure --prefix=/public/opt/$ver CC=icc CXX=icpc F77=ifort FC=ifort
make -j 16 install

