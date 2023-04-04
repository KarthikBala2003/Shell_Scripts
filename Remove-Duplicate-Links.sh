#!/bin/bash
# Path with line spearater
awk -v RS=: '{print}' <<<$PATH

# Removed duplicates
path_string=$(echo -n $PATH | awk -v RS=: '!($0 in a) {a[$0]; printf("%s%s", length(a) > 1 ? ":" : "", $0)}')
awk -v RS=: '{print}' <<<$path_string
# echo -n $PATH | awk -v RS=: '!($0 in a) {a[$0]; printf("%s%s", length(a) > 1 ? ":" : "", $0)}'