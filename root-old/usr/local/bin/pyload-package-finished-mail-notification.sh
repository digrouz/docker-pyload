#!/usr/bin/env bash
mail -s "Pyload: Package Finished" root <<EOF
${2} was finished at $(date +"%H:%M") on $(date +"%d.%m.%y"). ...forwarding it now to the extraction queue.
EOF
