class Blog < ApplicationRecord
	scope :published, -> { where('article_status = ?', "Published") }
	scope :drafts, -> { where('article_status = ?', "Drafts") }


end


