---
layout: post
title: "How Blog?"
---

Well now that I have a blog, I suppose a good first post would be what tools I used and how I got it working. As this is a personal site, I have no interest in spending my time managing database migrations, updating virtual servers, managing AWS keys, etc I just want something simple. I'd migrated my publicity site from my racing days from Wordpress to Rails and then to Nanoc, with decreasing accompanying stress levels, so I'm sold on the static site builder concept. 

I'd heard a lot recently about GitHub Pages and Jekyll so thought this a good opportunity to give it a whirl. This is a pretty high level overview, so if you're trying to follow this and none of it makes any sense, there are plenty of good low level walk throughs out there and the documentation is by and large very good.

# Step 1 - GitHub Pages
Well, I suppose there is an implicit step 0 in setting up a GitHub account but if you've not got that far I don't think my level of run though is going to be a great help... 

But onwards, there are good [instructions available](https://pages.github.com) from GitHub. It boils down to creating a repo called 'username.github.io' and cloning that to your local machine 

```
git clone https://github.com/username/username.github.io
```

Stick some content in and you are ready to go, yes, just like that!

# Step 2 - Jekyll setup 

While you can just dive in from there, I'd suggest getting your local Jekyll install setup first as recommended by the Jekyll [documentation](https://jekyllrb.com/docs/github-pages). This involves creating a Gemfile with the following content:

~~~ruby
source 'https://rubygems.org'

require 'json'
require 'open-uri'
versions = JSON.parse(open('https://pages.github.com/versions.json').read)

gem 'github-pages', versions['github-pages']
~~~

and running `bundle install`. This should setup Jekyll to match the version used by GitHub Pages. You can start from scratch with your content, I investigated a few templates such as [HTML5 Boilerplate](https://html5boilerplate.com) but in the end I went with `jekyll new .`. This gives you a template site, file structure and config which I found a good starting point to work from. If you've already got your Gemfile in your working directory you may need `jekyll new . --force` to get it to run.

# Step 3 - Jekyll serve
Right about now you might want to take a look at your site. Jekyll comes with a handy web server for testing locally which you start with `jekyll serve`. If you want to include draft posts you need to use `jekyll serve --drafts`. Check the output but if all is well you should be able to go to [http://127.0.0.1:4000](http://127.0.0.1:4000) to see your new site. The serve command automatically picks up file changes in the background (except for changes to config.yml) providing a fast feedback loop.

# Step 4 - Git push
Once your happy with your site and content, simply `git commit` and `git push` up to GitHub. And that's it, head to username.github.io and you should see your site.

# Step 5 - Custom domain
One last step, if you want to point your own domain at your site. Create a file called CNAME which contains your domain and check this in. Then go to your domain DNS configuration and create a CNAME record for child domains (www.*) and an ALIAS, ANAME or A record for a top level domain. However your users get to your site they will be directed to the site specified in the CNAME file in your repository. For more info, check out the [docs](https://help.github.com/articles/using-a-custom-domain-with-github-pages)

# Gotchas
So far, the first gotcha I've found is that GitHub Pages doesn't use GitHub Flavoured Markdown... HMPH! Up shot of this is that all the tutorials which tell you to use 3 backticks ``` to surround a code block are wrong, you need to use three tildes ~~~.
