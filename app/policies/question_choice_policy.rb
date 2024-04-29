class QuestionChoicePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    user.admin? # Only admins can create questions
  end

  def update?
    user.admin? # Only admins can update questions
  end

  def destroy?
    user.admin? # Only admins can delete questions
  end
end
