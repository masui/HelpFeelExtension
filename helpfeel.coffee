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
    .css('height','160px')
    .css('overflow','scroll')
  $('#search_box').append(menu)
  for entry in result
    a = $('<a>')
    a.attr 'href', entry['faq']['url']
    a.text entry['faq']['title']
    li = $('<li>')
    li.append a
    menu.append li

$ ->
  form = $("#rn_KeywordText2_Y1_0_Text")
  form.on 'keyup', search
  form.on 'mousedown', search

  style = $('<style>')
  style.text("a:visited, a:link { color: #22f; }")
  $('head').append(style)

