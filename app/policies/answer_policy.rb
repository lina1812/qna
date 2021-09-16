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
    user&.id == record.author_id
  end

  def destroy?
    user&.id == record.author_id
  end

  def mark_as_best?
    user&.id == record.question.author_id
  end

  def vote?
    user && user.id != record.author_id
  end
end
