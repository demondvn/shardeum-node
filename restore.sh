
#!/bin/bash
#!/bin/bash

for file in $(ls backup/shardeum-node-*.json | sed 's/\.json$//'); do
  echo "$(pwd)/backup/$file.json"
  docker cp "$(pwd)/backup/$file.json" "$(file)":/node/cli/build/secrets.json

done
echo "Done"