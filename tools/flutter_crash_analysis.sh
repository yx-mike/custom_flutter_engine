#!/usr/bin/env bash
#./flutter_crash_analysis.sh path/to/Flutter.dSYM path/to/raw_crash arch(arm64|armv7)

dSYM_path="$1/Contents/Resources/DWARF/Flutter"
crash_file_path="$2"
arch="$3"

while read line; do

  num=$(echo $line | awk -F ' ' '{print $1}')
  module=$(echo $line | awk -F ' ' '{print $2}')
  slide_address=$(echo $line | awk -F ' ' '{print $3}')
  load_address=$(echo $line | awk -F ' ' '{print $4}')

  if [ $module == 'Flutter' ]; then
    result=$(atos -o $dSYM_path -arch $arch -l $load_address $slide_address)
    echo $num $result
  fi

done <$crash_file_path
