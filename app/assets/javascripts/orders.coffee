$(document).ready ->
    $('form[action="/promo_codes/activate"]').on('ajax:error', (event, jqXHR, msg, err) ->
        $('#messages').append('<div class="error">'+jqXHR.responseText+'</div>')
    )
