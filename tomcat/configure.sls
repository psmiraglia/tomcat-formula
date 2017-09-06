{% from 'tomcat/map.jinja' import tomcat_settings with context %}
{% from 'tomcat/map.jinja' import tomcat_version with context %}
{% from 'tomcat/map.jinja' import tomcat_name with context %}
{% from 'tomcat/map.jinja' import tomcat_tarball with context %}
{% from 'tomcat/map.jinja' import tomcat_url with context %}

include:
  - tomcat.install

/opt/{{ tomcat_name }}/bin/setenv.sh:
  file.managed:
    - source: salt://tomcat/files/setenv.sh.jinja
    - makedirs: True
    - template: jinja
    - mode: 0750
    - context:
        tomcat_settings: {{ tomcat_settings }}
    - user: {{ tomcat_settings.env.user }}
    - group: {{ tomcat_settings.env.group }}
    - require:
      - sls: tomcat.install

