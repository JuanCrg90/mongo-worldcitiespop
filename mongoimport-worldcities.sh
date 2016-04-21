#! /bin/bash

FILENAME="worldcitiespop.txt"

if [ ! -z "$1" ]; then

  if [ ! -f $FILENAME ]; then  
    echo "Downloading $FILENAME"
    wget http://download.maxmind.com/download/worldcities/worldcitiespop.txt.gz
    gunzip worldcitiespop.txt.gz
  else
    echo "$FILENAME already exist"
  fi

  echo "procesing double quotes"
  sed -r "s/\"/'/g" $FILENAME > output.csv

  echo "loading $FILENAME in $1"
  mongoimport -d $1 -c worldCities --type csv --file output.csv --headerline
else
  echo "you must pass the dabasename as first argument"
  echo "bash mongoimport-worldcities.sh databaseName"
fi
