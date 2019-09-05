#!/bin/bash

TOWER_API=https://127.0.0.1

curl -k -f -i -H 'Content-Type: application/json' -XPOST --user ansibleapi:ansibleapi $TOWER_API/api/v2/job_templates/28/launch/ -d '
{"extra_vars":
{
"user_name":"uid",
"first_name":"you",
"last_name":"you",
"company_name":"xyz",
"user_password":"c3pioLast"
}
}' -vvvv

