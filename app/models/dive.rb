class Dive < ActiveRecord::Base
	validates :location, :user_id, :date, :length, presence: true
end
