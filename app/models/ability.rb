class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new # for guest
    @user.roles.each { |role| send(role) }

    if @user.roles.size == 0
      cannot :manage, :all # for guest without roles
    end
  end

  # Define abilities for the passed in user here. For example:
  #
  #   user ||= User.new # guest user (not logged in)
  #   if user.admin?
  #     can :manage, :all
  #   else
  #     can :read, :all
  #   end
  #
  # The first argument to `can` is the action you are giving the user
  # permission to do.
  # If you pass :manage it will apply to every action. Other common actions
  # here are :read, :create, :update and :destroy.
  #
  # The second argument is the resource the user can perform the action on.
  # If you pass :all it will apply to every resource. Otherwise pass a Ruby
  # class of the resource.
  #
  # The third argument is an optional hash of conditions to further filter the
  # objects.
  # For example, here the user can only update published articles.
  #
  #   can :update, Article, :published => true
  #
  # See the wiki for details:
  # https://github.com/ryanb/cancan/wiki/Defining-Abilities

  def admin
    can :read, ActiveAdmin::Page, :name => 'Dashboard'

    roles_mask = AdminUser.mask_for AdminUser.secure_roles
    can :manage, AdminUser, [ "roles_mask & ? != 0",  roles_mask] do |admin_user|
      admin_user.roles_mask & roles_mask != 0
    end
  end

  def developer
    admin

    can :manage, :all
  end
end
