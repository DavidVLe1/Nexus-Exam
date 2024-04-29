class PracticeExamsController < ApplicationController
  before_action :set_practice_exam, only: %i[ show edit update destroy ]

  def index
    authorize PracticeExam
    @practice_exams = current_user.practice_exams.page params[:page]
    @breadcrumbs = [
      { content: "Home", href: root_path },
      { content: "Practice Exams", href: practice_exams_path}
    ]
  end

  def show
    authorize @practice_exam
    @practice_exam = current_user.practice_exams.find_by(id: params[:id])
    @breadcrumbs = [
      { content: "Home", href: root_path },
      { content: "Practice Exams", href: practice_exams_path},
      { content: "#{@practice_exam.user.first_name}'s Results", href: practice_exams_path(@practice_exam)}
    ]
    if @practice_exam.nil?
      redirect_to root_path, alert: "You are not authorized to view this practice exam."
    else
      @practice_exam = PracticeExam.includes(assembled_exam_questions: :question).find(params[:id])
    end
  end

  def new
    authorize PracticeExam
    @practice_exam = PracticeExam.new
  end

  def edit
    authorize @practice_exam
  end

  def submit_practice
    @practice_exam = PracticeExam.find(params[:id])
    authorize @practice_exam
  
    user_answers = params[:assembled_exam_questions]
    
    @practice_exam.submit(user_answers)
    
    redirect_to practice_exam_path(@practice_exam), notice: "Practice exam submitted successfully."
  end

  def create
    authorize PracticeExam
    @practice_exam = PracticeExam.new(practice_exam_params)
    respond_to do |format|
      if @practice_exam.save
        format.html { redirect_to practice_exam_url(@practice_exam), notice: "Practice exam was successfully created." }
        format.json { render :show, status: :created, location: @practice_exam }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @practice_exam.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @practice_exam
    respond_to do |format|
      if @practice_exam.update(practice_exam_params)
        format.html { redirect_to practice_exam_url(@practice_exam), notice: "Practice exam was successfully updated." }
        format.json { render :show, status: :ok, location: @practice_exam }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @practice_exam.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @practice_exam
    @practice_exam.destroy
    respond_to do |format|
      format.html { redirect_to practice_exams_url, notice: "Practice exam was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_practice_exam
    @practice_exam = PracticeExam.find(params[:id])
  end

  def practice_exam_params
    params.require(:practice_exam).permit(:exam_id, :user_id, :custom_max_num_questions, :custom_max_duration, :start_time, :end_time, :score)
  end
end
