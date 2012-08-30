class Admin::MinutesResourceController < Admin::ResourceController
  paginate_models
  # only_allow_access_to must be set
  
  prepend_before_filter :find_root
  
  def upload
    if params[:upload].blank?  # necessary params are missing
      render :text => '', :status => :bad_request
    else
      @minutes = model_class.create_from_upload!(params[:upload][:upload])
      response_for :create
    end
  end
  
  def new
    self.model = model_class.new_with_defaults
    response_for :new
  end
  
  def create
    model.update_attributes!(params[model_symbol])
    response_for :create
  end
  
  private
  
  def find_root
    unless Page.find_by_path(MinutesExtension.minutes_path)
      flash[:error] = t('minutes.root_required', :model => humanized_model_name, :root => MinutesExtension.minutes_path)
      redirect_to welcome_path and return false
    end
  end
end
