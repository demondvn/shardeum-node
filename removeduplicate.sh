#!/bin/bash
cd backup
jq -s 'unique' input.json > output.json
