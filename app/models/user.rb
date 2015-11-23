class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    has_secure_password
  validates :profile_name, presence: true, length: { maximum: 100 }　, on: :updaate
  validates :area, presence: true, length: { maximum: 50 }　, on: :updaate
  validates :age, numericality: { only_integer: true , greater_than_or_equal_to: 0 , less_than_or_equal_to: 200 } , presence: true　, on: :updaate

end
