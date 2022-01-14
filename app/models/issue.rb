class Issue < ApplicationRecord
	enum status: [:open, :closed, :ongoing, :cancelled]
	enum severity: [:low, :medium, :high, :critical]

	belongs_to :scope
	belongs_to :user

	before_create :set_defaults

	has_many :comments
	has_many :tag

	scope :filter_by_status, -> (status) { where status: status }
	scope :filter_by_severity, -> (severity) { where severity: severity }
	scope :filter_by_title, -> (title) { where("title like ?", "%#{title}%") }
	scope :filter_by_scope, -> (scope) { where scope_id: scope }

	private
	  def set_defaults
			self.status ||= :open
	    self.uuid = SecureRandom.uuid
	  end
end
