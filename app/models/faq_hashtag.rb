class FaqHashtag < ActiveRecord::Base
  validates_presence_of :faq_id, :hashtag_id

  belongs_to :faq_id
  belongs_to :hashtag
end
