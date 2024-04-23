class ExamsController < ApplicationController
  before_action :set_exam, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  def index
    @exams = Exam.all
  end

  def practice
    @practice_exam = PracticeExam.find(params[:id])
    # Check if the current user owns this practice exam
    unless current_user == @practice_exam.user
      redirect_to root_path, alert: "You are not authorized to view this practice exam."
      return
    end
  end

  def show
    set_meta_tags @exam
  end

  def new
    @exam = Exam.new
  end

  def edit
  end

  def start_practice
    @exam = Exam.find(params[:id])
    quiz_length = params[:exam][:max_num_questions].to_i
    
    @practice_exam = @exam.start_practice_for_user(current_user, quiz_length)
    
    redirect_to practice_path(@practice_exam)
  end

  def create
    @exam = Exam.new(exam_params)
    respond_to do |format|
      if @exam.save
        format.html { redirect_to exam_url(@exam), notice: "Exam was successfully created." }
        format.json { render :show, status: :created, location: @exam }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @exam.update(exam_params)
        format.html { redirect_to exam_url(@exam), notice: "Exam was successfully updated." }
        format.json { render :show, status: :ok, location: @exam }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @exam.destroy
    respond_to do |format|
      format.html { redirect_to exams_url, notice: "Exam was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_exam
    @exam = Exam.find(params[:id])
  end

  def exam_params
    params.require(:exam).permit(:name, :max_num_questions, :max_duration)
  end
end
