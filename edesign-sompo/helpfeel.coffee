form = null
menu = null

search = () ->
  if menu
    menu.remove()
    
  if form.val().length == 0
    return

  result = searchFAQ(form.val())

  menu = $('<div>')
    .css('background-color','#dff')
    .css('max-height','160px')
    .css('overflow','scroll')
    .css('float','left')
  $('.searchKeyword').append(menu)
  for entry in result
    a = $('<a>')
    a.attr 'href', entry['faq']['url']
    a.text entry['faq']['title']
    li = $('<li>').css('font-size','12px')
    li.append a
    menu.append li

nullfunc = () ->

rmfunc = () ->
  $('#keyword').removeClass('SearchAssist')
  $(".sug_list").remove()

$ ->
  form = $("#keyword")
  form.on 'keyup', search
  form.on 'mousedown', search

  setInterval rmfunc, 200

  style = $('<style>')
  style.text("a:visited, a:link { color: #22f; }")
  $('head').append(style)

