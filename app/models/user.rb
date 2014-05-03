class User < ActiveRecord::Base
  authenticates_with_sorcery!

  # VALIDATIONS
  validates :email, presence: true

  # ASSOCIATIONS
  has_many :feeds, through: :subscriptions
  has_many :subscriptions

end