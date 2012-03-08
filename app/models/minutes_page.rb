class MinutesPage < Page
  include Minutes::Instance

  def self.new_with_defaults(config = Radiant::Config)
    page = MinutesPage.new
    page.slug = Time.now.to_i.to_s
    page.parts.concat(self.default_page_parts)
    page.parent_id = MinutesPage.root.try(:id)
    page.status_id = Status[:published].id
    page
  end

end
