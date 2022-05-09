#!/bin/bash

path1=$PWD
mkdir $path1/reports

sudo docker build . -t pyton-pandas 
sudo docker-compose up

sudo docker-compose down
cd reports
xdg-open report1.html 
xdg-open report2.html 
xdg-open report3.html 
xdg-open report4.html 
xdg-open report5.html 
