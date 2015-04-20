#!/bin/sh

sh ./scripts/prepare_env.sh

puppet apply --debug \
--modulepath ./puppet/modules/ \
--manifest ./puppet/manifests/ \
--environment dev --graph --graphdir ./puppet/dependency_graph \
puppet/manifests
