---
layout: post
title: "Rails Cheat Sheet"
---

Having yet again just been through Michael Hartl's [Ruby on Rails Tutorial](www.railstutorial.org) I finally got around to putting together some rails notes for those moments when my brain is short on RAM and doesn't feel like paging.

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

# Views
## content_for
Calling content_for stores a block of content which can be later inserted into a view, using yield. An example is allowing pages to add script files to the page <head>. If the layout has this markup:

~~~erb
<head>
  <%= yield :page_scripts %>
</head>
~~~

then an individual page can add scripts using content_for:

~~~erb
<% content_for :page_scripts do %>
  <%= javascript_include_tag :page %>
<% end %>
~~~

to give the final markup:

~~~html
<head>
  <script src="/javascripts/page.js"></script>
</head>
~~~
