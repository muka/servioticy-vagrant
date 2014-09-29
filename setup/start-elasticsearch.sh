
source /vagrant/config.sh

cd $wd;

wget -qO - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -

echo "deb http://packages.elasticsearch.org/elasticsearch/1.3/debian stable main" | sudo tee /etc/apt/sources.list.d/elasticsearch.list

sudo apt-get update 2>&1 > $logdir/elasticsearch.log
sudo apt-get install elasticsearch 2>&1 >> $logdir/elasticsearch.log

sudo service elasticsearch start

#cd $wd;

#if [ ! -d "$ES" ]; then

#    echo "Installing Elastic Search"
#    echo "--------------------------------------------------------"
    
#        if [ ! -f "$wd/$ES_filename" ]; then
#            wget --quiet $ES_url
#        fi;
        
#        esdir="${ES_filename%.*.*}"
#        tar xf $ES_filename -C $wd
#        mv $esdir $ES
#fi;

#echo "Starting Elastic Search"
#echo "--------------------------------------------------------"

#cd $ES

#./bin/elasticsearch 2>&1 > $logdir/elasticsearch.log &
#sleep 20

