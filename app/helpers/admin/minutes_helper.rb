module Admin::MinutesHelper
  def minutes_filter_options_for_select(selected=nil)
    options_for_select([[t('select.none'), '']] + TextFilter.descendants.map { |s| s.filter_name }.sort, selected)
  end

  def minutes_format_date(date=nil)
    format = (Radiant::Config['minutes.format'] || '%A, %B %d, %Y')
    @i18n_date_format_keys ||= (I18n.config.backend.send(:translations)[I18n.locale][:date][:formats].keys rescue [])
      format = @i18n_date_format_keys.include?(format.to_sym) ? format.to_sym : format
      I18n.l date, :format => format
  end
end
