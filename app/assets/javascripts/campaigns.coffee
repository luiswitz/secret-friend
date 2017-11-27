$(document).on 'turbolinks:load', ->
  $('.update_campaign input').bind 'blur', ->
    $('.update_campaign').submit()

  $('.update_campaign').on 'submit', (e) ->
    $.ajax e.target.action,
      type: 'PUT'
      dataType: 'JSON'
      data: $('.update_campaign').serialize()
      success: (data, text, jqXHR) ->
        Materialize.toast('Campaign Updated', 4000, 'green')
      error: (jqXHR, textStatus, errorThrown) ->
        Materialize.toast('Error', 4000, 'red')
    return false

  $('.remove_campaign').on 'submit', (e) ->
    $.ajax e.target.action,
      type: 'DELETE'
      dataType: 'JSON'
      data: {}
      success: (data, text, jqXHR) ->
        $(location).attr('href','/campaigns')
      error: (jqXHR, textStatus, errorThrown) ->
        Materialize.toast('Error', 4000, 'red')
    return false

  ('.raffle_campaign').on 'submit', (e) ->
    $.ajax e.target.action,
      type: 'POST'
      dataType: 'json',
      data: {}
      success: (data, text, jqXHR) ->
        Materialize.toast('Cool! Sonn all participants will recive an e-mail with instructions', 4000, 'green')
      error: (jqXHR, textStatus, errorThrown) ->
        Materialize.toast(jqXHR.responseText, 4000, 'red')
    return false
