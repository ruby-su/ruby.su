require 'spec_helper'

describe TagsController do
  context 'show' do
    before do
      @tag = mock_model(ActsAsTaggableOn::Tag, :name => 'ruby')
      ActsAsTaggableOn::Tag.stub!(:find_by_permalink).and_return(@tag)

      @articles = mock('articles')
      Article.stub!(:tagged_with).and_return(@articles)
    end
   
    it "finds tag by permalink" do
      ActsAsTaggableOn::Tag.should_receive(:find_by_permalink).with('ruby').and_return(@tag)
      get :show, :id => 'ruby'
    end

    it "assigns found tag to @tag variable" do
      get :show, :id => 'ruby'
      assigns[:tag].should == @tag
    end

    context "(tag found)" do
      it "gets tag name" do
        @tag.should_receive(:name).and_return('ruby')
        get :show, :id => 'ruby'
      end
 
      it "finds articles tagged with tag name" do
        Article.should_receive(:tagged_with).with('ruby')
        get :show, :id => 'ruby'
      end
     
      it "assigns found articles to @articles variable" do
        get :show, :id => 'ruby'
        #TODO: find out correct way to check assigns for rspec 2.x
        assigns[:articles].should == @articles
      end
      
      it "returns http status 200 (everything is good)" do
        get :show, :id => 'ruby'
        #TODO: find out correct way to check response code for rspec 2.x
        response.code.should == "200"
      end
    end
    
    context "(tag not found)" do
      before do
        ActsAsTaggableOn::Tag.stub!(:find_by_permalink).and_return(nil)
      end

      it "returns 404 status code if tag not found" do
        get :show, :id => 'php'
        response.code.should == "404"
      end
       
      it "redirects to 404.html" do
        get :show, :id => 'php'
        response.should render_template('shared/error_404')
      end
    end
    
  end
end
