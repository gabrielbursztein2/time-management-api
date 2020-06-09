class UserPolicy < ApplicationPolicy
  def index?
    user.user_manager? || user.admin_user?
  end

  def create?
    user.user_manager? || user.admin_user?
  end

  def update?
    user.user_manager? || user.admin_user?
  end

  def destroy?
    user.id != record.id && (user.user_manager? || user.admin_user?)
  end
end
