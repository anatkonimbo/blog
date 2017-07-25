class Post < ActiveRecord::Base
  include ActiveModel::Serializers::JSON

  has_many :comments, dependent: :destroy
  attr_accessible :body, :title, :amount, :avr_rates, :tags, :photo, :email

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true
  validate :calculate_number_of_words


  has_attached_file :photo, :styles => { :small => "150x150>", :medium => "300x300>", :large => "520x520>"},
                     :url  => "/assets/posts/:id/:style/:basename.:extension",
                     :path => ":rails_root/public/assets/posts/:id/:style/:basename.:extension"

  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  def calculate_number_of_words
    total_value = 30
    non_html = ActionView::Base.full_sanitizer.sanitize(body.to_s)
    if non_html.to_s.split(' ').size > total_value
      errors.add(:discount, "can't be more then 30 words")
    end
  end

  def average_rate
      arr_rate= comments.collect(&:rates).compact
      self.avr_rates = (arr_rate.sum / arr_rate.size.to_f).round(2)
  end

  def as_json(options={})
    super(:only => [:title,:body,:email,:avr_rates],
          :include => {
            :comments => {:only => [:body, :name, :last_name]}
          }
    )
  end

end
