class FilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def destroy?
    user&.admin? || user&.id == record.record.author_id
  end
end
