class Blog < ApplicationRecord
	scope :published, -> { where('article_status = ?', "Published") }
	scope :drafts, -> { where('article_status = ?', "Drafts") }
  validates :title, presence: true
  validates :description, presence: true
  validates :content, presence: true


end


