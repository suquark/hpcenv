#
# This script is an environment loader.
# It should be sourced first after user-login.
#

# If a dir does not exists, create it.
chkdir() {
    local i
    for i in $@; do
        [ ! -d $i ] && mkdir $i
    done
}

pathadd() {
    export PATH=$PATH:$1
}

libadd() {
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$1
}


# Directories
export PUBLIC=/public
export PUBLIC_CONFIG=$PUBLIC/config
export PUBLIC_HOME=$PUBLIC/home
export PUBLIC_OPT=$PUBLIC/opt  # Optional Install
export DOWNLOAD=$PUBLIC_OPT/download

# hostfile/Nodes
export hostfile=$PUBLIC/hostfile
export nodes=`cat $hostfile`
export me=`hostname`
export others=`grep -v $me $hostfile`
export cnodes=`grep -v node1\$ $hostfile`

# CUDA Env.
export CUDA_PATH=/usr/local/cuda
libadd $CUDA_PATH/lib64
pathadd $CUDA_PATH/bin

# OpenMPI Env.
pathadd $PUBLIC_OPT/openmpi-1.10.2/lib

# Global Env.

pathadd $PUBLIC/bin:$PUBLIC/sbin
pathadd $PUBLIC_CONFIG
if [ $1 ]; then
    if [ $1 == check ];then
        echo -n "Checking Environment... "
        chkdir $PUBLIC_HOME $PUBLIC_CONFIG $PUBLIC_OPT $DOWNLOAD $PUBLIC/bin $PUBLIC/sbin
        echo "DONE."
    fi
fi

export ENV_FLAG=isc2016  # set a flag

