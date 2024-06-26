# Exam Management System

Welcome to the Exam Management System! This application allows users to create and take exams, track their progress, and manage their account details.

## Features

- **User Authentication**: Users can sign up, log in, and log out securely using Devise.
- **Exam Creation**: Admins can create exams with customizable parameters such as the number of questions and duration.
- **Practice Exams**: Users can take practice exams based on predefined exam templates.
- **Question Bank**: A repository of questions for admins to choose from when creating exams.
- **Multiple Choice**: Support for multiple-choice questions with correct and incorrect options.
- **Exam Timer**: Countdown timer for users to complete exams within a specified time limit.
- **Scoring**: Automatic scoring and feedback for completed exams.
- **User Profiles**: Users can view and update their profile details, including username, first name, and last name.
## Demo

Here's a brief demo of the Exam Management System in action:

![nexus-exam-full-demo](https://github.com/DavidVLe1/nexus-exam/assets/43181047/7930a1f5-3f69-45f9-9441-647340acc19a)
## Installation

1. Clone the repository:
- ```git clone https://github.com/yourusername/exam-management-system.git```
2. Install dependencies:
- ```bundle install```
3. Set up the database:
- ```rails db:create```
- ```rails db:migrate```
4. Start the Rails server:
- ```rails server```
- or ```bin/dev```
5. Access the application in your web browser at 
- `http://localhost:3000`.
## Usage

1. Sign up for a new account or log in if you already have one.
2. Explore the available exams and select one to take.
3. Complete the exam within the allotted time and submit your answers.
4. View your exam scores and track your progress in the charts dashboard.

## ERD

Here's the Entity-Relationship Diagram (ERD) for the Exam Management System:
![325851135-8d4cc75c-6312-496e-b705-ad5853e5023b](https://github.com/DavidVLe1/nexus-exam/assets/43181047/518deac3-b551-4339-a4c5-50eb40648ebf)

### FAQs or Troubleshooting:

#### Q: Can I reset my password if I forget it?

A: Currently, our application does not support password reset functionality. We apologize for any inconvenience this may cause. If you encounter any issues with your account or have questions, please reach out to our support team at [nexusexam@yahoo.com](mailto:nexusexam@yahoo.com) for assistance.

#### Q: Can I retake an exam?

A: Yes, you can retake an exam. To retake an exam, simply navigate to the exam you wish to retake by searching through the practice exam index. Once you find the exam you want to retake, copy the path to the exam, which should look like "practice/#" where # is the number associated with your exam. Then, paste this path into your browser's address bar and press Enter to start the exam again.

#### Q: Where are the questions sourced from?

A: The questions available in our system are sourced from a variety of reliable resources related to the specific exam topics. We retrieve information from these sources and use it to generate questions using natural language processing techniques. Our system aims to provide a comprehensive set of questions that cover various aspects of the exam topics to help users prepare effectively.

#### Q: What exams will be available next in the future?

A: In the near future, we plan to introduce two new exams to our platform: the AWS Solutions Architect exam and the AWS Cloud Developer exam. These exams will cover key concepts and skills required for roles in cloud architecture and development within the AWS ecosystem. Stay tuned for updates on their availability!

#### Q: What big updates will be implemented next?

A: We have exciting plans for future updates! We're considering implementing two major features:

1. **Leaderboard with Flashcard Style Game**: We're exploring the idea of adding a leaderboard feature along with a flashcard-style game. In this game, users can try to answer as many flashcards correctly as possible within a set time limit. Each correct answer earns points, and users are placed on the leaderboard based on their performance and how quickly they answer each question.

2. **Integration with OpenAI for Feedback**: Another feature we're considering is the integration of OpenAI for feedback on user form submissions. This would allow users to receive AI-generated feedback on their answers, providing valuable insights and guidance for improvement.

Stay tuned for updates on these exciting additions to our platform!

## Contributing

Thank you for considering contributing to the Exam Management System! Contributions from developers like you help improve the project and make it better for everyone. Before you get started, please take a moment to review the following guidelines:

### Coding Conventions

- **Classes**: Use CamelCase for class names.
- **Symbols, Methods, and Variables**: Use snake_case.
- **Constants**: Use ALL_UPPERCASE_LETTERS_AND_UNDERSCORES for constants.

### Branch Naming Conventions

When creating Git branches for your contributions, please follow these naming conventions:
- Use your initials followed by a hyphen (`-`) and a descriptive action noun.
- Use lowercase letters for your initials, action, and nouns.
- Separate words in the action and noun with hyphens (`-`).
- For example, a branch for adding a user table could be named `as-add-user-table`.

### Pull Request Process

1. Fork the repository and create a new branch for your feature, bug fix, or enhancement.
2. Ensure your changes adhere to the coding conventions outlined above.
3. Write descriptive commit messages that clearly explain the purpose of your changes.
4. Submit a pull request with a clear title and description of the changes.
5. Participate in the code review process and address any feedback provided by maintainers.

### Testing Guidelines

- Write tests for your code changes.
- Include both unit tests and integration tests as appropriate.
- Ensure all tests pass before submitting a pull request.

### Documentation

- Update project documentation to reflect any changes made to code or functionality.
- Include clear and concise comments in your code to aid understanding for future contributors.

### Issue Tracking

- Check for open issues and assign yourself to issues you plan to work on.
- Create new issues for bugs, feature requests, or enhancements as needed.
- Link your pull requests to related issues to provide context and track progress.

