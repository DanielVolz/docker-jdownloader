#!/bin/sh

trap 'kill -TERM $PID' TERM INT
rm -f /opt/JDownloader/JDownloader.jar.*
rm -f /opt/JDownloader/JDownloader.pid

# Debugging helper - if the container crashes, create a file called "jdownloader-block.txt" in the download folder
# The container will not terminate (and you can run "docker exec -it ... bash")
if [[ -f /root/Downloads/jdownloader-block.txt ]]; then
    sleep 1000000
fi

# Check if JDownloader.jar exists, or if there is an interrupted update
if [[ ! -f /opt/JDownloader/JDownloader.jar ]] && [[ -f /opt/JDownloader/tmp/update/self/JDU/JDownloader.jar ]]; then
    cp /opt/JDownloader/tmp/update/self/JDU/JDownloader.jar /opt/JDownloader/
fi

java -Djava.awt.headless=true -jar /opt/JDownloader/JDownloader.jar &
PID=$!
echo "PID : ${PID}"
wait ${PID}
echo "Process stopped"
wait ${PID}

# Check if JDownloader is running
PID=$(pgrep java)
while [[ "${PID}" ]]; do
    while [[ "$(ls -la "/proc/${PID}/fd/2" 2> /dev/null | wc -l)" -ge 1 ]]; do
        echo "Waiting for jdownloader to finish PID : ${PID}"
        sleep 1
    done
    PID=$(pgrep java)
done

EXIT_STATUS=$?
