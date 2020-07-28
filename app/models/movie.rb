class Movie < ApplicationRecord
  belongs_to :user
  has_one_attached :picture

  validates :content, presence: true, length: { maximum: 255 }
  validates :rank , presence: true, :numericality => { :less_than_or_equal_to => 5 }
  
end
