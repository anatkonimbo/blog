class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  attr_accessible :body, :title, :amount

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true


  def calcu
    self.amount = self.body.split(' ').size
  end
end
