#!/bin/sh

home=/root #`pwd`

cd $home
$home/current_tomcat/bin/shutdown.sh
killall soffice.bin