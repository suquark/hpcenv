! source /public/config/env-load.sh && exit 1

echo "Trying to download. If it fail to start, try wlt.sh "

cd $download
wget http://registrationcenter-download.intel.com/akdlm/irc_nas/8365/parallel_studio_xe_2016_update1.tgz

