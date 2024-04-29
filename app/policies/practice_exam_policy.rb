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
  
  def index?
    user.present? # Allow any authenticated user to access the index action
  end

  def show?
    user.present? && record.user == user # Allow only the owner to view the practice exam
  end

  def new?
    user.present? 
  end

  def create?
    new? 
  end

  def edit?
    user.present? && record.user == user # Allow only the owner to edit the practice exam
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def submit_practice?
    user.present? && record.user == user # Allow only the owner to submit the practice exam
  end
end
