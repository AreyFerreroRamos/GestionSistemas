#!/bin/bash

# Autor: Arey Ferrero Ramos.
# Data: 26 d'abril del 2022. Versió: 1.
# Descripció:

if [ $(id -u) -eq 0 ]
then

else
	echo -e "Error: No estàs executant com a root." >&2
	exit 1
fi
