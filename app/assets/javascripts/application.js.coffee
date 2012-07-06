#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require fotorama
#= require select2
#= require_tree .

window.fotoramaDefaults = {
  vertical: true,
  navPosition: 'right',
  loop: true,
  cropToFit: true,
  thumbSize: 154,
  thumbMargin: 0,
  thumbBorderWidth: 2,
  thumbBorderColor: '#5F98B2',
  autoplay: true,
  touchStyle: false,
  arrows: false,
  onClick: (data)-> window.open(data.captionUrl, '_blank') if data.captionUrl
}

window.updateOrderFields = ->
  relative_type = $('input[name="order[relative_type]"]:checked').val().toLowerCase()
  city_id = $('#city').val()
  $.ajax({
    url: "/#{locale}/orders/relatives/#{relative_type}/#{city_id}",
    type: 'POST',
    dataType: 'html'
  }).done (data)->
    list = $('#order_relative_id')
    list.html(data)
    if data.trim().length > 0
      list.removeAttr('disabled')
    else
      list.attr('disabled', 'disabled')
    list.select2()

window.setRelativeLabel = ->
  relative_label = $('input[name="order[relative_type]"]:checked').parent().text()
  $('label[for="order_relative_id"]').html("<abbr title='required'>*</abbr> #{relative_label}")

$ ->
  $('.fotorama__thumb').on 'mouseover', ->
    fotorama = $('.fotorama').fotorama()
    index = $(this).parent().children('.fotorama__thumb').index($(this))
    fotorama.trigger 'showimg', index

  $('a[href="#location"]').on 'shown', (e)->
    showMap()

  $('a[href="#photos"]').on 'shown', (e)->
    $('.fotorama-init').fotorama {
      vertical: false,
      thumbSize: 64,
      touchStyle: true,
      arrows: true,
      onClick: null,
      thumbMargin: 3,
      thumbBorderWidth: 3
    }

  $('#order_form').on 'show', ->
    $('.fotorama').hide()
    $('#placeholder').show()
    $.ajax({
      url: "/#{locale}/orders/new"
    }).done (data)->
      $('#order_form .modal-body').html(data)
      $('select').select2()

  $('#order_form').on 'hide', ->
    $('.fotorama').show()
    $('#placeholder').hide()
    $('#order_form .modal-body').html('')

  $('input[name="order[relative_type]"]').live 'change', ->
    setRelativeLabel()
    updateOrderFields()

  $('#city').live 'change', ->
    updateOrderFields()

  $('#order_submit').on 'click', (e)->
    e.preventDefault()
    $('#new_order').submit()

  $('#new_order').live 'ajax:success', (e, xhr, status)->
    $('#order_form .modal-body').html(xhr)
    $('select').select2()