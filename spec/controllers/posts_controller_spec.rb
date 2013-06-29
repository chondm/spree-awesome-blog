require 'spec_helper'

describe Spree::PostsController do
  context "#show" do
    it "is success" do
      spree_get :show, id: "test"
      response.should be_success
    end

    it "assign post" do
      published = mock(:published)
      Spree::Post.should_receive(:published).and_return(published)
      published.should_receive(:find_by_permalink).with("test").and_return(:post)
      spree_get :show, id: "test"
      assigns(:post).should eql(:post)
    end

    it "assign tags" do
      Spree::Post.should_receive(:tag_counts_on).with(:tags).and_return(:tags)
      spree_get :show, id: "test"
      assigns(:tags).should eql(:tags)
    end

    it "assign dates" do
      Spree::Post.should_receive(:group_dates).and_return(:dates)
      spree_get :show, id: "test"
      assigns(:dates).should eql(:dates)
    end
  end

  context "#index" do
    it "is success" do
      spree_get :index
      response.should be_success
    end

    it "assign posts" do
      published = mock(:published)
      Spree::Post.should_receive(:published).and_return(published)
      published.should_receive(:paginate).with(page: 2, per_page: 10).and_return(:posts)
      spree_get :index, page: 2
      assigns(:posts).should eql(:posts)
    end

    it "assign tags" do
      Spree::Post.should_receive(:tag_counts_on).with(:tags).and_return(:tags)
      spree_get :index
      assigns(:tags).should eql(:tags)
    end

    it "assign dates" do
      Spree::Post.should_receive(:group_dates).and_return(:dates)
      spree_get :index
      assigns(:dates).should eql(:dates)
    end
  end

  context "#index.rss" do
    it "is success" do
      spree_get :index, format: :rss
      response.should be_success
    end

    it "assign posts" do
      Post.should_receive(:published).and_return(:posts)
      spree_get :index, format: :rss
      assigns(:posts).should eql(:posts)
    end
  end

  context "#index with tags" do
    it "is success" do
      spree_get :index, tag: "awesome"
      response.should be_success
    end

    it "assign posts" do
      published, tagged = mock(:published), mock(:tagged)
      Spree::Post.should_receive(:published).and_return(published)
      published.should_receive(:tagged_with).with("awesome").and_return(tagged)
      tagged.should_receive(:paginate).with(page: 2, per_page: 10).and_return(:posts)
      spree_get :index, tag: "awesome", page: 2
      assigns(:posts).should eql(:posts)
      assigns(:tag).should eql("awesome")
    end
  end

  context "#index with date" do
    it "is success" do
      spree_get :index, year: 2010, month: 2, day: 1
      response.should be_success
    end

    it "assign posts" do
      published, by_date = mock(:published), mock(:by_date)
      Spree::Post.should_receive(:by_date).with(2010,2,1).and_return(by_date)
      by_date.should_receive(:published).and_return(published)
      published.should_receive(:paginate).with(page: 2, per_page: 10).and_return(:posts)
      spree_get :index, year: 2010, month: 2, day: 1, page: 2
      assigns(:posts).should eql(:posts)
      assigns(:year).should eql(2010)
      assigns(:month).should eql(2)
      assigns(:day).should eql(1)
    end
  end
end
