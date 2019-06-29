form = null
menu = null

search = () ->
  if menu
    menu.remove()
    
  if form.val().length == 0
    return
  
  list = []
  urls = {}
  done = false
  for ambig in [0..2]
    console.log ambig
    a = new Asearch(' ' + form.val() + ' ', ambig)
    for entry in data['faqs']
      title = entry['title']
      url = entry['url']
      if a.match title
        unless urls[url]
          urls[url] = true
          list.push entry
          if list.length > 10
            done = true
            break
    break if done

  menu = $('<div>').css('background-color','#dff')
  $('#search_box').append(menu)
  for entry in list
    a = $('<a>')
    a.attr 'href', entry['url']
    a.text entry['title']
    li = $('<li>')
    li.append a
    menu.append li

$ ->
  form = $("#rn_KeywordText2_Y1_0_Text")
  form.on 'keyup', search
