require 'spec_helper'

describe 'articles/show.html.erb' do
  include Webrat::HaveTagMatcher

  before do
    assign(:article,
      stub_model(Article, 
        :title => "hackathon #2", 
        :body => "We've added Twitter!", 
        :published_at => Time.now, 
        :tags => []
      )
    )
  end

  it "renders article title" do
    render
    rendered.should have_tag("h1", :content => 'hackathon #2')
  end

  it "renders article body" do
    render
    rendered.should have_tag("p", :content => "We’ve added Twitter!")
  end

  it "renders comments" do
    render 
    pending
  end
end
