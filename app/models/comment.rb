class Comment < ActiveRecord::Base
  belongs_to :post
  attr_accessible :body, :tel, :rate, :showCom, :fullname
  attr_accessor :fullname

  validates :tel, presence: true, length: { minimum: 9 }

  scope :saved_comments,  where('id NOT ?', nil)


# setter
def fullname=(val)
  self.name = val.split(' ')[0]
  self.lastname = val.split(' ')[1]
end

# getter
def fullname
  fname = ""
   if name.present?
     fname = name + ' '
     fname += lastname
   end
   fname
end

end
