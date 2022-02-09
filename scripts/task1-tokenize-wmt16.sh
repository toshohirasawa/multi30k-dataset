#!/bin/bash
export LC_ALL=en_US.UTF_8

if [ ! -d scripts ]; then
  echo "You should run this script from the root git folder."
  exit 1
fi

# Set path to Moses clone
MOSES="scripts/moses-3a0631a/tokenizer"
export PATH="${MOSES}:$PATH"

# Raw files path
RAW=./data/task1/raw-wmt16
TOK=./data/task1/tok-wmt16
SUFFIX="lc.norm.tok"

mkdir -p $TOK &> /dev/null

##############################
# Preprocess files in parallel
##############################
for TYPE in "train" "val" "test"; do
  for LLANG in "en" "de"; do
    INP="${RAW}/${TYPE}.${LLANG}"
    OUT="${TOK}/${TYPE}.${SUFFIX}.${LLANG}"
    if [ -f $INP ] && [ ! -f $OUT ]; then
      cat $INP | lowercase.perl | normalize-punctuation.perl -l $LLANG | \
          tokenizer.perl -l $LLANG -threads 2 > $OUT &
    fi
  done
done
wait
