$(function() {
  var countdownElement = $('#countdown-timer');
  var maxDuration = parseInt(countdownElement.data('maxDuration')) * 60;
  var endTime = new Date().getTime() + maxDuration * 1000; // Calculate end time based on max duration in seconds

  function updateCountdown() {
      var currentTime = new Date().getTime();
      var timeDifference = endTime - currentTime;

      if (timeDifference <= 0) {
          // If time runs out, force submit the form
          $('form').submit();
      } else {
          var minutes = Math.floor((timeDifference % (1000 * 60 * 60)) / (1000 * 60));
          var seconds = Math.floor((timeDifference % (1000 * 60)) / 1000);

          countdownElement.html('Time remaining: ' + minutes + 'm ' + seconds + 's');
      }
  }

  updateCountdown();
  setInterval(updateCountdown, 1000); // Update countdown every second
});
