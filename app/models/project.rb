class Project < ApplicationRecord
	enum status: [:open, :completed, :cancelled]

	before_create :set_defaults

	has_many :scope
	belongs_to :user

	validates :title, presence: true

	
	private
	  def set_defaults
	    self.status ||= :open
	    self.uuid = SecureRandom.uuid
	  end
end
