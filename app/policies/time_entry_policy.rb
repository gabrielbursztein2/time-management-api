class TimeEntryPolicy < ApplicationPolicy
  def index?
    user.admin_user?
  end

  def create?
    user.admin_user?
  end

  def update?
    user.admin_user?
  end

  def destroy?
    user.admin_user?
  end
end
