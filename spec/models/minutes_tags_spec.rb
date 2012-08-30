require File.expand_path("../../spec_helper", __FILE__)

describe "Minutes Tags" do
  dataset :minutes

  let(:page){ pages(:home) }
  let(:minutes_page){ pages(:general)}

  describe "<r:if_minutes>" do
    it "should render the contained block if the page is a MinutesPage" do
      minutes_page.should render('<r:if_minutes>true</r:if_minutes>').as('true')
    end

    it "should not render the contained block if the page is not a MinutesPage" do
      page.should render('<r:if_minutes>true</r:if_minutes>').as('')
    end
  end


  describe "<r:unless_minutes>" do
    it "should not render the contained block if the page is a MinutesPage" do
      minutes_page.should render('<r:unless_minutes>true</r:unless_minutes>').as('')
    end

    it "should render the contained block if the page is not a MinutesPage" do
      page.should render('<r:unless_minutes>true</r:unless_minutes>').as('true')
    end
  end
end

