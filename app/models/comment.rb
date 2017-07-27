class Comment < ActiveRecord::Base
  include ActiveModel::Serializers::JSON

  belongs_to :post
  attr_accessible :body, :tel, :rates, :show_comment, :full_name
  attr_accessor :full_name

  validates :tel, presence: true, length: { minimum: 9 }

  scope :saved_comments,  where('id NOT ?', nil)


  # setter
  def full_name=(val)
    self.name = val.split(' ')[0]
    self.last_name = val.split(' ')[1]
  end

  # getter
  def full_name
    current_full_name = ""
     if name.present?
       current_full_name = "#{name} #{last_name}"
     end
     current_full_name
  end

  def show_comment?
    current_show_comment = ""
    if show_comment == TRUE
      current_show_comment = "Yes"
    else
      current_show_comment = "No"
    end
    current_show_comment
  end


end
