jQuery ->
	$("#add_course").live('click', (e)->
		$.ajax({
			type: "POST",
			url: "/noted_booked_relationships?course=" + $(this).attr("data-courseid")
			dataType: "html"
		})
	)