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
end
