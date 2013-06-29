class Spree::CommentsController < Spree::StoreController
  before_filter :load_post, only: [:new, :create]

  def new
    @comment = Spree::Comment.new
  end

  def create
    @comment = @post.comments.build(params[:comment])
    @comment.user = spree_current_user
    if @comment.save
      flash[:notice] = Spree.t(:created_successfully_pending_approval)
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  private

  def load_post
    @post = Spree::Post.find_by_permalink(params[:post_id])
  end
end
