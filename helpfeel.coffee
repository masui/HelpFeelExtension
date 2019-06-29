form = null
menu = null

search = () ->
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

  if menu
    menu.remove()
    
  menu = $('<div>').css('background-color','#dff')
  $('#search_box').append(menu)
  for entry in list
    a = $('<a>')
    a.attr 'href', entry['url']
    a.text entry['title']
    li = $('<li>')
    li.append a
    menu.append li
  
  # menu.text("ここに#{form.val()}のHelpfeel検索結果を表示")

$ ->
  form = $("#rn_KeywordText2_Y1_0_Text")
  form.on 'keyup', search

  # alert data['faqs'][0]['title']

