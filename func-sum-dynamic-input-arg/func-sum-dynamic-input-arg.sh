##!/bin/bash
#
sum() {
	sum_of_args=0
	for num in $@;
	do
		sum_of_args=$(( $sum_of_args + $num ))
	done
	return $sum_of_args
}
