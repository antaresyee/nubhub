
jQuery -> 
	$(".btn-follow-course").click ->
			$(this).removeClass("btn-success")
			$(this).removeClass("btn-follow-course")
			$(this).parent().parent().attr("method", "delete")
			$(this).attr("value", "Unfollow");
			$(this).addClass("btn-warning")
			$(this).addClass("btn-unfollow-course")

jQuery -> 
	$(".btn-unfollow-course").click ->
			$(this).removeClass("btn-warning")
			$(this).removeClass("btn-unfollow-course")
			$(this).parent().parent().attr("method", "post")
			$(this).attr("value", "Follow")
			$(this).addClass("btn-success")
			$(this).addClass("btn-follow-course")

