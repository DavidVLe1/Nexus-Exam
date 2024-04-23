class ScoreCalculator
  # Calculates the user's score on the practice exam.
  def self.calculate(user_answers, practice_exam)
    return 0 if user_answers.nil? || practice_exam.assembled_exam_questions.empty?

    total_questions = practice_exam.assembled_exam_questions.pluck(:question_id).uniq.count
    correct_answers = 0

    practice_exam.assembled_exam_questions.each do |assembled_exam_question|
      user_choice_id = user_answers[assembled_exam_question.id.to_s]
      correct_choice_id = assembled_exam_question.question.question_choices.find_by(is_correct: true)&.id
      correct_answers += 1 if user_choice_id.to_i == correct_choice_id
    end

    return (correct_answers / total_questions.to_f) * 100
  end
end
