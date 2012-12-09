class NoteUploadRelationship < ActiveRecord::Base
 	attr_accessible	:note_id, :course_id
	belongs_to 	:note, 		class_name: 'Note'
	belongs_to 	:course, 	class_name: 'Course' 
end
