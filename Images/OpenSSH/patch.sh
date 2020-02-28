#!/bin/bash
bash_version="5.0"
bash_patch_level=0

bash_patch_prefix=$(echo "bash${bash_version}" | sed -e 's/\.//g')
pushd bash-${bash_version}
for lvl in $(seq $bash_patch_level); do
  curl -L http://ftp.gnu.org/gnu/bash/bash-${bash_version}-patches/${bash_patch_prefix}-$(printf '%03d' $lvl) | patch -p0
done
