

checkFlash = () ->
	flash = $("#flash")
	alert(flash.html())
	if flash.html() != ""
		flash.hide()
	else
		flash.show()