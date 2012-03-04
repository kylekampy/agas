# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
  $('#appointment_datetimepicker_start').datetimepicker({
        ampm: true,
        stepMinute: 15
  });

$ ->
  $('#appointment_datetimepicker_end').datetimepicker({
        ampm: true,
        stepMinute: 15
  });
