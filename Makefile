JS:= achievement.js entity.js food.js microbe.js microbes.js ui.js
CSS:= microbes.css
minify: dist/microbes.min.js dist/microbes.min.css
dist/microbes.min.js: $(JS) vendor/autoload.php
	mkdir -p dist
	php -r "\
		require __DIR__ . '/vendor/autoload.php';\
		use MatthiasMullie\Minify;\
		\$$minifier = new Minify\JS();\
		foreach(explode(' ','$(JS)') as \$$file){\
			\$$minifier->add(\$$file);\
			}\
		\$$minifier->minify('$@');\
	"

dist/microbes.min.css: $(CSSt) vendor/autoload.php
	mkdir -p dist
	php -r "\
		require __DIR__ . '/vendor/autoload.php';\
		use MatthiasMullie\Minify;\
		\$$minifier = new Minify\CSS();\
		foreach(explode(' ','$(CSS)') as \$$file){\
			\$$minifier->add(\$$file);\
			}\
		\$$minifier->minify('$@');\
	"

.PHONY: clean
clean:
	rm -frv vendor
	rm -frv dist

.PHONY: deps_update
deps_update:
	composer update
.PHONY: setup
setup: vendor/autoload.php

composer.lock: composer.json
	composer install
	touch $@
vendor/autoload.php: composer.lock
	composer install
	touch $@
