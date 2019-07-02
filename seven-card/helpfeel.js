// Generated by CoffeeScript 2.3.2
var form, menu, search;

form = null;

menu = null;

search = function() {
  var a, entry, i, len, li, result, results;
  console.log(form.val());
  if (menu) {
    menu.remove();
  }
  if (form.val().length === 0) {
    return;
  }
  result = searchFAQ(form.val());
  menu = $('<div>').css('background-color', '#dff').css('max-height', '160px').css('overflow', 'scroll').css('float', 'left');
  // $('#keyword_form').append(menu)
  $('.oneCol.okw_parts_search').append(menu);
// $('.colArea.clearfix').append(menu)
// $('.icoKeyword').append(menu)
// $('.search_frmArea').append(menu)
  results = [];
  for (i = 0, len = result.length; i < len; i++) {
    entry = result[i];
    a = $('<a>');
    a.attr('href', entry['faq']['url']);
    a.text(entry['faq']['title']);
    li = $('<li>').css('font-size', '12px');
    li.append(a);
    results.push(menu.append(li));
  }
  return results;
};

$(function() {
  var style;
  form = $("#keyword_text_field");
  form.on('keyup', search);
  form.on('mousedown', search);
  style = $('<style>');
  style.text("a:visited, a:link { color: #22f; }");
  return $('head').append(style);
});
