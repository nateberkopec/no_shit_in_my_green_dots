# Release process

1. Bump `lib/no_shit_in_my_green_dots/version.rb`.
2. Release the primary gem (keeps tagging/metadata as-is):
   - `bundle exec rake release`
3. Publish the work-safe name at the same version (no extra tag):
   - `bundle exec gem build no_stuff_in_my_green_dots.gemspec`
   - `bundle exec gem push no_stuff_in_my_green_dots-<VERSION>.gem`

Both gemspecs rely on the same code and version constant; keep them in lockstep.
