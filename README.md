Application exercise

Deploy Ubuntu 14.04, Django, Nginx, Postgresql, helloworld app

Requires Mac + Vagrant + VirtualBox + Ansible
Working directory must be relative to Vagrantfile


Ansible Setup (gather facts)
```
ansible all -m setup
```

Playbook execution
```
 ansible-playbook playbook.yml
 ansible-playbook system_upgrade.yml
```
