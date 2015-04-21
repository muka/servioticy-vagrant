#!/bin/sh

sudo sh ./scripts/prepare_env.sh

sudo ln -s $PWD/puppet/modules/compose-servioticy /etc/puppet/modules/servioticy

sudo puppet apply \
--debug \
--manifest ./puppet/manifests/ \
--environment development \
--graph --graphdir ./puppet/dependency_graph \
puppet/manifests
