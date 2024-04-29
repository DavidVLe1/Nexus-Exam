class PracticeExamPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def practice?
    user.present? # Allow any authenticated user to access the practice action
  end
end
