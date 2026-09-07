exit_code=0

for file in **/[!_]*.json; do
  # Check that file is valid JSON
  if ! jq_out=$(jq empty "$file" 2>&1); then
    echo "::error::$file is not valid JSON: $jq_out"
    exit_code=1
  else

    # Check that from_date is a valid ISO 8601 date
    for from_date in $(jq -r '.valid[].from' $file); do
      if [ "$(date -d $from_date +%Y-%m-%d 2> /dev/null)" != "$from_date" ]; then
        echo "::error::Invalid from_date in $file : $from_date"
        exit_code=1
      fi
    done

    # Check that to_date is a valid ISO 8601 date
    for to_date in $(jq -r '.valid[].to' $file); do
      if [ "$(date -d $to_date +%Y-%m-%d 2> /dev/null)" != "$to_date" ]; then
        echo "::error::Invalid to_date in $file : $to_date"
        exit_code=1
      fi
    done

    # Check that for every .json file, a .pub exists
    if [[ ! -f "${file%.json}.pub" ]]; then
      echo "::error::${file%.json}.pub doesn't exist"
      exit_code=1
    fi
  fi
done

exit "$exit_code"
