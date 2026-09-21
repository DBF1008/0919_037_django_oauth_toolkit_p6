#!/usr/bin/env bash
#
# Run the unit test suite for this repository.
#
# Usage:
#   ./test.sh                          # run the full unit test suite
#   ./test.sh tests/test_oidc_views.py # run a specific test module
#   ./test.sh -k userinfo              # pass extra arguments to pytest
#
# Environment variables:
#   PYTHON                 Python interpreter to use (default: .venv/bin/python)
#   DJANGO_SETTINGS_MODULE Django settings module (default: tests.settings)
set -euo pipefail
cd "$(dirname "$0")"

PYTHON="${PYTHON:-.venv/bin/python}"
export DJANGO_SETTINGS_MODULE="${DJANGO_SETTINGS_MODULE:-tests.settings}"
export PYTHONPATH=.

if [ "$#" -eq 0 ]; then
    set -- tests/
fi

exec "$PYTHON" -m pytest "$@"
