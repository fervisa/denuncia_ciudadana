# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

@limpiarFormulario = () ->
  $('input[type=text], textarea').val('')
  $('select').each ->
    this.selectedIndex = 0
  $('select').selectmenu('refresh', true)
  $('textarea').html('')

@cargaLimpiarFormulario = () ->
  $('#confirm-clean a#clean-form').click () =>
    @limpiarFormulario()
    $('#confirm-clean').popup('close')
    
$(document).on 'pageinit', (e) ->
  $('form#new_denuncia').on 'submit', ->
    $(this).append $('#archivos').hide()
