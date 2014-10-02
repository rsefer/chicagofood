$ ->
  $(document).on 'change', '#eat_item_id', (evt) ->

    if $('#eat_item_id').val()
      $.ajax '/venues_controller/update_item_rating_display',
        type: 'GET'
        dataType: 'script'
        data: {
          item_id: $('#eat_item_id option:selected').val()
        }
    else
      $('#active-eat-item-rating').empty()
