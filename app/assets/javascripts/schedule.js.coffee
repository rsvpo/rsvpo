# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  if $('body.schedule_index').length > 0
    $("#activity").change ->
      id = $("select#activity :selected").val()
      window.location.href = window.location.pathname + "?activity=" + id