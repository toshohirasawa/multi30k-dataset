#!/bin/bash
export LC_ALL=en_US.UTF_8

if [ ! -d scripts ]; then
  echo "You should run this script from the root git folder."
  exit 1
fi

RAW=./data/task1/raw
POSTEDITED=./data/task1/post-edited

mkdir -p ${POSTEDITED}

cd ${RAW} >/dev/null
gzip -d -k val.de.gz
gzip -d -k test_2016_flickr.de.gz
cd -

./scripts/task1-post-edited.py \
  --pre-edit-file ./data/task1/raw-wmt16/val.de \
  --post-edit-file ./data/task1/raw/val.de \
  >./data/task1/post-edited/val.de

./scripts/task1-post-edited.py \
  --pre-edit-file ./data/task1/raw-wmt16/test.de \
  --post-edit-file ./data/task1/raw/test_2016_flickr.de \
  >./data/task1/post-edited/test_2016_flickr.de

rm ${RAW}/val.de
rm ${RAW}/test_2016_flickr.de
