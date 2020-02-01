#!/bin/sh
SOURCE_FILES=${SOURCE_FILES}
DEST_FILES=${DEST_FILES}

set -- ${DEST_FILES}
COUNT=0
for sourceFile in ${SOURCE_FILES}; do
  COUNT=$((${COUNT} + 1))
  eval destFile=\$$(($COUNT))

  printf "moving sourcefile: ${sourceFile} to the correct destFile: /tmp/paths${destFile}\n"

  mkdir -p "$(dirname /tmp/paths${destFile})" && cp -R "${sourceFile}" "/tmp/paths${destFile}"
done
