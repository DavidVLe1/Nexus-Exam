class PracticeExamsController < ApplicationController
  before_action :set_practice_exam, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /practice_exams or /practice_exams.json
  def index
    @practice_exams = current_user.practice_exams.page params[:page]
  end

  # GET /practice_exams/1 or /practice_exams/1.json
  def show
    @practice_exam = current_user.practice_exams.find_by(id: params[:id])
    if @practice_exam.nil?
      redirect_to root_path, alert: "You are not authorized to view this practice exam."
    else
      # Eager loading to reduce amount of database queries.
      @practice_exam = PracticeExam.includes(assembled_exam_questions: :question).find(params[:id])
    end
  end

  # GET /practice_exams/new
  def new
    @practice_exam = PracticeExam.new
  end

  # GET /practice_exams/1/edit
  def edit
  end

  #POST that updates that initial practice exam.
  def submit_practice
    @practice_exam = PracticeExam.find(params[:id])

    ## user answers are submitted as array of choice IDs in the params
    user_answers = params[:assembled_exam_questions]
    score = ScoreCalculator.calculate(user_answers, @practice_exam)
    Time.zone = "Central Time (US & Canada)"

    @practice_exam.update(
      score: score,
      end_time: Time.zone.now,
    )
    redirect_to practice_exam_path(@practice_exam), notice: "Practice exam submitted successfully."
  end

  # POST /practice_exams or /practice_exams.json
  def create
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

  # PATCH/PUT /practice_exams/1 or /practice_exams/1.json
  def update
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

  # DELETE /practice_exams/1 or /practice_exams/1.json
  def destroy
    @practice_exam.destroy

    respond_to do |format|
      format.html { redirect_to practice_exams_url, notice: "Practice exam was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_practice_exam
    @practice_exam = PracticeExam.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def practice_exam_params
    params.require(:practice_exam).permit(:exam_id, :user_id, :custom_max_num_questions, :custom_max_duration, :start_time, :end_time, :score)
  end


end
