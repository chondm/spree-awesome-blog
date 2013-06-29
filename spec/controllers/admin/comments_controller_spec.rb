require 'spec_helper'

describe Spree::Admin::CommentsController do
  stub_authorization!

  before { stub spree_current_user: create(:user) }

  context "" do
  end
end
