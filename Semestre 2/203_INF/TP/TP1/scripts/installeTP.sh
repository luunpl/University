#!/bin/bash
cd $HOME/INF203
cp -r /Public/203_INF_Public/TP$1 .
cd TP$1
echo le repertoire courant est
pwd
echo il contient
ls -l
