form = null
menu = null

search = () ->
  if menu
    menu.remove()
    
  if form.val().length == 0
    return

  if false
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

  result = searchFAQ(form.val())

  menu = $('<div>').css('background-color','#dff')
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
