filter_box = null

$ ->
  filter_box = $(".defaultText")

$ ->
  filter_box.focus =>
    filter_box.removeClass("defaultText")
    filter_box.addClass("filter")
    filter_box.val("")
    $('input.filter').quicksearch('table.index_table tbody tr.tr_body')

$ ->
  filter_box.blur =>
    if(filter_box.val() == "")
      filter_box.removeClass("filter")
      filter_box.addClass("defaultText")
      filter_box.val("Filter")
