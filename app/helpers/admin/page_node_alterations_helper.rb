module Admin::PageNodeAlterationsHelper
  def page_type
    minutes_length = @current_node.children.map{|x| true if x.minutes?}.compact.length
    if minutes_length > 0
      %{ <span class="info">Plus #{link_to "#{minutes_length} others", admin_minutes_url}</span>}
    end
  end
end
