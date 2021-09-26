class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user
  end

  def update?
    user&.admin? || user&.id == record.author_id
  end

  def destroy?
    user&.admin? || user&.id == record.author_id
  end

  def vote?
    user&.admin? || user && user.id != record.author_id
  end
end
