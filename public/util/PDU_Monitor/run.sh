p=$(ps aux|grep "python get_data.py"|wc -l)
[[ $p -ge 2 ]] &&  exit
echo "run now"

#normal
nohup python get_data.py > /dev/null &

#debug
#python get_data.py
