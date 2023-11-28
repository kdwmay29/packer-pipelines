#!/bin/sh
 ###Cloud.cfg.Edit###
 sudo sed -ie 's/ssh_pwauth:   false/ssh_pwauth:   True /g' /etc/cloud/cloud.cfg


###USER ADD###
#echo -n "New User Create:"
#read user
#필요한 계정 추가
useradd -m kdw