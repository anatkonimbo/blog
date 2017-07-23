class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  attr_accessible :body, :title, :amount, :avrRate, :tags

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true


  def calcu
    self.amount = self.body.split(' ').size
  end

  def average_rate
      arr_rate= Comment.all.collect(&:rate).compact
      self.avrRate = (arr_rate.sum / arr_rate.size.to_f).round(2)
  end
end
