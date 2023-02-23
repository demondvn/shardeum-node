
#!/bin/bash
apt install jq -y
cd backup
for file in $(ls shardeum-node-*.json | sed 's/\.json$//'); do
    echo "$file.json"
    jq -s 'unique' "$file.json" > "$file_output.json"
    echo "Removed $(($(wc -l < "$file.json") - $(wc -l < "$file_output.json"))) duplicate entries."
    jq '.[0]' "$file_output.json" > $file.json
done
echo "Done"