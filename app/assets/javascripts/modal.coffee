$ ->
  modal_holder_selector = "#modal-holder"

  $(document).on "click", "[data-behavior='modal']",(e) ->
    e.preventDefault()
    location = $(this).attr("href")
    $.get location, (data) ->
      $(modal_holder_selector).html(data).find(".modal").modal().modal("open")
      false

  $(document).on "ajax:success", "[data-behavior='modal-form']", (event, data, status, xhr) ->
    url = xhr.getResponseHeader("Location")
    
    if url
      window.location = url
    else
      $(".modal").modal("hide")

    false
