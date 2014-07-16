# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  if $('body.activities_show').length > 0
    $("#address").change ->
      id = $("select#address :selected").val()
      window.location.href = window.location.pathname + "?address=" + id