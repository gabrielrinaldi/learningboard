class AdminUser < ActiveRecord::Base
  has_many :invitations, :class_name => self.to_s, :as => :invited_by

  devise  :database_authenticatable,
          :recoverable,
          :trackable,
          :confirmable,
          :lockable,
          :rememberable,
          :timeoutable,
          :validatable,
          :uid,
          :account_expireable,
          :invitable

  include RoleModel

  # declare the valid roles -- do not change the order if you add more
  # roles later, always append them at the end!
  roles :developer, :admin

  def self.secure_roles
    secure_roles = Array.new self.valid_roles
    secure_roles.delete :developer

    secure_roles
  end
end
