class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  attr_accessible :body, :title

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true
end
