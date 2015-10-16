class TimeSerie < ActiveRecord::Base
	belongs_to :province
	has_many :indicator_variables
end
