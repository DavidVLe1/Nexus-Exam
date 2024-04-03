require "csv"
desc "Fill the database tables with some sample data"
task sample_data: :environment do
  p "Resetting sample data"

  # Delete child records
  AssembledExamQuestion.delete_all
  QuestionChoice.delete_all
  PracticeExam.delete_all

  # Delete parent records
  Question.delete_all
  Exam.delete_all
  User.delete_all
  p "Creating sample data"

  csv_file_path = Rails.root.join("db", "data", "nexus_exam_data.csv")
  csv_data = CSV.read(csv_file_path, headers: true)

  people = Array.new(3) do
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      username: "#{Faker::Name.first_name.downcase}#{rand(100..999)}",
    }
  end
  people << { first_name: "Alice", last_name: "Smith", username: "alice123" }
  people << { first_name: "Bob", last_name: "Smith", username: "bob456" }

  people.each do |person|
    user = User.create(
      email: "#{person[:first_name].downcase}@example.com",
      password: "password",
      username: person[:username],
      first_name: person[:first_name],
      last_name: person[:last_name].strip, # Trim any leading/trailing whitespace
    )
  end

  # Generated Exams.
  aws_exam = Exam.create(
    name: "AWS Cloud Practitioner",
    max_num_questions: 65, #how many questions
    max_duration: 90, #max number of mintutes
  )

  # Generated Questions.
  questions = []
  correct_answers = []

  csv_data.each do |row|
    correct_answer = row["correct_answer"]
    csv_question = row["prompt"]

    next if correct_answer.blank?

    # Find or create the question based on the prompt
    question = Question.find_or_create_by(prompt: csv_question, exam: aws_exam)

    correct_answers << correct_answer

    correct_choice = QuestionChoice.create(question: question, response: correct_answer, is_correct: true)
    incorrect_choices = [row["incorrect_choice_1"], row["incorrect_choice_2"], row["incorrect_choice_3"]]

    incorrect_choices.each do |incorrect_choice|
      QuestionChoice.create(question: question, response: incorrect_choice, is_correct: false)
    end
  end

  selected_user = User.all.sample

  practice_exam = PracticeExam.create(
    exam: aws_exam,
    user: selected_user,
    custom_max_num_questions: 10,
    custom_max_duration: 10,
    start_time: Time.now,
  )

  selected_questions = Question.all.sample(10)

  # Create associated AssembledExamQuestions for this practice exam
  selected_questions.each do |question|
    choices = question.question_choices.to_a

    correct_choice = choices.find(&:is_correct)

    incorrect_choices = choices.reject { |choice| choice.is_correct }

    selected_choices = [correct_choice] + incorrect_choices.take(3)

    selected_choices.shuffle!.each do |choice|
      AssembledExamQuestion.create(
        practice_exam: practice_exam,
        question: question,
        question_choice: choice,
      )
    end
  end

  # Assuming the exam is completed or submitted, and with score calculated...
  # User finished with 90% and the exam ended 5 minutes after it started
  score = 90
  end_time = Time.now + 5.minutes

  # Update the initial practice exam instance with the calculated score and end time
  practice_exam.update(score: score, end_time: end_time)

  p "There are now #{User.count} users."
  p "There are now #{Exam.count} exams."
  p "There are now #{Question.count} questions."
  p "There are now #{QuestionChoice.count} choices."
  p "There are now #{AssembledExamQuestion.count} possible choices for the selected #{AssembledExamQuestion.select(:question_id).distinct.count} questions for exams."
  p "There are now #{PracticeExam.count} practice exam."
end
