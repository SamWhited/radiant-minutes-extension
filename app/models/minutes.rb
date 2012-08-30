require 'digest/md5'
require 'securerandom'
module Minutes
  module InvalidHomePage; end
  module Instance
    def self.included(base)
      base.class_eval {
        before_validation :set_parent
        before_validation :set_slug
        before_validation :set_breadcrumb
        class_inheritable_accessor :minutes_root

        def self.default_page_parts
          PagePart.new(:name => 'body')
        end

        def self.create_from_upload!(file)
          @minutes = self.new_with_defaults
          @minutes.upload = file
          @minutes.save!
          @minutes
        end
      }
    end

    def cache?
      true
    end

    # We want to be able to iterate over minutes
    def virtual?
      false
    end
  
    def find_by_path(path, live = true, clean = true)
      path = clean_path(path) if clean
      my_path = self.path
      if (my_path == path) && (not live or published?)
        self
      elsif (path =~ /^#{Regexp.quote(my_path)}([^\/]*)/)
        slug_child = children.find_by_slug($1)
        if slug_child
          return slug_child
        else
          super
        end
      end
    end
        
    def upload=(file)
      case
      when file.blank?
        self.errors.add(:upload, 'not given. Please upload a file.')
      when !file.kind_of?(ActionController::UploadedFile)
        self.errors.add(:upload, 'is an unusable format.')
      else
        self.slug = file.original_filename.to_slug().gsub(/-txt$/,'.txt').gsub(/-md$/,'.md').gsub(/-markdown$/,'.markdown').gsub(/-xml$/,'.xml').gsub(/-asc$/,'.asc')
        self.part('Other').content = file.read
      end
    end

    def digest
      @generated_digest ||= digest!
    end

    def digest!
      Digest::MD5.hexdigest(self.render)
    end

    def child_path(child)
      clean_path(path + '/' + child.slug + child.cache_marker)
    end

    def cache_marker
      Radiant::Config['minutes.use_cache_param?'] ? "?#{digest}" : ''
    end
    
    private

    def clean_path(path)
      "/#{ path.to_s.strip }".gsub(%r{//+}, '/')
    end

    def set_breadcrumb
      self.breadcrumb = self.title
    end

    def set_slug
      self.slug = SecureRandom.uuid
    end

    def set_parent
      self.parent_id = Page.find_by_path(MinutesExtension.minutes_path).try(:id)
    end
  end
end
