# Overview

Playbooks are expressed in YAML format, defines which Ansible will run for specific hosts.

# Sample playbook

**sample-playbook.yml** that will install apache on remote server

```
---
- name: install apache
    hosts: all
    become: true
    vars:
        doc_root: /var/www/example
    tasks:
        - name: Update apt
          apt: update_cache=yes
        - name: Install Apache
          apt: name=apache2 state=latest
        - name: Create custom document root
          file: path={{ doc_root }} state=directory owner=www-data group=www-data
        - name: Set up HTML file
          copy: src=index.html dest={{ doc_root }}/index.html owner=www-data group=www-data mode=0644
        - name: Set up Apache virtual host file
          template: src=vhost.tpl dest=/etc/apache2/sites-available/000-default.conf
          notify: restart apache

    handlers:
        - name: restart apache
          service: name=apache2 state=restarted
```

## Explaination

`- name`: optional, as a description

`hosts`: hosts defined in inventory files.

`vars`: variables for using in tasks, template...

`tasks`: jobs, commands Ansible will run

`become`: run command as sudo. In the sample, it means that all command will be run as sudo. If only run sudo for some tasks:

```
...
    tasks:
        - name: Update apt
          become: true
          apt: update_cache=yes
```

`template`: template file

```
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot {{ doc_root }}

    <Directory {{ doc_root }}>
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

Note that {{ doc_root }} will be replaced by the value defined in `vars:`

`notify` and `handlers`: handlers will only run when triggered by notify. Notify call handler by its name.

# Run a playbook

```
ansible-playbook sample-playbook.yml -i inventory-file
```

# Some Ansible Syntax

## Assign command state value and condition statements

```
- name: Check if PHP is installed
  register: php_installed
  command: php -v

- name: This task is only executed if PHP is installed
  when: php_installed|success

- name: This task is only executed if PHP is NOT installed
  debug: msg='PHP is NOT installed'
  when: php_installed|failed
```

`register`: assign command execution state to variable
`when`: condition statement
`debug`: print

## Loops

```
- name: Install bunch of packages
  apt: name={{ item }} state=latest
  with_items:
  - curl
  - wget
```

```
vars:
    packages: [ 'curl', 'wget' ]
tasks:
    - name: Install bunch of packages
      apt: name={{ item }} state=latest
      with_items: packages
```
