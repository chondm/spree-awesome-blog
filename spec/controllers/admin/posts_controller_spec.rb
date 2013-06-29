require 'spec_helper'

describe Spree::Admin::PostsController do
  stub_authorization!

  before { stub spree_current_user: create(:user) }

  context "" do
  end
end
