FROM grafana/grafana

ENV GF_INSTALL_PLUGINS="grafana-piechart-panel, blackmirror1-singlestat-math-panel"
ENV GF_SECURITY_ADMIN_PASSWORD="password"

WORKDIR /
COPY ./config/provisioning /etc/grafana/provisioning
COPY ./config/dashboards /var/lib/grafana/dashboards
COPY ./config/dashboards/analysis-server.json /var/lib/grafana/dashboards/
COPY ./config/grafana.ini /etc/grafana/grafana.ini

CMD sh /run.sh