#!/bin/bash

echo $1 > params.json

# Extract a value. Could also just pass the JSON to PHP
name=`cat params.json | jq -r '.name'`

# Execute the script
php phpinfo.php $name > result.html

# Write it to the activation log
cat result.html

# Return JSON formatted values.
echo '{ "result": {"success": true} }'
