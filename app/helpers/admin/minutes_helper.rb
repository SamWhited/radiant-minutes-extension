module Admin::MinutesHelper
  def minutes_filter_options_for_select(selected=nil)
    options_for_select([[t('select.none'), '']] + TextFilter.descendants.map { |s| s.filter_name }.sort, selected)
  end

  def minutes_meeting_type_options_for_select(selected=nil)
    options_for_select(MinutesExtension.meeting_types.sort, selected)
  end

  def minutes_format_date(date=nil)
    format = (Radiant::Config['minutes.format'] || '%A, %B %d, %Y')
    @i18n_date_format_keys ||= (I18n.config.backend.send(:translations)[I18n.locale][:date][:formats].keys rescue [])
      format = @i18n_date_format_keys.include?(format.to_sym) ? format.to_sym : format
      I18n.l date, :format => format
  end

  def default_filter_name
    ''
  end

  def minutes_edit_javascripts
    <<-CODE
    function addPart(form) {
       if (validPartName()) {
        new Ajax.Updater(
          $('tab_control').down('.pages'),
          '#{admin_page_parts_path}',
          {
            asynchronous: true,
            evalScripts: true,
            insertion: 'bottom',
            onComplete: function(request){ partAdded() },
            onLoading: function(request){ partLoading() },
            parameters: Form.serialize(form)
          }
        );
      }
    }
    function removePart() {
      if(confirm('Remove the current part?')) {
        TabControls['tab_control'].removeSelected();
      }
    }
    function partAdded() {
      var tabControl = TabControls['tab_control'];
      $('add_part_busy').hide();
      $('add_part_button').disabled = false;
      $('add_part_popup').closePopup();
      $('part_name_field').value = '';
      tabControl.updateTabs();
      tabControl.select(tabControl.tabs.last());
    }
    function partLoading() {
      $('add_part_button').disabled = true;
      $('add_part_busy').appear();
    }
    function validPartName() {
      var partNameField = $('part_name_field');
      var name = partNameField.value.downcase();
      if (name.blank()) {
        alert('Part name cannot be empty.');
        return false;
      }
      if (TabControls['tab_control'].findTabByCaption(name)) {
        alert('Part name must be unique.');
        return false;
      }
      return true;
    }

    var lastPageType = '#{@page.class.name}';
    var tagReferenceWindows = {};
    function loadTagReference(part) {
      var pageType = $F('page_class_name');
      if (!tagReferenceWindows[pageType])
        tagReferenceWindows[pageType] = new Popup.AjaxWindow("#{admin_reference_path('tags')}?class_name=" + encodeURIComponent(pageType), {reload: false});
      var window = tagReferenceWindows[pageType];
      if(lastPageType != pageType) {
        $('tag_reference_link_' + part).highlight();
        window.show();
      } else {
        window.toggle();
      }
      lastPageType = pageType;
      return false;
    }

    var lastFilter = '#{default_filter_name}';
    var filterWindows = {};
    function loadFilterReference(part) {
      var filter = $F("part_" + part + "_filter_id");
      if (filter != "") {
        if (!filterWindows[filter]) filterWindows[filter] = new Popup.AjaxWindow("#{admin_reference_path('filters')}?filter_name="+encodeURIComponent(filter), {reload: false});
        var window = filterWindows[filter];
        if(lastFilter != filter) {
          window.show();
        } else {
          window.toggle();
        }
        lastFilter = filter;
      } else {
        alert('No documentation for filter.');
      }
      return false;
    }
    CODE
  end
end
