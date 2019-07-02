form = null
menu = null

search = () ->
  console.log form.val()
  
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
  # $('#keyword_form').append(menu)
  $('.oneCol.okw_parts_search').append(menu)
  # $('.colArea.clearfix').append(menu)
  # $('.icoKeyword').append(menu)
  # $('.search_frmArea').append(menu)
  for entry in result
    a = $('<a>')
    a.attr 'href', entry['faq']['url']
    a.text entry['faq']['title']
    li = $('<li>').css('font-size','12px')
    li.append a
    menu.append li

$ ->
  form = $("#keyword_text_field")
  form.on 'keyup', search
  form.on 'mousedown', search

  style = $('<style>')
  style.text("a:visited, a:link { color: #22f; }")
  $('head').append(style)

