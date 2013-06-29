require 'spec_helper'

describe Spree::Comment do
  describe "when creating" do
    it "is valid" do
      create_comment.should have(0).errors
    end

    it "require post" do
      create_comment(post_id: nil).should have(1).error_on(:post_id)
    end

    context "with user" do
      let(:user) { create(:user, email: "test@123.org") }

      it "set email" do
        comment = create_comment(user: user)
        comment.email.should eql(user.email)
      end

      it "require name" do
        create_comment(user: user, name: nil).should have(1).error_on(:name)
      end
    end

    context "without user" do
      it "require name" do
        create_comment(name: nil).should have(1).error_on(:name)
      end
      it "require email" do
        create_comment(email: nil).should have(2).error_on(:email)
      end
      it "require valid email" do
        create_comment(email: "foo").should have(1).error_on(:email)
      end
    end

    it "require message" do
      create_comment(message: nil).should have(1).error_on(:message)
    end

    it "require valid url" do
      create_comment(url: "sdfssssd").should have(1).error_on(:url)
    end

    it "not allow message longer than 1000 characters" do
      create_comment(message: "a" * 1001).should have(1).error_on(:message)
    end
  end

  context "status" do
    it "is not approved for new comment" do
      create_comment.status.should eql("not approved")
    end

    it "approved after comment is approved" do
      create_comment(approved: true).status.should eql("approved")
    end
  end

  context "when approving" do
    it "save approved date" do
      comment = create_comment(approved: true)
      comment.approved_on.to_date.should eql(Date.today)
    end

    it "is not change approved date, unless approved is changed" do
      comment = create_comment(approved: true)
      comment.update_attribute(:approved_on, Date.new(2011,1,1))
      comment.approved_on.to_date.should eql(Date.new(2011,1,1))
    end

    it "remove approved date when unapproved" do
      comment = create_comment(approved: true)
      comment.update_attribute(:approved, false)
      comment.approved_on.should be_nil
    end

    it "find approved" do
      2.times { create_comment(approved: true) }
      Spree::Comment.approved.should have(2).comments
    end
  end

  def create_comment(options={})
    comment = Spree::Comment.new({ message: "nice post!", email: "test@home.com", url: "", name: "John" }.merge(options))
    comment.post_id = options.key?(:post_id) ? options[:post_id] : 1
    comment.user = options[:user] if options.key?(:user)
    comment.approved = options[:approved] if options.key?(:approved)
    comment.save
    comment
  end
end
