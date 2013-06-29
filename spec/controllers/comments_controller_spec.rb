require 'spec_helper'

describe Spree::CommentsController do
  let(:user) { create(:user, persistence_token: "foo", :has_role? => false, email: "user@example.com") }

  before do
    @post = mock_model(Spree::Post, to_param: "test-post")
    Spree::Post.should_receive(:find_by_permalink).with("test-post").and_return(@post)
  end

  context "#new" do
    it "is success" do
      spree_get :new, post_id: "test-post"
      response.should be_success
    end

    it "assign comment" do
      Comment.should_receive(:new).and_return(:comment)
      spree_get :new, post_id: "test-post"
      assigns(:comment).should eql(:comment)
    end

    it "assign post" do
      spree_get :new, post_id: "test-post"
      assigns(:post).should eql(@post)
    end
  end

  describe "#create" do
    before do
      @comments, @comment = mock(:comments), mock_model(Spree::Comment)

      @post.should_receive(:comments).and_return(@comments)
      @comments.should_receive(:build).with("name" => "test").and_return(@comment)
    end

    describe "valid data" do
      before do
        @comment.should_receive(:save).and_return(true)
      end

      describe "not logged in" do
        before do
          controller.stub(spree_current_user: nil)
          @comment.should_receive(:user=).with(nil)
        end

        it "redirect to post" do
          spree_post :create, post_id: "test-post", comment: { name: "test" }
          response.should redirect_to(post_path("test-post"))
        end

        it "set flash message" do
          spree_post :create, post_id: "test-post", comment: { name: "test" }
          flash[:notice].should eql(Spree.t(:created_successfully_pending_approval))
        end
      end

      it "use user id when logged in" do
        @comment.should_receive(:user=).with(user)
        controller.stub(spree_current_user: user)
        spree_post :create, post_id: "test-post", comment: { name: "test" }
      end
    end

    describe "invalid data" do
      before do
        controller.stub(spree_current_user: nil)
        @comment.should_receive(:user=).with(nil)
        @comment.should_receive(:save).and_return(false)
      end

      it "render new" do
        spree_post :create, post_id: "test-post", comment: { name: "test" }
        response.should render_template("new")
      end

      it "assign post" do
        spree_post :create, post_id: "test-post", comment: { name: "test" }
        assigns(:post).should eql(@post)
      end

      it "assign comment" do
        spree_post :create, post_id: "test-post", comment: { name: "test" }
        assigns(:comment).should eql(@comment)
      end
    end
  end
end
