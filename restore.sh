
#!/bin/bash
#!/bin/bash

for file in $(ls backup/shardeum-node-*.json | sed 's/\.json$//'); do
  echo "$(pwd)/$file.json"
  docker cp "$(pwd)/$file.json" "$(file)":/node/cli/build/secrets.json

done
echo "Done"