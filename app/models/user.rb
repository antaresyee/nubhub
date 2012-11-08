class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, 
                  :email, 
                  :password, 
                  :password_confirmation, 
                  :remember_me

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@duke\.edu\z/

  validates :name, presence: true
  validates :email, presence: true, 
  	format: { with: VALID_EMAIL_REGEX } 
  	
  has_many :notes, dependent: :destroy

end
