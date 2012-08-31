class MinutesPage < Page
  include Minutes::Instance

  def self.new_with_defaults(config = Radiant::Config)
    page = MinutesPage.new
    page.parts.concat(self.default_page_parts)
    page.parent_id = Page.find_by_path(MinutesExtension.minutes_path).try(:id)
    page.status = Status[Radiant::Config['defaults.page.status']]
    page
  end

end
