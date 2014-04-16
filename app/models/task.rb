class Task < ActiveRecord::Base
	validates :label, :presence => true
	validates :category, :presence => true

	belongs_to :category
	
end
