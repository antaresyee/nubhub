#!/usr/bin/ruby
require 'json'
require 'pp'

namespace :db do 
	namespace :course do
		desc "Populate database with course information"
		task :populate => :environment do
			parse_json()
		end
	end

	COURSES_JSON = 'courses.json'

	def parse_json()
		json_string = File.read(COURSES_JSON)
		course_info = JSON.parse(json_string)
		course_info.each do |ci|
			Course.create(
				cid: ci['id'],
				year: ci['year'].to_i,
				term: ci['term'],
				department: ci['department'],
				number: ci['couse_number'].to_i,
				name: ci['course_name']
			)
		end
	end
end