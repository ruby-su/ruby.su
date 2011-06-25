class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.scoped
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find_by_permalink(params[:id])
    if @tag.nil?
      render 'shared/error_404', :status => '404'
    else
      @articles = Article.tagged_with(@tag.name)
    end
  end
end
