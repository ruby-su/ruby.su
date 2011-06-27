require 'spec_helper'

describe ArticlesController do
  context "(authenticated user)" do

    login_user

    describe :autocomplete_tag_name do
      it "returns 200 status code" do
#        pending "TODO: we can't make it work!! please help"
        xhr :get, :autocomplete_tag_name, { :term => 'hackathon' }
        response.code.should == '200'
      end
    end
  end

  context "(anonymous user)" do
    describe :autocomplete_tag_name do
      it "returns 401 status code" do
        xhr :get, :autocomplete_tag_name, :term => 'hackathon'
        response.code.should == '401'
      end
    end
  end
end
