//@author antaresyee

var allBreadcrumbs = [$("#university"), $("#first_slash"), $("#department"), $("#second_slash"), $("#course")];
var state = 0;

$("document").ready(function() {
	prepareEventHandlers();	
});

function prepareEventHandlers() {
	//breadcrumbs
	onClickDepartment();
	onClickUniversity();
	//choose selection from container
	onChooseCourse();
	onChooseDepartment();
}

function onClickUniversity() {
	var university = $("#university");
	university.click(function() {
		displayDepartments();
		state = 0;
	});
}

function onClickDepartment() {
	var department = $("#department");
	department.click(function() {
		displayCourses();
		state = 1;
	});
}

function onChooseDepartment() {
	$(".departments_line_name").click(function(){
		displayCourses($(this));
		state = 1;
	});
}

function onChooseCourse() {
	$(".courses_line_name").click(function(){
		displayNotes($(this));
		state = 2;
	});
}

function displayDepartments() {
	if (state == 0) {
		return;
	}

	styleBreadcrumb($("#university"));

	//hide breadcrumbs
	$("#course").css("display", "none");
	$("#first_slash").css("display", "none");
	$("#department").css("display", "none");		
	$("#second_slash").css("display", "none");

	//change container
	$("#notes_container").css("display", "none");
	$("#courses_container").css("display", "none");

	if (state > 0) {
		$("#departments_container").show('slide', {direction: 'left'}, 300);
	}
	else {
		$("#departments_container").show('slide', {direction: 'right'}, 300);
	}

	//AJAX HERE
}

function displayCourses(department_li) {
	if (state == 1) {
		return;
	}

	styleBreadcrumb($("#department"));

	//hide breadcrumbs
	$("#course").css("display", "none");
	$("#second_slash").css("display", "none");

	//change container
	$("#notes_container").css("display", "none");
	$("#departments_container").css("display", "none");
	if (state > 1) {
		$("#courses_container").show('slide', {direction: 'left'}, 300);
	}
	else {
		$("#courses_container").show('slide', {direction: 'right'}, 300);
	}

	//AJAX HERE
}

function displayNotes(course_li) {
	if (state == 2) {
		return;
	}

	styleBreadcrumb($("#course"));

	//change container
	$("#courses_container").css("display", "none");
	$("#departments_container").css("display", "none");
	$("#notes_container").show('slide', {direction: 'right'}, 300);

	//AJAX HERE
}

function styleBreadcrumb(breadcrumb) {
	//unstyle others
	for (var i=0; i<allBreadcrumbs.length; i++) {
		allBreadcrumbs[i].css("display", "inline");
		allBreadcrumbs[i].css("color", "#FFFFFF");
		allBreadcrumbs[i].css("font-weight", "normal");
		allBreadcrumbs[i].hover(function(){$(this).css("cursor", "pointer")}, function(){$(this).css("cursor", "pointer")});
	}
	$("#first_slash").hover(function(){$(this).css("cursor", "text")}, function(){$(this).css("cursor", "pointer")});
	$("#second_slash").hover(function(){$(this).css("cursor", "text")}, function(){$(this).css("cursor", "pointer")});
	
	//style breadcrumb
	breadcrumb.css("color", "#ACC6F4");
	breadcrumb.hover(function(){$(this).css("cursor", "text")}, function(){$(this).css("cursor", "pointer")});
}

