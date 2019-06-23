run:
	docker run -it --rm \
		-v `pwd`:/srv/jekyll \
		-v `pwd`/vendor/bundle:/usr/local/bundle \
		-p "4000:4000" \
		jekyll/jekyll \
		jekyll serve

