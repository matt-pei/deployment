#! /bin/bash

ES_IP="10.9.4.86"
ES_API="http://${ES_IP}:9200"
ES_STATUS="curl -I -sL -m 5 ${ES_API} | grep '200' | cut -d ' ' -f 2"
es="systemctl status elasticsearch | grep -i 'active' | cut -d '(' -f 1"

function EsStatus {
    if [[ ES_STATUS == "200" ]]; then
        echo "ES Status: Elasticsearch is running..."
    else
        echo ""
}



