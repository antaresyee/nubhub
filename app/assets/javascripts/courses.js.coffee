
jQuery -> 
	$(".btn-follow-course").click ->
		classes = this.className.split ' '
		if "btn-unfollow-course" in classes
			$(this).removeClass("btn-warning")
			$(this).removeClass("btn-unfollow-course")
			$(this).text("Follow")
			$(this).addClass("btn-success")
			$(this).addClass("btn-follow-course")
		else if "btn-follow-course" in classes
			$(this).removeClass("btn-success")
			$(this).removeClass("btn-follow-course")
			$(this).text("Unfollow")
			$(this).addClass("btn-warning")
			$(this).addClass("btn-unfollow-course")
