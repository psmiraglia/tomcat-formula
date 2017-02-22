{% from 'tomcat/map.jinja' import tomcat_settings with context %}

{% set tomcat_version = tomcat_settings.version.major ~ "." ~ tomcat_settings.version.minor ~ "." ~tomcat_settings.version.patch %}
{% set tomcat_name = "apache-tomcat-" ~ tomcat_version %}
{% set tomcat_tarball = tomcat_name ~ ".tar.gz" %}
{% set tomcat_url = tomcat_settings.base_url ~ "/tomcat-" ~ tomcat_settings.version.major ~ "/v" ~ tomcat_version ~ "/bin/" ~ tomcat_tarball %}

include:
  - tomcat.user

install_binaries:
  archive.extracted:
    - name: /opt/
    - source: {{ tomcat_url }}
    - source_hash: {{ tomcat_settings.version.hash }}
    - archive_format: tar
    - require:
        - sls: tomcat.user
  
  cmd.run:
    - name: chown -Rv {{ tomcat_settings.env.user }}:{{ tomcat_settings.env.user }} /opt/{{ tomcat_name }}

  file.symlink:
    - name: /var/log/tomcat
    - target: /opt/{{ tomcat_name }}/logs

remove_useless_files:
  file.absent:
    - names:
        - /opt/{{ tomcat_name }}/webapps/examples
        - /opt/{{ tomcat_name }}/webapps/docs
    - require:
        - archive: install_binaries

