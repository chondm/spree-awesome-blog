class Spree::Admin::PostsController < Spree::Admin::ResourceController
  helper 'spree/base'

  def new_action
    respond_to do |format|
      format.html { render action: :new, layout: false }
    end
  end

  def update
    respond_to do |format|
      format.html { redirect_to admin_posts_path }
    end
  end

  def create
    respond_to do |format|
      format.html { redirect_to edit_admin_posts_path(@posts) }
    end
  end

  private

  def collection
    @collection ||= Spree::Post.paginate(page: params[:page], per_page: 10)
  end
end
