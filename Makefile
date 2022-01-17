.DEFAULT_GOAL := serve
.PHONY: serve install post

serve:
	bundle exec jekyll serve

install:
	bundle install

post:
	read -p "Enter the post title: " title; printf "%s\n" "---" "layout: post" "title: '$$title'" "date: '$$( date '+%Y-%m-%d %H:%M:%S %z' )'" "categories: post code" "---" > "_posts/$$( date +%Y-%m-%d )-$$( echo "$$title" | tr ' ' '-' | tr -d -c 'a-zA-Z0-9-' ).markdown"

edit:
	vim "_posts/$$( ls -tr _posts/ | tail -n 1 )"

