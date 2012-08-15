module MinutesTags
  include Radiant::Taggable
  class TagError < StandardError; end

  desc %{
Renders the content from or a reference to the meeting minutes specified in the
@date@ and @type@ attributes. Additionally, the @as@ attribute can be used to
make the tag render as one of the following:

* @inline@ - the minutes' content in rendered (default).
* @path@ - the full path to the minutes.
* @link@ - link to the url with an (X)HTML @<a/>@ element.

When rendering as a @link@ you can use the @text@ attribute to set the link
text.

*Usage:*

<pre><code><r:minutes date="14 August, 2012" type="ec" as="link" 
text="Meeting Minutes" id="my_id" />
</code></pre>

The above example will produce the following:
      
<pre><code><a href="/2012/08/14/ec" id="my_id">Meeting Minutes</a>
</code></pre>
  }
  tag 'minutes' do |tag|
    date = (tag.attr['date'] || tag.attr['slug'])
    type = tag.attr['type']
    raise TagError.new("`minutes' tag must contain a `date' attribute.") unless date
    raise TagError.new("`minutes' tag must contain a `type' attribute.") unless type
    text = tag.attr['text'] || "#{type} meeting minutes for #{date}"
    slug = Time.parse(date).to_i.to_s
    if (minutes = MinutesPage.find_by_slug(slug))
      path = minutes.path
      optional_attributes = tag.attr.except('date', 'slug', 'name', 'as', 'type', 'text').inject('') { |s, (k, v)| s << %{#{k}="#{v}" } }.strip
      optional_attributes = " #{optional_attributes}" unless optional_attributes.empty?
      case tag.attr['as']
      when 'path'
        path
      when 'inline'
        minutes.render_part(type)
      when 'link'
        %{<a href="#{path}"#{optional_attributes}>#{text}</a>}
      else
        minutes.render_part(type)
      end
    else
      raise TagError.new("No minutes found for #{date}")
    end
  end
end
