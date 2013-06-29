class Spree::Comment < ActiveRecord::Base
  belongs_to :post, class_name: 'Spree::Post', foreign_key: 'post_id'
  belongs_to :user, class_name: 'Spree::User', foreign_key: 'user_id'

  before_save :check_approved
  before_save :check_user, if: :user

  attr_accessible :name, :email, :message, :url

  validates :message, :post_id, :name, presence: true
  validates :email, unless: :user, presence: true
  validates_length_of :message, maximum: 1000
  validates_format_of :email, with: /\b[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i
  validates_format_of :url, with: /http\:\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(\/\S*)?/, allow_blank: true

  default_scope { order('approved, approved_on DESC') }
  scope :approved, -> { where approved: true }

  def status
    approved ? 'approved' : 'not approved'
  end

  private

  def check_user
    self.email = user.email
  end

  def check_approved
    return unless approved_changed?
    self.approved_on = approved ? Date.today : nil
  end
end
