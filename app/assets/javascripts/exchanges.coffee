# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('#form').submit ->
    calc()
  $('#amount').change ->
    calc()

  $('#changecurr').click ->
    console.log('trocando')
    sourceCurrency = $("#source_currency").val()
    $("#source_currency").val($("#target_currency").val())
    $("#target_currency").val(sourceCurrency)
    calc()
  $('#source_currency').change ->
    calc()
  $('#target_currency').change ->
    calc()

calc = ->
  if $('form').attr('action') == '/convert'
    $.ajax '/convert',
        type: 'GET'
        dataType: 'json'
        data: {
                source_currency: $("#source_currency").val(),
                target_currency: $("#target_currency").val(),
                amount: $("#amount").val()
              }
        error: (jqXHR, textStatus, errorThrown) ->
          alert textStatus
        success: (data, text, jqXHR) ->
          $('#result').val(data.value)
      return false;
