{% from 'tomcat/map.jinja' import tomcat_settings with context %}

{% set tomcat_version = tomcat_settings.version.major ~ "." ~ tomcat_settings.version.minor ~ "." ~tomcat_settings.version.patch %}
{% set tomcat_name = "apache-tomcat-" ~ tomcat_version %}
{% set tomcat_tarball = tomcat_name ~ ".tar.gz" %}
{% set tomcat_url = tomcat_settings.base_url ~ "/tomcat-" ~ tomcat_settings.version.major ~ "/v" ~ tomcat_version ~ "/bin/" ~ tomcat_tarball %}

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

