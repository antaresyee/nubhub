var allBreadcrumbs = [$("#university"), $("#first_slash"), $("#department"), $("#second_slash"), $("#course")];

$("document").ready(function() {
	prepareEventHandlers();
	displayDepartments();	
});

function prepareEventHandlers() {
	//breadcrumbs
	onClickDepartment();
	onClickUniversity();
	//choose selection from container
	onChooseCourse();
	onChooseDepartment();
}

function onClickDepartment() {
	var department = $("#department");
	department.click(function() {displayCourses()});
}

function onClickUniversity() {
	var university = $("#university");
	university.click(function() {displayDepartments()});
}

function onChooseCourse() {
	$(".courses_line_name").click(function(){
		displayNotes($(this));
	});
}

function onChooseDepartment() {
	$(".departments_line_name").click(function(){
		displayCourses($(this));
	});
}

function displayNotes(course_li) {
	//style breadcrumb
	styleBreadcrumb($("#course"));

	//change container
	$("#courses_container").css("display", "none");
	$("#departments_container").css("display", "none");
	$("#notes_container").show('slide', {direction: 'right'}, 300);

	//fill container (AJAX)
	console.log(course_li.text());
	$.ajax({
  		url: "INSERT PATH TO BACKEND SCRIPT HERE",
  		type: "POST",
  		data: {context: course_li.text()}
	}).done(function(html) {
  		$("#notes_container").append(html);
	});
}

function displayCourses(department_li) {
	//style breadcrumb
	styleBreadcrumb($("#department"));

	//hide breadcrumbs
	$("#course").css("display", "none");
	$("#second_slash").css("display", "none");

	//change container
	$("#notes_container").css("display", "none");
	$("#departments_container").css("display", "none");
	$("#courses_container").show('slide', {direction: 'right'}, 300);

	//fill container (AJAX)
	console.log(department_li.text());
	$.ajax({
  		url: "INSERT PATH TO BACKEND SCRIPT HERE",
  		type: "POST",
  		data: {context: department_li.text()}
	}).done(function(html) {
  		$("#courses_container").append(html);
	});
}

function displayDepartments() {
	//style breadcrumb
	styleBreadcrumb($("#university"));

	//hide breadcrumbs
	$("#course").css("display", "none");
	$("#first_slash").css("display", "none");
	$("#department").css("display", "none");		
	$("#second_slash").css("display", "none");

	//change container
	$("#notes_container").css("display", "none");
	$("#courses_container").css("display", "none");
	$("#departments_container").show('slide', {direction: 'right'}, 300);

	//fill container (AJAX)
	$.ajax({
  		url: "INSERT PATH TO BACKEND SCRIPT HERE",
  		type: "POST"
	}).done(function(html) {
  		$("#departments_container").append(html);
	});

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
	breadcrumb.css("font-weight", "bold");
	breadcrumb.hover(function(){$(this).css("cursor", "text")}, function(){$(this).css("cursor", "pointer")});
}

