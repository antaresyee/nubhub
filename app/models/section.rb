class Section < ActiveRecord::Base
  attr_accessible :campus, 
  					:capacity, 
  					:career, 
  					:class_number, 
  					:course_id, 
  					:description, 
  					:enrollment, 
  					:grading, 
  					:list_description, 
  					:location, 
  					:name, 
  					:required_sections, 
  					:room, 
  					:synopsis, 
  					:units, 
  					:waitlist_capacity, 
  					:waitlist_enrollment


  has_and_belongs_to_many :instructors
  belongs_to :course
  has_many :notes

end
