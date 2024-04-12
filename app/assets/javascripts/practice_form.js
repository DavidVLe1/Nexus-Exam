$(function() {
  const questions = $('.question-body');
  const previousButton = $('.previous-button');
  const nextButton = $('.next-button');
  const submitButton = $('.submit-button');

  let currentQuestionIndex = 0;
  questions.eq(currentQuestionIndex).removeClass('hidden');

  previousButton.on('click', function() {
      questions.eq(currentQuestionIndex).addClass('hidden');
      currentQuestionIndex--;
      questions.eq(currentQuestionIndex).removeClass('hidden');
      updateButtonVisibility();
  });

  nextButton.on('click', function() {
      questions.eq(currentQuestionIndex).addClass('hidden');
      currentQuestionIndex++;
      questions.eq(currentQuestionIndex).removeClass('hidden');
      updateButtonVisibility();
  });

  function updateButtonVisibility() {
      previousButton.toggleClass('hidden', currentQuestionIndex === 0);
      nextButton.toggleClass('hidden', currentQuestionIndex === questions.length - 1);
      submitButton.toggleClass('hidden', currentQuestionIndex !== questions.length - 1);
  }
});
