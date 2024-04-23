class ExamsController < ApplicationController
  before_action :set_exam, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /exams or /exams.json
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

  # GET /exams/1 or /exams/1.json
  def show
    set_meta_tags @exam
  end

  # GET /exams/new
  def new
    @exam = Exam.new
  end

  # GET /exams/1/edit
  def edit
  end

  # POST that creates initial practice exam.
  def start_practice
    @exam = Exam.find(params[:id])
    quiz_length = params[:exam][:max_num_questions].to_i
    if quiz_length == 10
      max_duration = 15
    else
      max_duration = 90
    end
    Time.zone = "Central Time (US & Canada)"

    @practice_exam = PracticeExam.create(
      exam: @exam,
      user: current_user,
      custom_max_num_questions: quiz_length,
      custom_max_duration: max_duration,
      start_time: Time.zone.now,
    )
    PracticeExamAssembler.assemble(@practice_exam)
    # Redirect the user to the page where you render the practice exam form
    redirect_to practice_path(@practice_exam)
  end

  # POST /exams or /exams.json
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

  # PATCH/PUT /exams/1 or /exams/1.json
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

  # DELETE /exams/1 or /exams/1.json
  def destroy
    @exam.destroy

    respond_to do |format|
      format.html { redirect_to exams_url, notice: "Exam was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_exam
    @exam = Exam.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def exam_params
    params.require(:exam).permit(:name, :max_num_questions, :max_duration)
  end
end
