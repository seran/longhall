class Issue < ApplicationRecord
	enum status: [:open, :closed, :ongoing, :cancelled]
	enum severity: [:low, :medium, :high, :critical]

	belongs_to :scope

	before_create :set_defaults

	has_many :comments
	has_many :tag

	private
	  def set_defaults
			self.status ||= :open
	    self.uuid = SecureRandom.uuid
	  end
end
