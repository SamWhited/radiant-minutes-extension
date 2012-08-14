module MinutesTags
  include Radiant::Taggable
  class TagError < StandardError; end

  desc %{
Renders the content from or a reference to the meeting minutes specified in the
@date@ and @type@ attributes. Additionally, the @as@ attribute can be used to
make the tag render as one of the following:

* with no @as@ value the minutes content is rendered.
* @inline@ - the minutes' content in rendered and filters are applied.
* @path@ - the full path to the minutes.
* @link@ - link to the url with an (X)HTML @<a/>@ element.

When rendering as a @link@ you can use the @text@ attribute to set the link
text.

*Usage:*

<pre><code><r:minutes date="14 August, 2012" type="ec" as="link" 
text="Meeting Minutes" id="my_id" />
</code></pre>

The above example will produce the following:
      
<pre><code>        <a href="/2012/08/14/ec" id="my_id">Meeting Minutes</a>
</code></pre>
  }
  tag 'minutes' do |tag|
    date = (tag.attr['date'] || tag.attr['name'] || tag.attr['slug'])
    raise TagError.new("`minutes' tag must contain a `date' attribute.") unless date
  end
end
