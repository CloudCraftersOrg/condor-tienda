#!/usr/bin/env bash
set -euo pipefail
id -u condor-tienda >/dev/null 2>&1 || useradd --system --no-create-home condor-tienda
chown -R condor-tienda:condor-tienda /opt/condor-tienda

# Harness-induced deploy failure (P1-14), removed by the harness's own fix commit.
if [ -f /opt/condor-tienda/FAIL_DEPLOY ]; then
  echo "FAIL_DEPLOY marker present" >&2
  exit 1
fi

cp /opt/condor-tienda/deploy/condor-tienda.service /etc/systemd/system/condor-tienda.service
cp /opt/condor-tienda/deploy/condor-tienda-traffic.service /etc/systemd/system/condor-tienda-traffic.service
cp /opt/condor-tienda/deploy/condor-tienda-traffic.timer /etc/systemd/system/condor-tienda-traffic.timer
systemctl daemon-reload
systemctl enable condor-tienda
systemctl start condor-tienda
systemctl enable --now condor-tienda-traffic.timer
