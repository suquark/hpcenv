# This script aims at created Network-Filesystem (NFS) based on RDMA within the cluster. 
# Dependency : mellaonx_Infiniband $PUBLIC $cnodes
# assume : io_node=login_node=node1

[ ! $ENV_FLAG ]  && echo "Bad env!" && exit 1

hostip=10.0.0.1
nfsdir=$PUBLIC

# Check if it is the IO node
if [ "`hostname`" != "node1" ]; then
  echo "You must run it on the IO node (node1)!"
  exit 1
fi

# Load "svcrdma" kernel module for server
if ! lsmod | grep -q ^svcrdma; then
  modprobe svcrdma
  # it will success only if the kernel module is loaded
  echo rdma 20049 > /proc/fs/nfsd/portlist
  echo "Restarting NFS service after loading kernel module..."
fi

# the exported mount 
if ! showmount -e | grep -q $nfsdir; then
  echo "The NFS directory isn't exported. Exporting it..."
  # Add the export rule
  echo "$nfsdir *(rw,async,insecure,no_root_squash)" >> /etc/exports
  echo "Restarting NFS service after exporting..."
  service nfs restart
fi


for i in $cnodes; do
  echo "==> configuring $i ..."  
  
  # check whether /public is mounted over rdma
  if ssh $i mount|grep public|grep -q proto=rdma; then
    echo "$i has been working! Ignored."
    continue 
  fi

  # Load "xprtrdma" kernel module for client
  if ! ssh $i lsmod | grep -q ^xprtrdma; then
    ssh $i modprobe xprtrdma
  fi
  
  # Create $nfsdir for mount
  ssh $i mkdir $nfsdir
  echo "mounting the nfs directory..."
  ssh $i mount -o rdma,port=20049 $hostip:$nfsdir $nfsdir

done

