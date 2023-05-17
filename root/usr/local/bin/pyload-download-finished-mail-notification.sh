#!/command/with-contenv sh

mail -s "Pyload: Download Finished" root <<EOF
${2} was finished at $(date +"%H:%M") on $(date +"%d.%m.%y"). ...forwarding it now to the extraction queue.
EOF
