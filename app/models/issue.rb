class Issue < ApplicationRecord
	belongs_to :scope

	before_create :set_defaults

	has_many :comments
	has_many :tag

	private
	  def set_defaults
	    self.uuid = SecureRandom.uuid
	  end
end
