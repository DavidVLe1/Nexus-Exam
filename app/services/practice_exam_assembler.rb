class PracticeExamAssembler
  #Creates assembled exam questions
  def self.assemble(practice_exam)
    quiz_length = practice_exam.custom_max_num_questions
    selected_questions = select_random_questions(quiz_length)
    selected_questions.each do |question|
      selected_choices = select_choices(question)
      create_assembled_exam_questions(practice_exam, question, selected_choices)
    end
  end

  # Selects random questions from the database
  def self.select_random_questions(num_questions)
    return Question.all.sample(num_questions)
  end

  # Selects choices for a given question
  def self.select_choices(question)
    choices = question.question_choices.to_a
    correct_choice = choices.find(&:is_correct)

    incorrect_choices = choices.reject { |choice| choice.is_correct }

    selected_choices = [correct_choice] + incorrect_choices.take(3)
    return selected_choices
  end

  # Creates assembled exam questions in the database
  def self.create_assembled_exam_questions(practice_exam, question, selected_choices)
    selected_choices.each do |choice|
      AssembledExamQuestion.create(
        practice_exam: practice_exam,
        question: question,
        question_choice: choice,
      )
    end
  end
end
