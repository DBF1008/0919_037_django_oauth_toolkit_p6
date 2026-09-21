#!/usr/bin/env bash
#
# Run the unit test suite for django-oauth-toolkit.
#
# Usage:
#   ./test.sh                 Run the full unit test suite.
#   ./test.sh oidc            Run only the OIDC view/validator tests.
#   ./test.sh <pytest args>   Pass custom arguments to pytest, e.g.
#                             ./test.sh tests/test_oidc_views.py -k discovery
#
set -euo pipefail

cd "$(dirname "$0")"

PYTHON="${PYTHON:-.venv/bin/python}"
if [ ! -x "$PYTHON" ]; then
    PYTHON="python3"
fi

export DJANGO_SETTINGS_MODULE="${DJANGO_SETTINGS_MODULE:-tests.settings}"

if [ $# -eq 0 ]; then
    # Full unit test suite.
    exec "$PYTHON" -m pytest tests/ -v
elif [ "$1" = "oidc" ]; then
    # Only the OIDC compliance tests (UserInfo, discovery, ID token claims).
    shift
    exec "$PYTHON" -m pytest tests/test_oidc_views.py tests/test_oauth2_validators.py -v "$@"
else
    exec "$PYTHON" -m pytest "$@"
fi
