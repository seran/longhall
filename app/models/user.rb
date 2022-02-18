class User < ApplicationRecord
  enum role: [:admin, :user, :lead]
  after_initialize :set_default_role, :if => :new_record?
  # before_create :set_default_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
  :recoverable, :rememberable, :validatable


  def destroy
    update_attributes(active: false) unless active
  end


  def active_for_authentication?
    super && active
  end

  private
  def set_default_role
    self.role ||= :user
    self.uuid = SecureRandom.uuid
  end
end
