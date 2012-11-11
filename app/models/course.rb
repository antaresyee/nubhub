class Course < ActiveRecord::Base
	attr_accessible :cid, :year, :term, :department, :number, :name

	searchable do 
		string :name
		string :department	
	end
end
