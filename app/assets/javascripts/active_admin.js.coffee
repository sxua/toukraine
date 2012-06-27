#= require active_admin/base
#= require handlebars
#= require bootstrap-tabs
#= require ckeditor/init
#= require chosen.jquery

$ ->
  $('select').chosen()
  $('.tabbable a:first').tab('show')
  jsFormInit $('.js-form-init')
  $('.js-form-add').on 'click', (e)->
    e.preventDefault()
    association = $(this).attr('data-association')
    template = Handlebars.compile $("##{association}_form_template").html()
    idRegExp = new RegExp("new_#{association}", 'g')
    id = new Date().getTime()
    container = $(this).parent()
    number = container.siblings('li.input.file').size() + 1

    container.before template({ number: number }).replace(idRegExp, id)

  $('input[name="remove_photo"], input[name="remove_primary_photo"]').on 'click', (e)->
    $(this).siblings('input').val $(this).is(':checked')

window.jsFormInit = (el)->
  el ||= $('.js-form-init')
  inputs = el.find('li.input.file')

  inputs.each (i, t)->
    template = Handlebars.compile $(t).html()
    $(t).html template({ number: i+1 })

  el.find('li:not(.input)').before inputs