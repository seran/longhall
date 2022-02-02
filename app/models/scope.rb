class Scope < ApplicationRecord

	belongs_to :project
	belongs_to :user
	has_many :issue

	before_create :set_defaults

	validates :title, presence: true
	validates :version, presence: true
	
	private
	  def set_defaults
	    self.uuid = SecureRandom.uuid
	  end
end
