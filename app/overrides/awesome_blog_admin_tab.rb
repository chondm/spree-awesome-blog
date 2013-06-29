Deface::Override.new(virtual_path:  "spree/layouts/admin",
                     name:          "awesome_blog_admin_tab",
                     insert_bottom: "[data-hook='admin_tabs']",
                     text:          "<%= tab(:posts, icon: 'icon-file', label: :blog) %>",
                     disabled:      false)
