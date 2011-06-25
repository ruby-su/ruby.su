require 'spec_helper'

describe 'shared/error_404.html.erb' do
  it "renders '404 Not found'" do
    render

    rendered.should contain("404 Not found")
  end
end
