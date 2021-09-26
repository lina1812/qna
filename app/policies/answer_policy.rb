class AnswerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
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

  def mark_as_best?
    user&.admin? || user&.id == record.question.author_id
  end

  def vote?
    user&.admin? || user && user.id != record.author_id
  end
end
