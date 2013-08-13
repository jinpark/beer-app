class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :location, :login, :favbeers_attributes, :beer_ids
  # attr_accessible :title, :body
  attr_accessor :login

  validates :username, :uniqueness => {:case_sensitive => false}
  validates :username, :password, :email, :location, presence: true

  has_many :favbeers
  has_many :savedbeers
  has_many :friendships
  has_many :friends, through: :friendships

  accepts_nested_attributes_for :favbeers

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end


end

