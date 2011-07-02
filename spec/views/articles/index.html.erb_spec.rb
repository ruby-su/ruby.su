require 'spec_helper'

describe 'articles/index.html.erb' do
  include Webrat::HaveTagMatcher

  before do
    assign(:articles, [
      stub_model(Article, :title => "hackathon #2", :published_at => Time.now, :id => 2),
      stub_model(Article, :title => "hackathon #1", :published_at => Time.now, :id => 1)
    ])
  end

  it "renders links to articles" do
    render
    rendered.should have_tag("h2>a", :href => "/articles/2", :content => 'hackathon #2')
    rendered.should have_tag("h2>a", :href => "/articles/1", :content => 'hackathon #1')
  end
end
