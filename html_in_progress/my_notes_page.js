//@author antaresyee

var state = "following";

$(document).ready(function() {
	prepareEventHandlers();
});

function prepareEventHandlers() {
	onClickFollowing();
	onClickUploads();
}

function onClickFollowing() {
	$("#following_tab").click(function() {
		displayFollowing();
	});
}

function displayFollowing() {
	if (state == "following") {
		return;
	}
	state = "following";

	toggleTab("following");
	$("#uploads_container").css("display","none");
	$("#following_container").css("display","block");

	//AJAX HERE
}

function onClickUploads() {
	$("#uploads_tab").click(function() {
		displayUploads();
	});
}

function displayUploads() {
	if (state == "uploads") {
		return;
	}
	state = "uploads";

	toggleTab("uploads");
	$("#following_container").css("display","none");
	$("#uploads_container").css("display","block");

	//AJAX HERE
}

function toggleTab(tab) {
	if (tab == "following") {
		$("#following_tab").css("background-color","#0F46AD");
		$("#uploads_tab").css("background-color","#1C54BD");
	}
	if (tab == "uploads") {
		$("#uploads_tab").css("background-color","#0F46AD");
		$("#following_tab").css("background-color","#1C54BD");
	}
}



