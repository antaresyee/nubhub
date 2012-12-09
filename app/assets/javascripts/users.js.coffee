state = "following"

jQuery ->
	prepareEventHandlers()

prepareEventHandlers = () ->
	checkState()
	onClickFollowing()
	onClickUploads()
	onRemoveCourse()


checkState = () ->
	state = $("#my_notes_content_container")
	if state.hasClass("following")
		$("#uploads_container").hide()
		$("#following_container").show()
	else
		$("#following_container").hide()
		$("#uploads_container").show()


onClickFollowing = () ->
	$("#following_tab").live('click', (e)->
		displayFollowing()
		e.preventDefault()
	)

displayFollowing = () ->
	if state == "following"
		return
	state = "following"
	toggleTab("following")
	$("#uploads_container").hide()
	$("#following_container").show()


onClickUploads = () ->
	$("#uploads_tab").live('click', (e)->
		displayUploads()
		e.preventDefault()
	)

displayUploads = () ->
	if state == "uploads"
		return
	state = "uploads"
	toggleTab("uploads")
	$("#following_container").hide()
	$("#uploads_container").show()


toggleTab = (tab) ->
	if tab == "following"
		$("#following_tab").css("background-color","#0F46AD");
		$("#uploads_tab").css("background-color","#1C54BD");
	else if tab == "uploads"
		$("#uploads_tab").css("background-color","#0F46AD");
		$("#following_tab").css("background-color","#1C54BD");


onRemoveCourse = () ->
	$(".remove_class").live('click', (e)->
		removeElement($(this).parent(".content_line"))
		e.preventDefault()
	)

removeElement = (element) ->
	element.hide()


onShowModal = () ->
	$(".upload_notes_button").live('click', (e)->
		alert("WORKING")
		$("#myModal").modal('show')
	)



