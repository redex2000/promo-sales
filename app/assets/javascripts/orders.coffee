mainHandler = ->
    $(document).on 'click', 'button[name="button"]', ->
      console.log('test')
      $.ajax(
        url: "/promo_codes/activate",
        type: 'get',
        data: {promo_code: {code: $('#code').val()}, order: { cost: $('#order_cost').val() } },
        error: (event, jqXHR, msg, err) ->
          $('#messages').append('<div class="error">'+jqXHR.responseText+'</div>')
      )

# Необходимо обрабатывать различные события, вследствие использования turbolinks, для ускорения выполнения CSS/JS
# при переходе по ссылкам
$(document).ready ->
  mainHandler();

$(document).on('page:load') ->
  mainHandler();

