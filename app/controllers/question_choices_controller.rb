class QuestionChoicesController < ApplicationController
  before_action :set_question_choice, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  # GET /question_choices or /question_choices.json
  def index
    @question_choices = QuestionChoice.all
  end

  # GET /question_choices/1 or /question_choices/1.json
  def show
  end

  # GET /question_choices/new
  def new
    @question_choice = QuestionChoice.new
  end

  # GET /question_choices/1/edit
  def edit
  end

  # POST /question_choices or /question_choices.json
  def create
    @question_choice = QuestionChoice.new(question_choice_params)

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

  # PATCH/PUT /question_choices/1 or /question_choices/1.json
  def update
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

  # DELETE /question_choices/1 or /question_choices/1.json
  def destroy
    @question_choice.destroy

    respond_to do |format|
      format.html { redirect_to question_choices_url, notice: "Question choice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question_choice
    @question_choice = QuestionChoice.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def question_choice_params
    params.require(:question_choice).permit(:response, :is_correct, :question_id)
  end
end
