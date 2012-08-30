module Admin::MinutesHelper
  def minutes_filter_options_for_select(selected=nil)
    options_for_select([[t('select.none'), '']] + TextFilter.descendants.map { |s| s.filter_name }.sort, selected)
  end

  def status_to_display
    Status.selectable.map{ |s| [I18n.translate(s.name.downcase), s.id] }
  end

  def minutes_meeting_type_options_for_select(selected=nil)
    options_for_select(MinutesExtension.meeting_types.sort, selected)
  end

  def minutes_format_date(date=nil)
    I18n.l date, :format => :long
  end
end
