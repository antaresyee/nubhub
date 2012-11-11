class NoteBookedRelationship < ActiveRecord::Base
	attr_accessible	:user_id,
					:course_id 
	belongs_to 	:user, 
				class_name: 'User'
	belongs_to 	:course, 
				class_name: 'Course'
end
