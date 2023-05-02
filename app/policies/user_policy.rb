class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || user == record
  end

  def destroy?
    user != record && create?
  end

  def permitted_attributes
    if user&.admin?
      %i[name role avatar password password_confirmation]
    else
      %i[avatar password password_confirmation]
    end
  end
end
