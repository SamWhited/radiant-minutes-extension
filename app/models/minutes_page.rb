class MinutesPage < Page
  include Minutes::Instance

  def self.new_with_defaults(config = Radiant::Config)
    page = MinutesPage.new
    page.parts.concat(PagePart.new(:name => 'Other'))
    page.parent_id = MinutesPage.root.try(:id)
    page.status_id = Status[:published].id
    page
  end

end
