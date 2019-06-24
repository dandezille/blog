---
layout: post
title: "DNSimple Dynamic DNS"
---

I wanted a dynamic DNS entry to point to my home IP address but already pay for dnsimple and didn't want to go faffing about with some other service. 

A bit of googling reveals a (couple)[https://support.dnsimple.com/articles/dynamic-dns/] of (pages)[https://developer.dnsimple.com/ddns/] from DNSimple themselves explaining how to get things working. They do not support separate 3rd party dyndns APIs but their API allows the same functionality using a resonably simple script:

~~~
#!/bin/bash

TOKEN="your-oauth-token"  # The API v2 OAuth token
ACCOUNT_ID="12345"        # Replace with your account ID
ZONE_ID="yourdomain.com"  # The zone ID is the name of the zone (or domain)
RECORD_ID="1234567"       # Replace with the Record ID
IP=`curl --ipv4 -s http://icanhazip.com/`

curl -H "Authorization: Bearer $TOKEN" \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     -X "PATCH" \
     -i "https://api.dnsimple.com/v2/$ACCOUNT_ID/zones/$ZONE_ID/records/$RECORD_ID" \
     -d "{\"content\":\"$IP\"}"
~~~

Nothing too complicated here, fill in the blanks and away you go. The auth token and account id come from the (automation)[https://dnsimple.com/a/15636/account/automation] page under your user account. The zone id is the parent of the DNS entry you want to update. The record id is a little more cryptic but refers to the DNS record you want to update.

According to the DNSimple (docs)[https://developer.dnsimple.com/v2/zones/records/] this can be done using the query:
~~~ GET /:account/zones/:zone/records?name=:name ~~~

In practice, this looks like:

~~~
#!/bin/bash

TOKEN="your-oauth-token"  # The API v2 OAuth token
ACCOUNT_ID="12345"        # Replace with your account ID
ZONE_ID="yourdomain.com"  # The zone ID is the name of the zone (or domain)
RECORD_NAME="www"         # The name of the record entry to query

curl -H "Authorization: Bearer $TOKEN" \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     "https://api.dnsimple.com/v2/$ACCOUNT_ID/zones/$ZONE_ID/records?name=$RECORD_NAME"
~~~

This returns the record data as json which we can pass to ~~~jq~~~ to give us some readable output:

~~~
{
  "data": [
    {
      "id": 14497124,
      "zone_id": "ddez.net",
      "parent_id": null,
      "name": "home",
      "content": "92.136.108.69",
      "ttl": 600,
      "priority": null,
      "type": "A",
      "regions": [
        "global"
      ],
      "system_record": false,
      "created_at": "2018-09-08T17:53:38Z",
      "updated_at": "2019-06-24T10:55:56Z"
    }
  ],
  "pagination": {
    "current_page": 1,
    "per_page": 30,
    "total_entries": 1,
    "total_pages": 1
  }
}
~~~

What we want is the id field in the data array. We can extract this directly using ~~~ jq '.data
