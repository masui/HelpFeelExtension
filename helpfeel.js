// Generated by CoffeeScript 2.3.2
var form, menu, search;

form = null;

menu = null;

search = function() {
  var a, entry, i, len, li, result, results;
  if (menu) {
    menu.remove();
  }
  if (form.val().length === 0) {
    return;
  }
  result = searchFAQ(form.val());
  menu = $('<div>').css('background-color', '#dff').css('max-height', '160px').css('overflow', 'scroll');
  $('#search_box').append(menu);
  results = [];
  for (i = 0, len = result.length; i < len; i++) {
    entry = result[i];
    a = $('<a>');
    a.attr('href', entry['faq']['url']);
    a.text(entry['faq']['title']);
    li = $('<li>');
    li.append(a);
    results.push(menu.append(li));
  }
  return results;
};

$(function() {
  var style;
  form = $("#rn_KeywordText2_Y1_0_Text");
  form.on('keyup', search);
  form.on('mousedown', search);
  style = $('<style>');
  style.text("a:visited, a:link { color: #22f; }");
  return $('head').append(style);
});
