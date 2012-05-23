//= require active_admin/base
//= require handlebars
//= require bootstrap-tabs
//= require ckeditor/init
//= require chosen.jquery

$(function(){
  $('select').chosen();
  $('.tabbable a:first').tab('show');
  jsFormInit($('.js-form-init'));
  $('.js-form-add').on('click', function(e) {
    e.preventDefault();
    var association = $(this).attr('data-association'),
    template = Handlebars.compile($('#' + association + '_form_template').html()),
    idRegExp = new RegExp('new_' + association, 'g'),
    id = new Date().getTime(),
    number = $(this).parent().siblings('li').size() + 1,
    container = $(this).parent();
    
    container.before(template({ number: number }).replace(idRegExp, id));
  });
  $('input[name="remove_photo"]').on('click', function(e) {
    $(this).siblings('input').val($(this).is(':checked'));
  });
});

var jsFormInit = function(el) {
  el || (el = $('.js-form-init'));
  var inputs = el.find('li.input');
  inputs.each(function(i, t) {
    var template = Handlebars.compile($(t).html());
    $(t).html(template({ number: i+1 }));
  });
  el.find('li:not(.input)').before(inputs);
};