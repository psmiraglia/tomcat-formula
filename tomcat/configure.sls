{% from 'tomcat/map.jinja' import tomcat_settings with context %}

{% set tomcat_version = tomcat_settings.version.major ~ "." ~ tomcat_settings.version.minor ~ "." ~tomcat_settings.version.patch %}
{% set tomcat_name = "apache-tomcat-" ~ tomcat_version %}
{% set tomcat_tarball = tomcat_name ~ ".tar.gz" %}
{% set tomcat_url = tomcat_settings.base_url ~ "/tomcat-" ~ tomcat_settings.version.major ~ "/v" ~ tomcat_version ~ "/bin/" ~ tomcat_tarball %}

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

