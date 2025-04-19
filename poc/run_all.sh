#!/bin/bash
set -e

# Start the mocksite in the background
cd "$(dirname "$0")/mocksite"
echo "[INFO] Starting mocksite on http://127.0.0.1:5000 ..."
python3 app.py > ../mocksite_server.log 2>&1 &
MOCKSITE_PID=$!
cd ..

# Wait for the server to be ready
sleep 2

# Test URLs
TEST_URL="http://127.0.0.1:5000/blog/article1"

# Run Python prototype
cd python
echo "[INFO] Running Python prototype..."
python3 prototype.py "$TEST_URL"
cd ..

# Run Node.js prototype
cd nodejs
echo "[INFO] Running Node.js prototype..."
node prototype.js "$TEST_URL"
cd ..

# Run Go prototype
cd go
echo "[INFO] Running Go prototype..."
go run prototype.go "$TEST_URL"
cd ..

# Kill the mocksite server
kill $MOCKSITE_PID
wait $MOCKSITE_PID 2>/dev/null || true

echo "[INFO] All tests completed. Check provenance.json files in each language folder."
