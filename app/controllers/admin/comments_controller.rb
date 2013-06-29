class Spree::Admin::CommentsController < Spree::Admin::ResourceController
  helper 'spree/base'

  def update
    respond_to do |format|
      format.html { redirect_to admin_comments_path }
    end
  end

  def create
    respond_to do |format|
      format.html { redirect_to edit_admin_comments_path(@comments) }
    end
  end

  private

  def collection
    return @collection if @collection

    @collection = Spree::Comment
    if params[:post_id]
      @post = Spree::Post.find_by_permalink(params[:post_id])
      @collection = @post.comments
    end

    @collection = @collection.paginate(page: params[:page], per_page: 10)
  end

  def object
    return @object if @object

    @object = Spree::Comment.find_by_id(params[:id])
    @object.approved = params[:comment][:approved] if params[:comment] && params[:comment].key?(:approved)
    @object
  end
end
