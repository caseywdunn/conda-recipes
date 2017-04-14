#!/bin/bash
cat <<EOF > setup.cfg
[directories]
basedirlist = $PREFIX
[packages]
tests = False
toolkit_tests = False
sample_data = False
EOF
sed -i.bak "s|/usr/local|$PREFIX|" setupext.py
$PYTHON setup.py install --single-version-externally-managed --record record.txt
