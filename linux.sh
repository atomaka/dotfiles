#!/bin/bash

if test ! -d ~/.rbenv ; then
	git clone https://github.com/rbenv/rbenv.git ~/.rbenv
fi
if test ! -d ~/.rbenv/plugins/ruby-build ; then
	git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
fi
