form = null
menu = null

search = () ->
  menu.text("ここに#{form.val()}のHelpfeel検索結果を表示")

$ ->
  form = $("#rn_KeywordText2_Y1_0_Text")
  form.on 'keyup', search
  menu = $('<div>').css('background-color','#ffd')
  $('#search_box').append(menu)
