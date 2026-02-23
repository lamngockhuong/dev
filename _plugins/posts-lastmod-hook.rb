#!/usr/bin/env ruby
#
# Check for changed posts

Jekyll::Hooks.register :posts, :post_init do |post|

  commit_num = IO.popen(['git', 'rev-list', '--count', 'HEAD', post.path]) { |io| io.read }

  if commit_num.to_i > 1
    lastmod_date = IO.popen(['git', 'log', '-1', '--pretty=%ad', '--date=iso', post.path]) { |io| io.read }
    post.data['last_modified_at'] = lastmod_date
  end

end
