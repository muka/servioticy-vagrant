#!/bin/sh

sh ./scripts/prepare_env.sh

puppet apply --debug \
--manifest ./puppet/manifests/ \
--environment development \
--graph --graphdir ./puppet/dependency_graph \
puppet/manifests
