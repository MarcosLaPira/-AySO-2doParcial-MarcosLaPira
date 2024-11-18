#levantar nueva vm desarrollo
# a ambas vm modificarles su ip, con la solicitada

#genero llave
ssh-keygen

# pego la llave en desa

# creo inventory 
[desarrollo]
192.168.56.9 ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
# creo playbook
---
- hosts: 
    - desarrollo
  tasks:
    - name: "Set WEB_SERVICE dependiendo de la distro"
      set_fact:
        WEB_SERVICE: "{% if   ansible_facts['os_family']  == 'Debian' %}apache2 
                      {% elif ansible_facts['os_family'] == 'RedHat'  %}httpd
                      {% endif %}"

    - name: "Muestro nombre del servicio:"
      debug:
        msg: "nombre: {{ WEB_SERVICE }}"

    - name: "Run the equivalent of 'apt update' as a separate step"
      become: yes
      ansible.builtin.apt:
        update_cache: yes
      when: ansible_facts['os_family'] == "Debian"

    - name: "Instalando apache " 
      become: yes
      package:
        name: "{{ item }}"
        state: present
      with_items:
        - "{{ WEB_SERVICE }}"

    # Copio pagina web
    - name: "Copiando mi pagina web"
      become: yes
      copy:
        src: index.html
        dest: /var/www/html/index.html
        owner: "www-data"
        group: "www-data"
        mode: 0644

    #systemctl enable --now httpd
    - name: "Habilitar y restartear apache2"
      become: yes
      ansible.builtin.service:
        name: "apache2"
        enabled: yes
        state: restarted
      when: ansible_facts['os_family'] == "Debian"
      ignore_errors: true

    #systemctl enable --now httpd
    - name: "Habilitar y restartear httpd"
      become: yes
      ansible.builtin.service:
        name: "httpd"
        enabled: yes
        state: restarted
      when: ansible_facts['os_family'] == "RedHat"



sudo apt install sshpass -y
#ejecuto 
ansible-playbook -i inventory playbook.yml
