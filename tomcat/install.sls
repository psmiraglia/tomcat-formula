{% from 'tomcat/map.jinja' import tomcat_settings with context %}
{% from 'tomcat/map.jinja' import tomcat_version with context %}
{% from 'tomcat/map.jinja' import tomcat_name with context %}
{% from 'tomcat/map.jinja' import tomcat_tarball with context %}
{% from 'tomcat/map.jinja' import tomcat_url with context %}

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
    - name: chown -R {{ tomcat_settings.env.user }}:{{ tomcat_settings.env.user }} /opt/{{ tomcat_name }}
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
