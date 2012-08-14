require File.expand_path("../../spec_helper", __FILE__)

describe "Minutes Tags" do
  dataset :minutes

  let(:page){ pages(:home) }
  let(:minutes_page){ pages(:site_minutes)}

  describe "<r:minutes>" do
    before do
      Radiant::Config['minutes.use_cache_param?'] = true
    end
    subject { page }
    it { should render(%{<r:minutes />}).with_error("`minutes' tag must contain a `date' attribute.") }
    it { should render(%{<r:minutes date="March 5, 2012" />}).with_error("`minutes' tag must contain a `type' attribute.") }
    it { should render(%{<r:minutes date="March 5, 2012" type="ec" />}).with_error('No minutes found for March 5, 2012') }
    it { should render(%{<r:minutes date="March 6, 2012" type="ec" />}).as('EC Minutes') }
    it { should render(%{<r:minutes date="March 6, 2012" type="ec" as="url" />}).as('/minutes/2012/03/06/ec?#{minutes_page.digest}') }
    it { should render(%{<r:minutes date="March 6, 2012" type="ec" as="link" />}).as(%{<a href="#{minutes_page.path}">#{minutes_page.date_slug}</a>}) }
    it { should render(%{<r:minutes date="March 6, 2012" type="ec" as="link" something="custom" />}).as(%{<a href="#{minutes_page.path}" something="custom">#{minutes_page.date_slug}</a>}) }
    it { should render(%{<r:minutes date="March 6, 2012" type="ec" as="inline" />}).as('EC Minutes') }
  end
end

