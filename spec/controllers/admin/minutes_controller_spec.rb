require File.expand_path("../../../spec_helper", __FILE__)

describe Admin::MinutesController do
  dataset :users, :home_page, :minutes

  #Delete these examples and add some real ones
  it "should use Admin::MinutesController" do
    controller.should be_an_instance_of(Admin::MinutesController)
  end


  it "GET 'upload' should be successful" do
    get 'upload'
    response.should be_success
  end

  it "GET 'remove' should be successful" do
    get 'remove'
    response.should be_success
  end
end
