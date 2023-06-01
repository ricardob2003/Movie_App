class User < ApplicationRecord
  has_secure_password
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie
  before_save :format_username 
  
validates :name, presence: true
validates :email, format: { with: /\S+@\S+/ }, 
                  uniqueness: { case_sensitive: false} 

validates :username, presence: true,
                    format: { with: /\A[A-Za-z0-9]+\z/ },
                    uniqueness: { case_sensitive: false }

scope :by_name, ->  { order(:name) }
scope :not_admins, -> { by_name.where(admin: false) }

def gravatar_id
  Digest::MD5::hexdigest(email.downcase)
end

def format_username 
  self.username = username.downcase
end 

def to_param
  username 
end 

end