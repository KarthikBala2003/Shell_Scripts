#!/bin/bash

for i in {1..10}
do
  echo $i
done

for word in This is a sample loop statement; do echo $word; done

for i in {0..32..4}
do
  echo "Loop spin:" $i
done

for file in *.sh
do
  ls -lh "$file"
done