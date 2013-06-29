module Spree::PostsHelper
  include ActsAsTaggableOn::TagsHelper

  def make_title(tag=nil, year=nil, month=nil, day=nil)
    if tag
      Spree.t(:posts_tagged) % tag.humanize.capitalize
    elsif year
      if day
        Spree.t(:posts_day) % Date.new(year.to_i, month.to_i, day.to_i).strftime("%A, %d %B, %Y")
      elsif month
        Spree.t(:posts_month) % Date.new(year.to_i, month.to_i, 1).strftime("%B %Y")
      else
        Spree.t(:posts_year) % year.to_s
      end
    else
      Spree::Config.blog_title || Spree.t(:blog)
    end
  end
end
