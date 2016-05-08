---
layout: post
title: "Rails Cheat Sheet - Routes"
---

Having yet again just been through Michael Hartl's [Ruby on Rails Tutorial](www.railstutorial.org) I've finally got around to putting together some notes for myself, for those moments when my brain is short on RAM and doesn't feel like paging. This first set are on routes, more to follow.

# Routes
To print out the current app's routes, use `rake routes`. Now let's start with the most basic route, the root route which corresponds to / in your application:

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

You can nest routes:

~~~ruby
Rails.application.routes.draw do
  resources :users do
    resource :password
  end
end
~~~

This will produce a singular nested resource within the user resource, with urls like `/users/:user_id/password`, routing to the passwords controller.

~~~
            Prefix Verb   URI Pattern                             Controller#Action
     user_password POST   /users/:user_id/password(.:format)      passwords#create
 new_user_password GET    /users/:user_id/password/new(.:format)  passwords#new
edit_user_password GET    /users/:user_id/password/edit(.:format) passwords#edit
                   GET    /users/:user_id/password(.:format)      passwords#show
                   PATCH  /users/:user_id/password(.:format)      passwords#update
                   PUT    /users/:user_id/password(.:format)      passwords#update
                   DELETE /users/:user_id/password(.:format)      passwords#destroy
~~~
