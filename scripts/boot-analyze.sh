#!/usr/bin/env bash
set -euo pipefail

echo "Boot analysis started at: $(date)"
echo

echo "== systemd-analyze =="
systemd-analyze
echo

echo "== systemd-analyze blame (top 15) =="
systemd-analyze blame | head -15
echo

echo "== systemd-analyze critical-chain =="
systemd-analyze critical-chain
echo

echo "Analysis completed."
