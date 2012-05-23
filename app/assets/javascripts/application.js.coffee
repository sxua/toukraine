#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require fotorama
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