# Would `ResponsesController` be a better name for this controller? Or something along this
class QuestionChoicesController < ApplicationController
  include AuthenticationConcern
  before_action :set_question_choice, only: %i[ show edit update destroy ]
  def index
    @question_choices = QuestionChoice.all
    authorize @question_choices
  end

  def show
    authorize @question_choice
  end

  def new
    @question_choice = QuestionChoice.new
    authorize @question_choice
  end

  def edit
    authorize @question_choice
  end

  def create
    @question_choice = QuestionChoice.new(question_choice_params)
    authorize @question_choice
    respond_to do |format|
      if @question_choice.save
        format.html { redirect_to question_choice_url(@question_choice), notice: "Question choice was successfully created." }
        format.json { render :show, status: :created, location: @question_choice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @question_choice
    respond_to do |format|
      if @question_choice.update(question_choice_params)
        format.html { redirect_to question_choice_url(@question_choice), notice: "Question choice was successfully updated." }
        format.json { render :show, status: :ok, location: @question_choice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @question_choice
    @question_choice.destroy
    respond_to do |format|
      format.html { redirect_to question_choices_url, notice: "Question choice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_question_choice
    @question_choice = QuestionChoice.find(params[:id])
  end

  def question_choice_params
    params.require(:question_choice).permit(:response, :is_correct, :question_id)
  end
end
