---
layout: post
title: "Rails Cheat Sheet - Views"
---

# link_to
Use the link_to helper to insert a link into markup (with optional html attributes):

~~~erb
<%= link_to "link text", "/link_target", id: "id", class: "class" %>
~~~

Rails route functions can be used as the target and model instances will be converted to the appropriate path:

~~~erb
<%= link_to "link text", user_path(@user) %>
<%= link_to "link text", @user %>
~~~

A method argument can be supplied to create a link which uses HTTP verbs other than GET:

~~~erb
<%= link_to "link text", "/link_target", method: :delete %>
~~~

# image_tag
This helper will produce an img element, targetting the specified file name in the 'app/assets/images' folder. It can be used as the link text part of a call to link_to to produce an image link.

~~~erb
<%= image_tag 'user.png', alt: 'user image' %>
<%= link_to image_tag('user.png', alt: 'user image'), @user %>
~~~

# content_for
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

# render
The render method allows partials to be included in the page
