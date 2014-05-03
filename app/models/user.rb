class User < ActiveRecord::Base
  authenticates_with_sorcery!

  # VALIDATIONS
  validates :email, presence: true
  validates :password, presence: true, confirmation: true, length: { minimum: 5 }

  # ASSOCIATIONS
  has_many :feeds, through: :subscriptions
  has_many :subscriptions

end