document.addEventListener('DOMContentLoaded', function() {
  var countdownElement = document.getElementById('countdown-timer');
  var maxDuration = parseInt(countdownElement.dataset.maxDuration)*60;
  var endTime = new Date().getTime() + maxDuration * 1000; // Calculate end time based on max duration in seconds

  function updateCountdown() {
    var currentTime = new Date().getTime();
    var timeDifference = endTime - currentTime;

    if (timeDifference <= 0) {
      // If time runs out, force submit the form
      document.querySelector('form').submit();
    } else {
      var minutes = Math.floor((timeDifference % (1000 * 60 * 60)) / (1000 * 60));
      var seconds = Math.floor((timeDifference % (1000 * 60)) / 1000);

      countdownElement.innerHTML = 'Time remaining: ' + minutes + 'm ' + seconds + 's';
    }
  }

  updateCountdown();
  setInterval(updateCountdown, 1000); // Update countdown every second
});
