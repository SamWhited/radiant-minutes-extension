class Admin::MinutesController < Admin::MinutesResourceController
  model_class MinutesPage
  only_allow_access_to :index, :new, :edit, :create, :update, :destroy, :upload,
    :when => [:designer, :admin],
    :denied_url => { :controller => 'pages', :action => 'index' },
    :denied_message => 'You must be a designer or administrator to add minutes.'

  private

  def edit_model_path
    edit_admin_minutes_path(params[:id])
  end

end
