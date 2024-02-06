#!/bin/bash

output_file="bulk_insert.sql"

echo "INSERT INTO users (id, name) VALUES" > $output_file
for ((i=1; i<=10000000; i++)); do
  echo "  ($i, 'user $i')," >> $output_file
done

# 最後の行のカンマを削除
sed -i '' '$s/,$//' $output_file

echo ";" >> $output_file
