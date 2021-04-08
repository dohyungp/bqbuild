#!/bin/bash

for file in ./src/*.sql; do
    printf "Started to execute %s\n" "$file"
    # dry run for check bq query is okay
    message=$( bq query --use_legacy_sql=false --dry_run < "$file" )
    if [[ $message != *"Query successfully validated."* ]]; then
        printf "FATAL: To execute a script(%s) is failed with below error.\n" "$file"
        printf "%s\n" "$message"
        exit 1
    fi
    # execute bq query
    bq query --use_legacy_sql=false < "$file"
    printf "Ended to execute %s\n" "$file"
done
