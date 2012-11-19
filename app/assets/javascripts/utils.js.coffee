$(document).click ->
	$.lastClicked = $(this)
	$('.test').html(this.href)