---
layout: post
title: "Rails Cheat Sheet"
---

# Migrations
First rule of migrations, don't talk about migrations, no wait, that's something else... try `rake db:migrate` instead.

# Associations

## 1-1
has_many and belongs_to

# Validations

## Length
`validates :field, length: { maximum: 140 }`

## Presence
`validates :field, presence: true`

