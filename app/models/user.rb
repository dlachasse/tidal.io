class User < ActiveRecord::Base
  authenticates_with_sorcery!

  # VALIDATIONS
  validates :email, presence: true

  # ASSOCIATIONS
  has_many :subscriptions

end