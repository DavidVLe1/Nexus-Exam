class ExamPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end

  end

  attr_reader :user, :exam

  def initialize(user, exam)
    @user = user
    @exam = exam
  end
  def index?
    user.present? 
  end

  def show?
    user.present? 
  end


  def start_practice?
    user.present? # Allow any authenticated user to start a practice exam
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
