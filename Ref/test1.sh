#!/bin/bash

function hello() {
	echo "Batch function testing"
	now
}
function now() {
	echo "It's $(date +%r)"
}
hello
