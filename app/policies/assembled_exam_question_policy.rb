class AssembledExamQuestionPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    user.present? 
  end

  def show?
    user.present? 
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

end
