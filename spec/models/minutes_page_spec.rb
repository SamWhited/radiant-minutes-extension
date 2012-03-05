require File.dirname(__FILE__) + '/../spec_helper'

describe MinutesPage do
  before(:each) do
    @minutes_page = MinutesPage.new
  end

  it "should be valid" do
    @minutes_page.should be_valid
  end
end
