class User < ActiveRecord::Base
  authenticates_with_sorcery!

  # VALIDATIONS
  validates :email, presence: true
  validates :password, presence: true, confirmation: true, length: { minimum: 5 }

  # ASSOCIATIONS
  has_many :feeds, through: :subscriptions
  has_many :subscriptions

  # CALLBACKS
  before_create :generate_api_key

  def generate_api_key
	  begin
	    self.api_key = SecureRandom.base64.tr('+/=', 'Qrt')
	  end while self.class.exists?(api_key: api_key)
	end

end