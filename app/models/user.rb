class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :movies
  has_many :favorites, dependent: :destroy
  has_many :fav_movies, through: :favorites, source: :movie
  
  def favorite(movie)
    favorites.find_or_create_by(movie_id: movie.id)
  end
  
  def unfavorite(movie)
    favorite = favorites.find_by(movie_id: movie.id)
    favorite.destroy if favorites
  end
  
  def favoriting?(movie)
    self.fav_movies.include?(movie)
  end
end
