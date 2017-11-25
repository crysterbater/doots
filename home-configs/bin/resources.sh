#!/bin/bash
NAMESPACE="termite"

function resource {
	xrdb -query | tac | sed -r "s/^($NAMESPACE|\*)\.$1\s*:\s*//
	T
	q"
}

function set_color {
	local val
	if [ -n "$2" ]; then
		val=$(resource "$2")
		if [ -n "$val" ]; then
			printf "%b" "\033]$1;$val\007"
		fi
	else
		val=$(resource "color$1")
		if [ -n "$val" ]; then
			printf "%b" "\033]4;$1;$val\007"
		fi
	fi
}

for i in {0..15}; do
	set_color $i
done
set_color 10 foreground
set_color 11 background
set_color 12 cursor
