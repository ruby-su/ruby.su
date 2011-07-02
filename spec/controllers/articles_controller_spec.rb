require 'spec_helper'

describe ArticlesController do
  context "(authenticated user)" do

    login_user

    let!(:article) { mock_model(Article) }

    describe :autocomplete_tag_name do
      it "returns 200 status code" do
        xhr :get, :autocomplete_tag_name, { :term => 'hackathon' }
        response.code.should == '200'
      end
    end

    describe :add_comment do
      let!(:comment) { mock_model(Comment, :save => true, :parent_id= => true) }

      before do
        Article.stub!(:find).and_return(article)
        Comment.stub!(:build_from).and_return(comment)
      end

      it "finds article by passed id" do
        Article.should_receive(:find).with(1)
        put :add_comment, :id => 1, :comment => 'ruby is c00l'
      end

      it "assigns found article to @article variable" do
        put :add_comment, :id => 1, :comment => 'ruby is c00l'
        assigns(:article).should == article
      end

      it "calls Comment.build_from" do
        Comment.should_receive(:build_from).with(article, user.id, 'ruby is c00l')
        put :add_comment, :id => 1, :comment => 'ruby is c00l'
      end

      it "assigns built comment object to @comment variablecalls Comment.build_from" do
        put :add_comment, :id => 1, :comment => 'ruby is c00l'
        assigns(:comment).should == comment
      end

      it "sets parent_id for built comment" do
        comment.should_receive(:parent_id=).with(30)
        put :add_comment, :id => 1, :comment => 'ruby is c00l', :parent_id => 30
      end

      it "saves @comment" do
        comment.should_receive(:save)
        put :add_comment, :id => 1, :comment => 'ruby is c00l'
      end

      it "redirects to articles#show" do
        put :add_comment, :id => 1, :comment => 'ruby is c00l'
        response.should redirect_to(article_path(article))
      end



      it "doesn't build comment if it can't find article by passed id"
    end
  end

  context "(anonymous user)" do
    describe :add_comment do
      it "redirects to 'Sign in' page" do
        put :add_comment, :id => 1, :comment => 'php is b3tt3r'
        response.should redirect_to(new_user_session_path)
      end
    end

    describe :autocomplete_tag_name do
      it "returns 401 status code" do
        xhr :get, :autocomplete_tag_name, :term => 'hackathon'
        response.code.should == '401'
      end
    end
  end
end
