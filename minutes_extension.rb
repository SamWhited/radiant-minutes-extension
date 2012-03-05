# Uncomment this if you reference any of your controllers in activate
# require_dependency "application_controller"
require "radiant-minutes-extension"

class MinutesExtension < Radiant::Extension
  version     RadiantMinutesExtension::VERSION
  description RadiantMinutesExtension::DESCRIPTION
  url         RadiantMinutesExtension::URL

  # See your config/routes.rb file in this extension to define custom routes

  extension_config do |config|
    # config is the Radiant.configuration object
  end

  def activate
    MenuRenderer.exclude 'MinutesPage'

    tab 'Content' do
      add_item "Meeting Minutes", "/admin/minutes", :after => "Pages"
    end

    ApplicationHelper.module_eval do
      def filter_options_for_select_with_minutes_restrictions(selected=nil)
        minutes_filters = MinutesExtension.minutes_filters
        filters = TextFilter.descendants - minutes_filters
        options_for_select([[t('select.none'), '']] + filters.map { |s| s.filter_name }.sort, selected)
      end
      alias_method_chain :filter_options_for_select, :minutes_restrictions
    end
    
    Page.class_eval do      
      def minutes?
        self.is_a?(Minutes::Instance)
      end

#      include MinutesTags
    end
    
    Admin::NodeHelper.module_eval do
      def render_node_with_minutes(page, locals = {})
        unless page.minutes?
          render_node_without_minutes(page, locals)
        end
      end
      alias_method_chain :render_node, :minutes
    end
    
    SiteController.class_eval do
      def self.minutes_cache_timeout
        @minutes_cache_timeout ||= 365.days
      end
      def self.minutes_cache_timeout=(val)
        @minutes_cache_timeout = val
      end
      
      def set_cache_control_with_minutes
        if @page.minutes?
          expires_in self.class.minutes_cache_timeout, :public => true, :private => false
        else
          set_cache_control_without_minutes
        end
      end
      alias_method_chain :set_cache_control, :minutes
    end
    
  end
end
