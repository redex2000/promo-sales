$(document).ready ->
    $('button[name="button"]').click ->
      $.ajax(
        url: "/promo_codes/activate",
        type: 'get',
        data: {promo_code: {code: $('#code').val()}, order: { cost: $('#order_cost').val() } },
        error: (event, jqXHR, msg, err) ->
          $('#messages').append('<div class="error">'+jqXHR.responseText+'</div>')
      )
