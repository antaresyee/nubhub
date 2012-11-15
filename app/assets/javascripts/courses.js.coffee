
jQuery -> 
	$(".btn-follow-course").click ->
		classes = this.className.split ' '
		if "btn-unfollow-course" in classes
			$(this).removeClass("btn-warning")
			$(this).removeClass("btn-unfollow-course")
			$(this).parent().parent().attr("method", "post")
			$(this).attr("value", "Follow")
			$(this).addClass("btn-success")
			$(this).addClass("btn-follow-course")
		else if "btn-follow-course" in classes
			$(this).removeClass("btn-success")
			$(this).removeClass("btn-follow-course")
			$(this).parent().parent().attr("method", "delete")
			$(this).attr("value", "Unfollow");
			$(this).addClass("btn-warning")
			$(this).addClass("btn-unfollow-course")

jQuery -> 
	$(".btn-unfollow-course").click ->
		classes = this.className.split ' '
		if "btn-unfollow-course" in classes
			$(this).removeClass("btn-warning")
			$(this).removeClass("btn-unfollow-course")
			$(this).parent().parent().attr("method", "post")
			$(this).attr("value", "Follow")
			$(this).addClass("btn-success")
			$(this).addClass("btn-follow-course")
		else if "btn-follow-course" in classes
			$(this).removeClass("btn-success")
			$(this).removeClass("btn-follow-course")
			$(this).parent().parent().attr("method", "delete")
			$(this).attr("value", "Unfollow");
			$(this).addClass("btn-warning")
			$(this).addClass("btn-unfollow-course")

