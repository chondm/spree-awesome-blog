class Spree::PostsController < Spree::StoreController
  before_filter :load_tag_cloud, :load_dates

  def index
    @tag   = params[:tag]
    @year  = params[:year]
    @month = params[:month]
    @day   = params[:day]

    @posts = @year ? Spree::Post.by_date(@year.to_i, @month.try(:to_i), @day.try(:to_i)) : Spree::Post
    @posts = @posts.published
    @posts = @posts.tagged_with(@tag) if @tag

    respond_to do |format|
      format.html { @posts = @posts.paginate(page: params[:page], per_page: 10) }
      format.rss
    end
  end

  def show
    @post = Spree::Post.published.find_by_permalink(params[:id])
  end

  protected

  def load_tag_cloud
    @tags = Spree::Post.tag_counts_on(:tags)
  end

  def load_dates
    @dates = Spree::Post.group_dates
  end
end
