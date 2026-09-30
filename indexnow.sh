#!/bin/bash
# Kullanim: ./indexnow.sh            -> sitemap'teki tum URL'leri bildirir
#           ./indexnow.sh url1 url2  -> sadece verilen URL'leri bildirir
cd "$(dirname "$0")"; K=$(cat .indexnow-key)
if [ $# -eq 0 ]; then set -- $(grep -o '<loc>[^<]*' sitemap.xml | sed 's/<loc>//'); fi
LIST=$(printf '"%s",' "$@"); LIST="[${LIST%,}]"
curl -s -o /dev/null -w "IndexNow HTTP %{http_code}\n" -X POST https://api.indexnow.org/indexnow \
  -H 'Content-Type: application/json; charset=utf-8' \
  -d "{\"host\":\"avkorkmaz.com\",\"key\":\"$K\",\"keyLocation\":\"https://avkorkmaz.com/$K.txt\",\"urlList\":$LIST}"
