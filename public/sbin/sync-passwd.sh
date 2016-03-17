[ ! $ENV_FLAG ] && echo "bad env" && exit 1

echo "sync settings..."
for i in $cnodes; do
  for fn in `cat $PUBLIC_CONFIG/pwlist.conf`; do
    scp -r -q $fn $i:$fn
  done
done
