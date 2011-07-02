require 'spec_helper'

describe Article do
  describe "3rd party features" do
    describe "- acts_as_commentable_with_threading" do
      it "responds to :comment_threads call" do
        Article.new.should respond_to(:comment_threads)
      end
    end
  end
end
