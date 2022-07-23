#!/bin/bash

bold() {
	tput bold
	echo "$1"
	tput sgr0
}
