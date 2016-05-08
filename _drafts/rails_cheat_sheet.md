---
layout: post
title: "Rails Cheat Sheet"
---

Having yet again just been through Michael Hartl's [Ruby on Rails Tutorial](www.railstutorial.org) I finally got around to putting together some rails notes for those moments when my brain is short on RAM and doesn't feel like paging.

# Routes
To print out the current app's routes, use `rake routes`. Now let's start with the most basic route, the root route:

~~~ruby
Rails.application.routes.draw do
  root 'controller#action'
end
~~~

and you can have routes for specific HTTP methods:

~~~ruby
Rails.application.routes.draw do
  get 'controller/action'
end
~~~

To add a set of routes for a multiple entities use `resources :entities` (using a pluralised name, eg users). This will give you your four view actions (index, new, edit, show) and four HTTP method actions (create - POST, update - PATCH/PUT , destroy - DELETE). For example:

~~~
   Prefix Verb   URI Pattern               Controller#Action
    users GET    /users(.:format)          users#index
          POST   /users(.:format)          users#create
 new_user GET    /users/new(.:format)      users#new
edit_user GET    /users/:id/edit(.:format) users#edit
     user GET    /users/:id(.:format)      users#show
          PATCH  /users/:id(.:format)      users#update
          PUT    /users/:id(.:format)      users#update
          DELETE /users/:id(.:format)      users#destroy
~~~

For singular entities use `resource :entity`. By default the routes will point to a controller using the pluralised entity name. For example:

~~~
      Prefix Verb   URI Pattern             Controller#Action
     session POST   /session(.:format)      sessions#create
 new_session GET    /session/new(.:format)  sessions#new
edit_session GET    /session/edit(.:format) sessions#edit
             GET    /session(.:format)      sessions#show
             PATCH  /session(.:format)      sessions#update
             PUT    /session(.:format)      sessions#update
             DELETE /session(.:format)      sessions#destroy
~~~

You can nest routes, for example:

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
