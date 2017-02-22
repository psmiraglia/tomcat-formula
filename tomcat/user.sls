{% from 'tomcat/map.jinja' import tomcat_settings with context %}

create_tomcat_group:
    group.present:
        - name: {{ tomcat_settings.env.group }}
        - system: True

create_tomcat_user:
    user.present:
        - name: {{ tomcat_settings.env.user }}
        - groups:
            - {{ tomcat_settings.env.group }}
        - fullname: Tomcat User
        - shell: /bin/bash
        - empty_password: True
        - system: True
        - require:
            - group: create_tomcat_group

