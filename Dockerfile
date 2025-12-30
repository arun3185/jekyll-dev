FROM jekyll/jekyll:4
WORKDIR /srv/jekyll

# Copy only Gemfile first (for Docker layer caching)
COPY docs/Gemfile docs/Gemfile.lock* ./

# Install gems (including github-pages)
RUN bundle install

# Copy the rest of the site
COPY docs/ ./

EXPOSE 4000 35729

CMD bundle exec jekyll serve \
  --host 0.0.0.0 \
  --port 4000 \
  --livereload \
  --force_polling \
  --watch \
# --incremental false \
  --source /srv/jekyll \
  --destination /srv/jekyll/_site
