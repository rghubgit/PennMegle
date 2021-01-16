# Schema: 
# username: string
# name: string
# email: string
# password_hash: string
# bio: text

class User < ApplicationRecord

  # Validations
  validates :username, presence:true 
  validates :name, presence:true   
  validates :username, uniqueness:true
  validates :email, uniqueness:true
  validate :penn_email

  # Custom validatons
  def penn_email
    unless email.include? 'upenn.edu'      
      errors.add(:email, 'is not a Penn email') 
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         

  has_many :registrations, dependent: :destroy
  has_many :channels, through: :registrations

  has_one_attached :profile_picture
end
