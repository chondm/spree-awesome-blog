Spree::BaseHelper.module_eval do
  def link_to_rss
    tag(:link,
      rel:   'alternate',
      type:  'application/rss+xml',
      title: Spree::Config.blog_title || "#{Spree::Config.site_name} Blog",
      href:  posts_path(format: :rss))
  end

  def markdown(text)
    sanitize(RDiscount.new(text).to_html)
  end
end
