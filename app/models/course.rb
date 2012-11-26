class Course < ActiveRecord::Base
  
  attr_accessible :name, :new_number, :old_number

  validates :name,  :presence => true
  belongs_to :advanced_course, :class_name => "Course"

  has_many :sections
  has_many :instructors, :through => :sections, :uniq => :true

  belongs_to :session, :inverse_of => :courses
  belongs_to :subject

  has_many :note_booked_relationships
  has_many :users, through: :note_booked_relationships


  def toSingleCode
    if self.new_number!=nil
      return self.new_number
    else
      return self.old_number
    end
  end

  def descriptions
    set = Set.new []
    for section in self.sections
      set << section.description
    end
    return set.to_a
  end

  def course_attributes
    set = Set.new []
    for section in self.sections
      for attribute in section.course_attributes
        set << attribute
      end
    end
    return set.to_a
    
  end

  searchable do
    text :name, :boost => 5
    text :old_number
    text :new_number
    text :subject_abbr do
      if subject!=nil
        subject.abbr
      end
    end
    text :subject_name do
      if subject!=nil
        subject.name
      end
    end
    text :subject_alias do
      if subject!=nil
        subject.alias
      end
    end
    text :instructors do
      instructors.map(&:name)
    end
    text :descriptions, :boost => 4
    text :attribute_abbreviations do
      course_attributes.map(&:abbr)
    end
    text :attribute_names do
      course_attributes.map(&:name)
    end
    text :attribute_scrape_value do
      course_attributes.map(&:scrape_value)
    end
    string :attributes, :multiple => true do
      stringarray = []
      for attribute in course_attributes
        if attribute.abbr!=nil
          stringarray << attribute.abbr
        end
        if attribute.scrape_value!=nil
          stringarray << attribute.scrape_value
        end
        if attribute.name!=nil
          stringarray << attribute.name
        end
      end
      stringarray
    end
  end

end
