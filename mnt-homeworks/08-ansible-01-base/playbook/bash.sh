#!/bin/bash

docker run --name fedora -itd pycontribs/fedora
sleep 5
docker run --name centos7 -itd centos:7
sleep 5
docker run --name ubuntu -itd ubuntu
sleep 5

cd /home/ilshat/homework_ansible/playbook/ && ansible-playbook site.yml -i inventory/prod.yml --vault-password-file=.ansible_vault_pass

docker stop fedora centos7 ubuntu

