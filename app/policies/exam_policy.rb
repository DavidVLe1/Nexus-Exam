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

  def new?
    user.present? # Any authenticated user can make new exam
  end

  def create?
    new? 
  end

  def edit?
    user.present? && exam.user == user # Allow only the owner to edit the exam
  end

  def update?
    edit?
  end

  def destroy?
    edit? 
  end

  def start_practice?
    user.present? # Allow any authenticated user to start a practice exam
  end
end
