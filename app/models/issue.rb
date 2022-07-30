class Issue < ApplicationRecord
	audited
	enum status: [:open, :closed, :ongoing, :cancelled]
	enum severity: [:low, :medium, :high, :critical]

	belongs_to :scope
	belongs_to :user

	before_create :set_defaults

	validates :title, presence: true
	validates :severity, presence: true
	validates :description, presence: true

	has_many :comments
	has_many :tag
	has_many_attached :files

	scope :filter_by_status, -> (status) { where status: status }
	scope :filter_by_severity, -> (severity) { where severity: severity }
	scope :filter_by_title, -> (title) { where("title like ?", "%#{title}%") }
	scope :filter_by_scope, -> (scope) { joins(:scope).where('scopes.uuid = ?', scope) }

	def sequence_number
		return nil unless self.persisted?
		id_with_zeros = "%04d" % self.id
		"I#{self.created_at.year}#{self.created_at.month}#{self.created_at.day}#{id_with_zeros}"
	end

	def notify_slack
      SlackNotifier::CLIENT.ping "🎴 New report: #{self.title} \n https://bounty.pickme.lk/report/show/#{self.uuid}"
    end

	private
	def set_defaults
		self.status ||= :open
	    self.uuid = SecureRandom.uuid
	end

end
