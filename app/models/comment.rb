class Comment < ActiveRecord::Base
  belongs_to :post
  attr_accessible :body, :name, :lastname, :tel
  attr_accessor :fullname

  validates :tel, presence: true, length: { minimum: 9 }

  scope :saved_comments,  where('id NOT ?', nil)

  def full_name
    fname = name + ' '
    fname += lastname
    fname
  end

end
