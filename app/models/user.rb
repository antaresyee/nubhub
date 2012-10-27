class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@duke\.edu\z/

  validates :name, presence: true
  validates :email, presence: true, 
  	format: { with: VALID_EMAIL_REGEX }
end
