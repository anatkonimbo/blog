class Post < ActiveRecord::Base
  include ActiveModel::Serializers::JSON

  has_many :comments, dependent: :destroy
  attr_accessible :body, :title, :amount, :avrRate, :tags, :photo, :email

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true
  validate :calcu


  has_attached_file :photo, :styles => { :small => "150x150>", :medium => "300x300>", :large => "520x520>"},
                     :url  => "/assets/posts/:id/:style/:basename.:extension",
                     :path => ":rails_root/public/assets/posts/:id/:style/:basename.:extension"

  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  def calcu
    total_value = 30
    non_html = ActionView::Base.full_sanitizer.sanitize(body)
    if non_html.split(' ').size > total_value
      errors.add(:discount, "can't be more then 30 words")
    end
  end

  def average_rate
      arr_rate= self.comments.collect(&:rate).compact
      self.avrRate = (arr_rate.sum / arr_rate.size.to_f).round(2)
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end
