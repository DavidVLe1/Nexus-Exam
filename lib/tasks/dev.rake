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

  #Rake::Task['db:seed'].invoke
  questions = [
    "What is the primary purpose of AWS Identity and Access Management (IAM)?",
    "What is the minimum billable duration for an Amazon EC2 instance that is launched and terminated within a single minute?",
    "Which AWS service is used to deploy and manage Docker containers?",
    "What is the maximum size for a single object that can be uploaded to Amazon S3?",
    "What type of database service does Amazon RDS provide?",
    "What AWS service allows you to deploy serverless functions?",
    "What is the AWS Shared Responsibility Model?",
    "What is the purpose of Amazon CloudFront?",
    "Which AWS service is used to monitor and collect logs from various AWS resources?",
    "What is the purpose of AWS Lambda?",
    "What is the purpose of Amazon S3?",
    "Which AWS service is used to distribute incoming traffic across multiple targets?",
    "What is the default region for an AWS account?",
    "What is the maximum size for a single file system that Amazon EFS supports?",
    "What type of storage does Amazon S3 provide?",
    "What is AWS Elastic Beanstalk?",
    "What is the purpose of AWS Glacier?",
    "Which AWS service is used to create and manage virtual networks?",
    "What does AWS Lambda allow you to run?",
    "What is the purpose of AWS CloudFormation?",
    "What is the maximum duration for an AWS Lambda function?",
    "What is AWS CloudTrail used for?",
    "What is the purpose of AWS Direct Connect?",
    "What is an AWS Availability Zone?",
    "What is the AWS Free Tier?",
    "What is the purpose of Amazon EC2 Auto Scaling?",
    "Which AWS service provides a fully managed blockchain ledger database?",
    "What is AWS Snowball used for?",
    "Which AWS service allows you to query your data using SQL?",
    "What is the purpose of AWS Elastic Load Balancing?",
    "Which AWS service provides a fully managed NoSQL database?",
    "What is the primary purpose of Amazon RDS Multi-AZ deployments?",
    "What is the maximum duration for an Amazon RDS snapshot retention period?",
    "What is the AWS Marketplace?",
    "What is AWS Snowball Edge used for?",
    "Which AWS service is used to deploy and manage containerized applications?",
    "What is AWS CodePipeline used for?",
    "What is Amazon CloudWatch used for?",
    "What is the AWS Management Console?",
    "What is the purpose of Amazon Route 53?",
    "Which AWS service is used to create and manage serverless APIs?",
    "What is AWS Organizations?",
    "What is the difference between Amazon RDS and Amazon Redshift?",
    "What is AWS Glue used for?",
    "What is Amazon Aurora?",
    "What is AWS CloudHSM?",
    "What is the purpose of AWS Storage Gateway?",
    "What is AWS AppSync?",
    "What is Amazon ECS Fargate?",
    "What is the AWS Command Line Interface (CLI)?",
    "What is AWS KMS?",
    "What is Amazon SNS?",
    "What is AWS Step Functions?",
    "What is Amazon EMR used for?",
    "What is the AWS Well-Architected Framework?",
    "What is AWS Shield?",
    "What is Amazon Lightsail?",
    "What is AWS X-Ray?",
    "What is AWS Cloud9?",
    "What is Amazon Cognito?",
    "What is the purpose of AWS Organizations?",
    "What is AWS Batch used for?",
    "What is AWS OpsWorks?",
    "What is Amazon Elasticsearch Service used for?",
    "What is AWS Cost Explorer?",
  ]

  # Create questions in the database

  ## Correct answers for the questions
  correct_answers = [
    "To manage user access and permissions in AWS",
    "1 minute",
    "Amazon ECS (Elastic Container Service)",
    "5 TB",
    "Relational database service",
    "AWS Lambda",
    "Defines the security controls AWS maintains, and those the customer must configure and manage",
    "Content delivery network (CDN)",
    "Amazon CloudWatch",
    "Run code without provisioning or managing servers",
    "To store and retrieve data from the internet",
    "Elastic Load Balancing (ELB)",
    "us-east-1 (N. Virginia)",
    "16 TB",
    "Object storage",
    "A platform as a service (PaaS) offering",
    "To store data for long-term archival",
    "Amazon VPC (Virtual Private Cloud)",
    "Run code in response to events without provisioning or managing servers",
    "To provision and manage AWS infrastructure as code",
    "15 minutes",
    "To track user activity and API usage",
    "To establish a dedicated network connection from your premises to AWS",
    "A distinct location within a region with independent power, cooling, and networking",
    "A tier of AWS services available to new customers at no charge for a limited time",
    "To automatically adjust the number of EC2 instances based on demand",
    "Amazon Managed Blockchain",
    "To transfer large amounts of data into and out of AWS",
    "To distribute incoming traffic across multiple targets",
    "Amazon Athena",
    "To distribute incoming traffic across multiple targets",
    "Amazon DynamoDB",
    "To provide high availability and failover support",
    "35 days",
    "An online software store that helps customers find, buy, and immediately start using software and services that run on AWS",
    "To transfer large amounts of data into and out of AWS in areas with limited connectivity",
    "Amazon Elastic Container Service (ECS)",
    "To automate the continuous integration and continuous delivery (CI/CD) pipeline",
    "To monitor AWS resources and applications in real time",
    "A web-based interface for managing AWS services",
    "A scalable cloud DNS web service",
    "Amazon API Gateway",
    "To centrally manage and govern multiple AWS accounts",
    "Amazon RDS is a relational database service while Amazon Redshift is a fully managed data warehouse service",
    "A fully managed extract, transform, and load (ETL) service",
    "A MySQL and PostgreSQL-compatible relational database built for the cloud",
    "A service that provides hardware security modules (HSMs) for key management and cryptographic operations",
    "To connect on-premises software applications with cloud-based storage",
    "A fully managed GraphQL service",
    "A compute engine for deploying and managing containers without having to manage the underlying infrastructure",
    "A command-line tool for interacting with AWS services",
    "AWS Key Management Service for managing cryptographic keys",
    "Amazon Simple Notification Service for sending messages and notifications",
    "A serverless function orchestrator that makes it easy to sequence AWS Lambda functions",
    "A big data platform for processing and analyzing vast amounts of data",
    "A set of best practices and guidelines for building secure, high-performing, resilient, and efficient infrastructure for AWS",
    "A managed Distributed Denial of Service (DDoS) protection service",
    "A virtual private server (VPS) service that offers a simplified way to deploy and manage servers on AWS",
    "A distributed tracing service that helps developers analyze and debug distributed applications",
    "An integrated development environment (IDE) for writing, running, and debugging code",
    "An identity service that provides authentication, authorization, and user management for web and mobile applications",
    "AWS Organizations is a service that allows you to centrally manage and govern multiple AWS accounts.",
    "AWS Batch is a fully managed batch processing service for running batch computing workloads.",
    "AWS OpsWorks is a configuration management service that helps automate the deployment and scaling of applications using Chef and Puppet.",
    "Amazon Elasticsearch Service is a fully managed service for deploying, operating, and scaling Elasticsearch clusters for search and analytics use cases.",
    "AWS Cost Explorer is a tool for visualizing, understanding, and managing AWS costs and usage, helping users analyze their AWS spending patterns and identify cost optimization opportunities.",
  ]
  # Create questions in the database
  questions.zip(correct_answers).each do |q, correct_answer|
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
  selected_questions = Question.all.sample(3)

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

  p "There are now #{User.count} users."
  p "There are now #{Exam.count} exams."
  p "There are now #{Question.count} questions."
  p "There are now #{QuestionChoice.count} choices."
  p "There are now #{AssembledExamQuestion.count} assembled questions for exams."
  p "There are now #{PracticeExam.count} practice exam."
end
