class LinkPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def destroy?
    user&.admin? || user&.id == record.linkable.author_id
  end
end
