class Team < ActiveRecord::Base
    require 'csv'
	has_and_belongs_to_many :users, :join_table => :teams_users
	has_many :feedbacks
  belongs_to :course
	belongs_to :instructor
  validates :name, uniqueness: { case_sensitive: false, scope: :course_id, message: "Team name exists"}

  def self.import(file, course_id, current_user)
      all_errors = []
       CSV.foreach(file.path, headers: true) do |row|
          puts row
          puts row.to_hash
          puts row.to_hash["team_name"]
          course = Course.find(course_id)
          team = Team.create ({:name => row.to_hash["team_name"], :course_id => course_id})
          if !team.save
            all_errors << "Team name #{row.to_hash["team_name"]} exists"
            next
          end
          team.users << current_user
          puts team.users
          for key in row.to_hash.keys
            if key != "team_name" and !row.to_hash[key].blank?
              sid = row.to_hash[key]
              student = User.where(user_id: row.to_hash[key]).first
              if student.nil?
                all_errors << "Student with SID: #{sid} does not exist"
              elsif !course.users.include? student
                all_errors <<  "Student with SID: #{sid} is not enrolled in this class"
              elsif team.users.include? student
                all_errors << "Student with SID: #{sid} is being added more than once"
              else
                team.users << student
              end
            end
          end
          #puts team.users
       end
       all_errors
   end
end
