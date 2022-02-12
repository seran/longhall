class User < ApplicationRecord
  enum role: [:admin, :user, :lead]
  after_initialize :set_default_role, :if => :new_record?
  # before_create :set_default_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  private
  def set_default_role
    self.role ||= :user
  end
end
