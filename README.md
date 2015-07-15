#Application exercise

Ubuntu 14.04, Django, Nginx, Postgresql, furry-robot app
(*Github suggested name!*)

Requires Mac + Vagrant + VirtualBox + Ansible

Working directory must be relative to Vagrantfile


Ansible Setup (gather facts)
```
ansible all -m setup
```

Example playbook execution
```
 # perform all provisioning steps
 ansible-playbook playbook.yml

 # perform system upgrade
 ansible-playbook system_upgrade.yml

 # execute nginx + furry-robot role
 ansible-playbook playbook.yml -t "nginx,furry-robot"

```
