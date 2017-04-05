#!/bin/bash
set -e
virtualenv/bin/flake8 local/*.py remote/*.py cli/telepresence
virtualenv/bin/pylint -E local/entrypoint.py
cli/telepresence --version
cli/telepresence --help
[ -z "$TELEPRESENCE_TESTS" ] && export TELEPRESENCE_TESTS="-n 4 tests remote/test_socks.py"
env PATH="$PWD/cli/:$PATH" virtualenv/bin/py.test -v \
    --timeout 240 --timeout-method thread --fulltrace $TELEPRESENCE_TESTS
