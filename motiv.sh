#!/bin/bash

# Retrieve hpone number from env vars
source /home/pi/bin/config.txt

# Set up phone number & message
MESSAGE_DATA="$(curl -s https://api.quotable.io/random)"
MESSAGE_CONTENT=`echo $MESSAGE_DATA | python3 -c "import sys, json; print(json.load(sys.stdin)['content'])"`
SERVER="localhost"
PORT=9090

# Start the server in the background
node /home/pi/src/motivation/textbelt/server/app.js &

# Give a slight delay to allow for server to be spun up
sleep 5

# Execute the curl command
curl -X POST http://$SERVER:$PORT/text \
   -d number=$NUMBER \
   -d "message=$MESSAGE_CONTENT"

# Wait for 10 seconds
sleep 10

# Kill the node process
kill $!
