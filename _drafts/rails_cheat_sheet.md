---
layout: post
title: "Rails Cheat Sheet"
---

Having yet again just been through Michael Hartl's [Ruby on Rails Tutorial](www.railstutorial.org) I finally got around to putting together some rails notes for those moments when my brain is short on RAM and doesn't feel like paging.

# Routes
To print out the current app's routes, use `rake routes`. Starting with the most basic route, the, root route:

~~~ruby
Rails.application.routes.draw do
  root 'controller#action'
end
~~~

To add a set of routes for a multiple entities use `resources :entities` (using a pluralised name, eg users). This will give you your four view actions (index, new, show, edit) and four HTTP method actions (create - POST, update - PATCH/PUT , destroy - DELETE). For singular entities use `resource :entity`. By default the routes will point to a controller using the pluralised entity name.

You can nest routes, eg:

~~~ruby
Rails.application.routes.draw do
  resources :users do
    resource :password
  end
end
~~~

This will produce a singular nested resource within the user resource, with urls like `/users/:user_id/password`, routing to the passwords controller.

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
