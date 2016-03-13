mainHandler = ->
    $(document).on 'click', 'button[name="button"]', ->
      $.ajax(
        url: "/promo_codes/activate",
        type: 'get',
        data: {promo_code: {code: $('#code').val()}, order: { cost: $('#order_cost').val() } },
        error: (jqXHR, msg, err) ->
          console.log('error'+jqXHR.responseText)
          $('#messages')
            .append('<div class="alert alert-danger fade in"><a class="close" data-dismiss="alert" aria-label="close" href="#">×</a>'+jqXHR.responseText+'</div>');
      )

# Необходимо обрабатывать различные события, вследствие использования turbolinks, для ускорения выполнения CSS/JS
# при переходе по ссылкам
$(document).ready ->
  mainHandler();

$(document).on('page:load', mainHandler);

