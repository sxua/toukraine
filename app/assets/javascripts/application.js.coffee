#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require fotorama
#= require select2
#= require spin
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

window.get = (url, callback)->
  window.request('GET', url, callback)

window.post = (url, callback)->
  window.request('POST', url, callback)

window.request = (method, url, callback)->
  method ||= 'GET'
  startSpinner()
  $.ajax({
    url: url,
    type: method,
    dataType: 'html'
  }).done (html)->
    callback.call(undefined, html)
    $('select').select2()
    stopSpinner()

window.startSpinner = ->
  body = $('#order_form .modal-body')
  spinner.spin(body[0])
  body.css('opacity', 0.5)

window.stopSpinner = ->
  body = $('#order_form .modal-body')
  spinner.stop()
  body.css('opacity', 1.0)

window.setCities = (callback)->
  relative_type = $('input[name="order[relative_type]"]:checked').val().toLowerCase()
  post "/#{locale}/orders/cities/#{relative_type}", (html)->
    $('#city').html(html)
    callback.call()

window.updateOrderFields = ->
  relative_type = $('input[name="order[relative_type]"]:checked').val().toLowerCase()
  city_id = $('#city').val()
  post "/#{locale}/orders/relatives/#{relative_type}/#{city_id}", (html)->
    list = $('#order_relative_id')
    list.html(html)
    if html.trim().length > 0
      list.removeAttr('disabled')
    else
      list.attr('disabled', 'disabled')

window.setRelativeLabel = ->
  relative_label = $('input[name="order[relative_type]"]:checked').parent().text()
  $('label[for="order_relative_id"]').html("<abbr title='required'>*</abbr> #{relative_label}")

window.setOrderForm = (html)->
  $('#order_form .modal-body').html(html)
  $('select').select2()

window.spinner = new Spinner {
  lines: 11,
  length: 7,
  width: 2,
  radius: 5,
  top: 0,
  left: 0,
  color: '#444'
}

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
    get "/#{locale}/orders/new", (html)-> setOrderForm(html)

  $('#order_form').on 'hide', ->
    $('.fotorama').show()
    $('#placeholder').hide()
    $(this).find('.modal-body').html('')

  $('input[name="order[relative_type]"]').live 'change', ->
    setRelativeLabel()
    setCities ->
      updateOrderFields()

  $('#city').live 'change', ->
    updateOrderFields()

  $('#order_submit').on 'click', (e)->
    e.preventDefault()
    $('#new_order').submit()


  $('#new_order')
    .live('ajax:complete', (e, xhr)->
      setOrderForm(xhr.responseText)
      stopSpinner()
      $('#order_form .modal-footer').hide() if xhr.status == 200
    ).live('ajax:beforeSend', ()->
      startSpinner()
    )