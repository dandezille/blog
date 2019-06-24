---
layout: post
title: "DNSimple Dynamic DNS"
---

I wanted a dynamic DNS entry to point at my home IP address but already pay for DNSimple and didn't want to go faffing about with some other service. 

A bit of googling reveals a [couple](https://support.dnsimple.com/articles/dynamic-dns/) of [pages](https://developer.dnsimple.com/ddns/) from DNSimple themselves explaining how to get things working. They do not support 3rd party dyndns APIs but their API allows the same functionality using a reasonably simple script:

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

Nothing too complicated here, fill in the blanks and away you go. The auth token and account id come from the [automation](https://dnsimple.com/a/15636/account/automation) page under your user account. The zone id is the parent of the DNS entry you want to update. The record id is a little more cryptic but refers to the DNS record you want to update.

According to the DNSimple [docs](https://developer.dnsimple.com/v2/zones/records/) you can find this using the query:

~~~
GET /:account/zones/:zone/records?name=:name
~~~

It would be nice to automate this. The API returns a bunch of json data about the record but we only care about the id so the output is piped to the super handy [jq](https://stedolan.github.io/jq/) to just return the id:

~~~
#!/bin/sh

# Check required variables have been set
: ${ACCOUNT_ID:?}
: ${ZONE_ID:?}
: ${TOKEN:?}
: ${RECORD_NAME:?}

# Request list of records and parse out ids (should only be one!)
curl -H "Authorization: Bearer $TOKEN" \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     "https://api.dnsimple.com/v2/$ACCOUNT_ID/zones/$ZONE_ID/records?name=$RECORD_NAME" \
     | jq '.data[].id'
~~~

Now we have a record id this can be passed into the original script without the cryptic RECORD_ID parameter.

This needs to be automated so this is all packaged into a [docker image](https://cloud.docker.com/repository/docker/dandezille/dnsimple_ddns) for easy deployment.
