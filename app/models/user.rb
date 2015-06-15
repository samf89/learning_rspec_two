class User < ActiveRecord::Base
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true,
               uniqueness: true
  validates :username, presence: true,
               uniqueness: true
end
