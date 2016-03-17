[ ! $ENV_FLAG ]  && echo "Bad env!" && exit 1
echo "sync settings..."
for i in $cnodes; do
  for fn in `cat $config/synclist.conf`; do
    scp -r -q $fn $i:$fn
  done
done
