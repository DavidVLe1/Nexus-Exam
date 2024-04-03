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

  #Access the CSV.
  csv_file_path = Rails.root.join("db", "data", "nexus_exam_data.csv")
  csv_data = CSV.read(csv_file_path, headers: true)

  # Generated Users
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
  # Create questions in the database
  csv_questions = []
  correct_answers=[]
  # Create questions in the database
  csv_data.each do |row|
    correct_answer = row["correct_answer"]
    csv_question = row["prompt"] # This line fetches the data from the 'prompt' column
    # Skip empty questions or missing correct answers
    next if csv_question.blank? || correct_answer.blank?

    correct_answers << correct_answer
    csv_questions << csv_question  # Uncomment this line to store the questions
  end
  puts csv_questions.count
  puts correct_answers.count
  # Create questions in the database
  csv_questions.zip(correct_answers).each do |q, correct_answer|
    a_question = Question.create(
      exam: aws_exam,
      prompt: q,
    )

    # Create question choices in the database.
    QuestionChoice.create(
      question: a_question,
      response: correct_answer,
      is_correct: true,
    )
    ## Create three incorrect choices
    incorrect_choices = correct_answers.reject { |choice| choice == correct_answer }
    3.times do
      incorrect_choice = incorrect_choices.sample
      QuestionChoice.create(
        question: a_question,
        response: incorrect_choice,
        is_correct: false,
      )
      # Remove the selected incorrect choice from the array to ensure it's not selected again
      incorrect_choices.delete(incorrect_choice)
    end
  end
  ########

  # Select a random user from the generated users array
  selected_user = User.all.sample
  # Create a new instance of PracticeExam
  practice_exam = PracticeExam.create(
    exam: aws_exam,
    user: selected_user,
    custom_max_num_questions: 10,
    custom_max_duration: 10,
    start_time: Time.now,
  )

  # Select a subset of questions and their corresponding choices for this practice exam
  selected_questions = Question.all.sample(10)

  # Create associated AssembledExamQuestions for this practice exam
  selected_questions.each do |question|
    # Fetch all choices associated with the current question
    choices = question.question_choices.to_a

    # Fetch the correct choice for the current question
    correct_choice = choices.find(&:is_correct)

    # Remove the correct choice from the array
    choices.delete(correct_choice)

    # Shuffle the remaining choices to randomize the order
    choices.shuffle!

    # Take the correct choice and three false choices
    selected_choices = [correct_choice] + choices.take(3)

    # Create an AssembledExamQuestion for each selected choice
    selected_choices.each do |choice|
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
