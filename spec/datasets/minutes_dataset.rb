class MinutesDataset < Dataset::Base
  uses :home_page

  def load
    create_page 'minutes', :slug => 'minutes', :class_name => 'MinutesPage', :parent_id => pages(:home).id do
      create_page 'general.minutes', :slug => '1331010000', :class_name => 'MinutesPage' do
        create_page_part 'general_minutes_body', :name => 'General', :content => 'General Minutes'
      end
    end
  end
end
