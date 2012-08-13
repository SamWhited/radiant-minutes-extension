class MinutesDataset < Dataset::Base
  uses :home_page

  def load
    create_page 'minutes', :slug => 'minutes', :class_name => 'MinutesPage', :parent_id => pages(:home).id do
      create_page '2012', :slug => '2012', :class_name => 'MinutesPage' do
        create_page '03', :slug => '03', :class_name => 'MinutesPage' do
          create_page '06', :slug => '06', :class_name => 'MinutesPage' do
            create_page 'ec', :slug => 'ec', :class_Name => 'MinutesPage' do
              create_page_part 'ec_minutes_body', :name => 'body', :content => 'EC Minutes'
            end
          end
        end
      end
    end
  end
end
