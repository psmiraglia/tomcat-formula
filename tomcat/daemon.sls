{% from 'tomcat/map.jinja' import tomcat_settings with context %}
{% from 'tomcat/map.jinja' import tomcat_version with context %}
{% from 'tomcat/map.jinja' import tomcat_name with context %}
{% from 'tomcat/map.jinja' import tomcat_tarball with context %}
{% from 'tomcat/map.jinja' import tomcat_url with context %}

tomcat_systemd_unit:
  file.managed:
    - name: /etc/systemd/system/tomcat.service
    - source: salt://tomcat/files/tomcat.service.jinja
    - template: jinja
    - context:
        tomcat_settings: {{ tomcat_settings }}
        tomcat_name: {{ tomcat_name }}

  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: tomcat_systemd_unit

tomcat_enabled:
  service.enabled:
    - name: tomcat

