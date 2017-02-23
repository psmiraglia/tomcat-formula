{% from 'tomcat/map.jinja' import tomcat_settings with context %}

{% set tomcat_version = tomcat_settings.version.major ~ "." ~ tomcat_settings.version.minor ~ "." ~tomcat_settings.version.patch %}
{% set tomcat_name = "apache-tomcat-" ~ tomcat_version %}
{% set tomcat_tarball = tomcat_name ~ ".tar.gz" %}
{% set tomcat_url = tomcat_settings.base_url ~ "/tomcat-" ~ tomcat_settings.version.major ~ "/v" ~ tomcat_version ~ "/bin/" ~ tomcat_tarball %}

# stop daemon
delete_systemd_unit:
  service.dead:
    - name: tomcat
    - enable: False
  file.absent:
    - name: /etc/systemd/system/tomcat.service
  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: delete_systemd_unit

# delete tomcat dirs
delete_files:
  file.absent:
    - names:
      - /opt/{{ tomcat_name }}
      - /var/log/tomcat

# delete user/group
delete_user_and_group:
  user.absent:
    - name: {{ tomcat_settings.env.user }}
  group.absent:
    - name: {{ tomcat_settings.env.group }}

