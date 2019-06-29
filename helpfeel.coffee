form = null
menu = null

search = () ->
  console.log form.val()
  # menuにHelpfeel検索結果を出す

$ ->
  form = $("#rn_KeywordText2_Y1_0_Text")
  form.on 'keydown', search
  menu = $('<div>').text('abcde').css('background-color','#ffd')
  $('#search_box').append(menu)
