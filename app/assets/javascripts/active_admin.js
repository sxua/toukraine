//= require active_admin/base
//= require bootstrap-tabs
//= require ckeditor/init
//= require chosen.jquery

$(function(){
  $('select').chosen();
  $('.tabbable a:first').tab('show');
});