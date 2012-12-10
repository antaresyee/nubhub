
jQuery ->
	prepareEventHandlers()

prepareEventHandlers = () ->
	checkState()
	onClickFollowing()
	onClickUploads()


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
		alert('WORKING')
		displayFollowing()
		e.preventDefault()
	)

displayFollowing = () ->
	toggleTab("following")
	$("#uploads_container").hide()
	$("#following_container").show()


onClickUploads = () ->
	$("#uploads_tab").live('click', (e)->
		displayUploads()
		e.preventDefault()
	)

displayUploads = () ->
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


onShowModal = () ->
	$(".upload_notes_button").live('click', (e)->
		$("#myModal").modal('show')
	)



