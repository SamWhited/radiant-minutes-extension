module MinutesTags
  include Radiant::Taggable
  class TagError < StandardError; end

  desc %{
Renders the contents of the tag if the page contains meeting minutes.

*Usage:*

<pre><code><r:if_minutes>These are meeting minutes</r:if_minutes>
</code></pre>
  }
  tag 'if_minutes' do |tag|
    tag.expand if tag.locals.page.is_a?(Minutes::Instance)
  end

  desc %{
Renders the contents of the tag if the page does not contain meeting
minutes.

*Usage:*

<pre><code><r:unless_minutes>This page is not a meeting minutes
page.</r:unless_minutes>
</code></pre>
  }
  tag 'unless_minutes' do |tag|
    tag.expand unless tag.locals.page.is_a?(Minutes::Instance)
  end
end
