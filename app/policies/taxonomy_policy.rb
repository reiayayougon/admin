class TaxonomyPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.admin? || user.editor?
  end

  def update?
    true
  end

  def destroy?
    true
  end
end
