class AssembledExamQuestionsController < ApplicationController
  before_action :set_assembled_exam_question, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  def index
    @assembled_exam_questions = AssembledExamQuestion.all
  end

  def show
  end

  def new
    @assembled_exam_question = AssembledExamQuestion.new
  end

  def edit
  end

  def create
    @assembled_exam_question = AssembledExamQuestion.new(assembled_exam_question_params)
    respond_to do |format|
      if @assembled_exam_question.save
        format.html { redirect_to assembled_exam_question_url(@assembled_exam_question), notice: "Assembled exam question was successfully created." }
        format.json { render :show, status: :created, location: @assembled_exam_question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @assembled_exam_question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @assembled_exam_question.update(assembled_exam_question_params)
        format.html { redirect_to assembled_exam_question_url(@assembled_exam_question), notice: "Assembled exam question was successfully updated." }
        format.json { render :show, status: :ok, location: @assembled_exam_question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @assembled_exam_question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @assembled_exam_question.destroy
    respond_to do |format|
      format.html { redirect_to assembled_exam_questions_url, notice: "Assembled exam question was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_assembled_exam_question
    @assembled_exam_question = AssembledExamQuestion.find(params[:id])
  end

  def assembled_exam_question_params
    params.require(:assembled_exam_question).permit(:practice_exam_id, :question_id, :question_choice_id)
  end
end
