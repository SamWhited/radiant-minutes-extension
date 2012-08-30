class MinutesDataset < Dataset::Base
  uses :home_page

  def load
    create_page 'minutes', :slug => 'minutes', :class_name => 'Page', :parent_id => pages(:home).id do
      create_page 'general', :slug => 'general-1331010000', :class_name => 'MinutesPage'
    end
  end
end
