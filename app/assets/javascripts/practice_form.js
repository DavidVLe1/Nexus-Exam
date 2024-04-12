document.addEventListener('DOMContentLoaded', function() {
  const questions = document.querySelectorAll('.question-body');
  const previousButton = document.querySelector('.previous-button');
  const nextButton = document.querySelector('.next-button');
  const submitButton = document.querySelector('.submit-button');

  let currentQuestionIndex = 0;
  questions[currentQuestionIndex].classList.remove('hidden');
  
  previousButton.addEventListener('click', function() {
    questions[currentQuestionIndex].classList.add('hidden');
    currentQuestionIndex--;
    questions[currentQuestionIndex].classList.remove('hidden');
    updateButtonVisibility();
  });
  
  nextButton.addEventListener('click', function() {
    questions[currentQuestionIndex].classList.add('hidden');
    currentQuestionIndex++;
    questions[currentQuestionIndex].classList.remove('hidden');
    updateButtonVisibility();
  });
  
  function updateButtonVisibility() {
    previousButton.classList.toggle('hidden', currentQuestionIndex === 0);
    nextButton.classList.toggle('hidden', currentQuestionIndex === questions.length - 1);
    submitButton.classList.toggle('hidden', currentQuestionIndex !== questions.length - 1);
  }
});
