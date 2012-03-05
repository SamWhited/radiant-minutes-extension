require File.dirname(__FILE__) + '/../../../spec_helper'

describe "/admin/minutes/upload" do
  before do
    render 'admin/minutes/upload'
  end
  
  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', 'Find me in app/views/admin/minutes/upload.rhtml')
  end
end
