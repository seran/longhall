class Comment < ApplicationRecord
	belongs_to :issue
	belongs_to :user

	validates :message, presence: true
end
