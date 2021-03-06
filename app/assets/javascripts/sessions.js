# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function() {

  var showTokenForm = function() {
    $('.auth-ot').fadeOut(function() {
      $('.auth-token').fadeIn('slow');
    });
  };

  var triggerSMSToken = function() {
    $.get('/authy/send_token');
  };

  var checkForOneTouch = function() {
    $.get('/authy/status', function(data) {
      if (data === 'approved') {
        window.location.href = '/account';
      } else if (data === 'denied') {
        showTokenForm();
        triggerSMSToken();
      } else {
        setTimeout(checkForOneTouch, 2000);
      }
    });
  };

  var attemptOneTouchVerification = function(form) {
    $.post('/sessions', form, function(data) {
      $('#authy-modal').modal({backdrop:'static'},'show');
      if (data.success) {
        $('.auth-ot').fadeIn();
        checkForOneTouch();
      } else {
        $('.auth-token').fadeIn();
      }
    });
  };

  $('#login-form').submit(function(e) {
    e.preventDefault();
    var formData = $(e.currentTarget).serialize();
    attemptOneTouchVerification(formData);
  });
});