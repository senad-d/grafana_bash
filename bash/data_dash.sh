#!/bin/bash

mkdir /home/"${SUDO_USER:-$USER}"/docker/grafana/datasources
mkdir /home/"${SUDO_USER:-$USER}"/docker/grafana/dashboards

cat <<EOF > /home/"${SUDO_USER:-$USER}"/docker/grafana/datasources/datasource.yml
apiVersion: 1

datasources:
  
  - name: CloudWatch
    orgId: 1
    type: file
    disableDeletion: false
    editable: true
    updateIntervalSeconds: 60
    allowUiUpdates: true
    options:
      path: /etc/grafana/provisioning/dashboards
      foldersFromFilesStructure: true
  
  - name: InfluxDB
    type: influxdb
    access: Browser
    database: telegraf
    url: http://localhost:8086
    jsonData:
      httpMode: GET
EOF

cat <<EOF > /home/"${SUDO_USER:-$USER}"/docker/grafana/dashboards/dashboard.yml
apiVersion: 1
datasources:
  - name: CloudWatch
    type: cloudwatch
    jsonData:
      authType: default
      defaultRegion: ${AWSREGION}
EOF