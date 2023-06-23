FROM jekyll/jekyll:4.2.0
# The docker images uses a normal user instead of root (which is good),
# but that also means you can't just put everything in /app because the
# permissions are all fucked up then. Took me a while this one.
COPY . /srv/website
WORKDIR /srv/website
EXPOSE 4000

# Now here's where permissions are fucking in a cryptic way for me.
# Don't know why I need it, but I need it and I hate it.
RUN touch Gemfile.lock
RUN chmod a+w Gemfile.lock
# Install theme dependencies
RUN bundle install
# Same with this junk, if we don't create the folders ourselves,
# stuff crashes on permission errors...
RUN mkdir _site .jekyll-cache
RUN jekyll build
