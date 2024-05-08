# Maybe look intoo nesting Questions in Exams 
class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit update destroy ]
  include AuthenticationConcern
  def index
    @questions = Question.all
    authorize @questions
  end

  def show
    authorize @question
  end

  def new
    @question = Question.new
    authorize @question
  end

  def edit
    authorize @question
  end

  def create
    @question = Question.new(question_params)
    authorize @question
    respond_to do |format|
      if @question.save
        format.html { redirect_to question_url(@question), notice: "Question was successfully created." }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @question
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to question_url(@question), notice: "Question was successfully updated." }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @question
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: "Question was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:exam_id, :prompt)
  end
end
